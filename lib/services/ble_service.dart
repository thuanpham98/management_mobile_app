// import 'dart:async';
// import 'dart:io';

// import 'package:app_settings/app_settings.dart';
// import 'package:esp_provisioning/esp_provisioning.dart';

// import 'package:flutter_ble_lib/flutter_ble_lib.dart';
// import 'package:get_it/get_it.dart';
// import 'package:logger/logger.dart';
// import '../constants/config.dart';
// import '../services/logger_service.dart';
// import '../services/permissions_service.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:location/location.dart';

// class BleService {
//   static BleService _instance;
//   static BleManager _bleManager;
//   static Logger log;
//   bool _isPowerOn = false;
//   StreamSubscription<ScanResult> _scanSubscription;
//   StreamSubscription<BluetoothState> _stateSubscription;
//   Peripheral selectedPeripheral;
//   String selectedId;
//   List<String> serviceUUIDs;
//   EspProv _prov;
//   StreamController<EspProv> _monitorStream;

//   static BleService getInstance() {
//     if (_instance == null) {
//       _instance = BleService();
//     }

//     if (_bleManager == null) {
//       _bleManager = BleManager();
//       log = GetIt.I<LoggerService>().getLog();
//     }
//     log.v('BleService started');
//     return _instance;
//   }

//   BleManager getMaganer() {
//     return _bleManager;
//   }

//   Future<BluetoothState> start() async {
//     if (_isPowerOn) {
//       BluetoothState state = await _waitForBluetoothPoweredOn();
//       log.i('Device power was on $state');
//       return state;
//     }
//     bool isPermissionOk = await checkBlePermissions();
//     if (!isPermissionOk) {
//       throw Future.error(Exception('Location permission not granted'));
//     }

//     log.v('createClient');
//     await _bleManager.createClient(
//         restoreStateIdentifier: "pas-ble-client",
//         restoreStateAction: (peripherals) {
//           peripherals?.forEach((peripheral) {
//             log.i("Restored peripheral: ${peripheral.name}");
//             peripheral.disconnectOrCancelConnection();
//             selectedPeripheral = peripheral;
//           });
//         });
//     log.v('enableRadio');
//     // if (Platform.isAndroid) {
//     //   await _bleManager.enableRadio();
//     // }

//     try {
//       BluetoothState state = await _waitForBluetoothPoweredOn();
//       _isPowerOn = state == BluetoothState.POWERED_ON;
//       if(!_isPowerOn){
//         if (Platform.isAndroid) {
//           await _bleManager.enableRadio();
//           _isPowerOn=true;
//         }
//       } 
//       return state;
//     } catch (e) {
//       log.e('Error ${e.toString()}');
//     }
//     return BluetoothState.UNKNOWN;
//   }

//   void selectId(String id) {
//     if (selectedId == null) {
//       selectedId = id;
//     }
//   }

//   void select(Peripheral peripheral) async {
//     var a = await selectedPeripheral?.isConnected();
//     if(a == true){
//       await selectedPeripheral?.disconnectOrCancelConnection();
//     }
//     selectedPeripheral = peripheral;
//     log.v('selectedPeripheral = $selectedPeripheral');
//   }

//   Future<bool> stop() async {
//     if (!_isPowerOn) {
//       return true;
//     }
//     _isPowerOn = false;
//     stopScanBle();
//     await _stateSubscription?.cancel();
//     await _scanSubscription?.cancel();
//     var a = await selectedPeripheral?.isConnected();
//     if(a == true){
//       await selectedPeripheral?.disconnectOrCancelConnection();
//     }

//     if (Platform.isAndroid) {
//       await _bleManager.disableRadio();
//     }
//     await _bleManager.destroyClient();
//     return true;
//   }

//   Stream<ScanResult> scanBle() {
//     stopScanBle();
//     return _bleManager.startPeripheralScan(
//         uuids: [TransportBLE.PROV_BLE_SERVICE],
//         scanMode: ScanMode.balanced,
//         allowDuplicates: true);
//   }

//   Future<void> stopScanBle() {
//     return _bleManager.stopPeripheralScan();
//   }

