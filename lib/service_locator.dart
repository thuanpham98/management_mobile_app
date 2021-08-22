import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'services/analytics_service.dart';
import 'services/services.dart';

import 'blocs/auth/user_repository.dart';
import 'services/language_service.dart';
import 'services/localstorage_service.dart';
import 'services/logger_service.dart';
import 'services/navigation_service.dart';
import 'services/permissions_service.dart';
import 'services/iot_core/iot_core.dart';

final locator = GetIt.instance;
Logger? log=Logger();

Future<void> setupLocator() async {
  locator.registerSingleton<LoggerService>(LoggerService.getInstance());
  var localInstance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localInstance);


  locator.registerSingleton<NavigationService>(NavigationService.getInstance());

  locator.registerSingleton<PermissionsService>(PermissionsService());
  locator.registerSingleton<UserRepository>(UserRepository());

  locator.registerSingleton<ThemeService>(ThemeService.getInstance());
  locator.registerSingleton<LanguageService>(LanguageService.getInstance());

  // var iotcoreInstance = await IotCore.getInstance();
  locator.registerSingleton<IotCore>(IotCore.getInstance());

  locator.registerLazySingleton(() => AnalyticsService());

  log = locator<LoggerService>().getLog();

}