//   Future<EspProv> startProvisioning({Peripheral peripheral}) async {
//     if (!_isPowerOn) {
//       await _waitForBluetoothPoweredOn();
//     }
//     Peripheral p = peripheral ?? selectedPeripheral;
//     log.v('peripheral $p');
//     await _bleManager.stopPeripheralScan();
//     EspProv prov = EspProv(
//         transport: TransportBLE(p), security: Security1(pop: kApplicationPop, verbose: false));
//     try {
//     //   var success = 
//     await prov.establishSession();
//     //   if (!success) {
//     //     throw Exception('Error establishSession');
//     //   }
//     } catch (e) {
//       log.e('Error establishSession + ${e.toString()}');
//     }
//     return prov;
//   }

//   Future<BluetoothState> _waitForBluetoothPoweredOn() async {
//     Completer completer = Completer<BluetoothState>();
//     _stateSubscription?.cancel();
//     _stateSubscription = _bleManager
//         .observeBluetoothState(emitCurrentValue: true)
//         .listen((bluetoothState) async {
//       log.v('bluetoothState = $bluetoothState');

//       if ((bluetoothState == BluetoothState.POWERED_ON ||
//               bluetoothState == BluetoothState.UNAUTHORIZED) &&
//           !completer.isCompleted) {
//         completer.complete(bluetoothState);
//       }
//     });
//     return completer.future.timeout(Duration(seconds: 5),
//         onTimeout: () {});
//         // => throw Exception('Wait for Bluetooth PowerOn timeout'));
//   }

//   Future<Stream<EspProv>> monitorSelectedPeripheral() async {
//     _monitorStream?.close();
//     _monitorStream = StreamController<EspProv>();
//     _scanSubscription?.cancel();
//     _scanSubscription = scanBle()
//         .debounce((_) => TimerStream(true, Duration(milliseconds: 500)))
//         .listen((ScanResult scanResult) async {
//           selectedPeripheral = scanResult.peripheral;
//       log.i('Scan receive ${scanResult.peripheral}');
//       if (selectedId != null &&
//           selectedId == scanResult.peripheral.identifier) {
//         if (selectedPeripheral != null &&
//             await selectedPeripheral.isConnected()) {
//           return;
//         }
//         // selectedPeripheral = scanResult.peripheral;

//         selectedPeripheral
//             .observeConnectionState(
//                 emitCurrentValue: true, completeOnDisconnect: true)
//             .listen((connectionState) {
// //          _monitorStream.add(_prov);
//           log.i(
//               "Peripheral ${scanResult.peripheral.identifier} connection state is $connectionState");
//         });
//         _prov?.dispose();
//         _prov = EspProv(
//             transport: TransportBLE(selectedPeripheral),
//             security: Security1(pop: kApplicationPop));
//         try {
//           // var success = 
//         await _prov.establishSession();
//           // if (success) {
//         _monitorStream.add(_prov);
//           // }
//         } catch (e) {
//           log.e('Error connect $e');
//         }
//       }
//     });
//     return _monitorStream.stream;
//   }

//   Future<Peripheral> scanPeripheral() async {
//     Completer completer = Completer<BluetoothState>();
//     _scanSubscription?.cancel();
//     _scanSubscription = scanBle()
//         .debounce((_) => TimerStream(true, Duration(milliseconds: 1000)))
//         .listen((ScanResult scanResult) {
//       if (scanResult.advertisementData.localName != null &&
//           selectedPeripheral != null &&
//           scanResult.peripheral.identifier == selectedPeripheral.identifier) {
//         // stopScanBle();
//         completer.complete(scanResult.peripheral);
//       }
//     });
//     return completer.future;
//   }

//   Future<bool> checkBlePermissions() async {
//     Location location = new Location();
//     bool _serviceEnabled;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return false;
//       }
//     }

//     var isLocationGranted =
//         await GetIt.I<PermissionsService>().requestLocationPermission();
//     log.v('checkBlePermissions, isLocationGranted=$isLocationGranted');
//     return isLocationGranted;
//   }
// }
