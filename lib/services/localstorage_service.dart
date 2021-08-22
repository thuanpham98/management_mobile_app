import 'package:get_it/get_it.dart';
import '../services/logger_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;
  static const String AppLanguagesKey = 'languages';
  static const String AppLanguageKey = 'language';
  static const String DarkModeKey = 'darkmode';
  static const String SignedUpKey = 'signedUp';
  static const String LoggedInKey = 'loggedIn';
  static const String GoogleToken = 'gToken';
  static const String ServerToken = 'sToken';

  static bool _darkMode = false;
  static String _lang = '';
  static String _gToken ='';
  static String _sToken ='';

  void clearStorage() {
    darkMode = false;
    language = '';
  }

  var log = GetIt.I<LoggerService>().getLog();

  set gToken(String value){
    _gToken= value;
    _saveToDisk(GoogleToken, _gToken);
  }

  String get gToken {
    return _getFromDisk(GoogleToken)??'';
  }

  set sToken(String value){
    _sToken= value;
    _saveToDisk(ServerToken, _sToken);
  }

  String get sToken {
    return _getFromDisk(ServerToken)??'';
  }

  bool get darkMode {
    _darkMode = _getFromDisk(DarkModeKey)??false;
    return _darkMode;
  }

  set darkMode(bool value) {
    _darkMode = value;
    _saveToDisk(DarkModeKey, value);
  }


  set language(String code) {
    _lang = code;
    _saveToDisk(AppLanguageKey, code);
  }

  String get language {
    _lang = _getFromDisk(AppLanguageKey)??'';
    return _lang;
  }

  List<String> get languages => _getFromDisk(AppLanguagesKey) ?? [];

  set languages(List<String> appLanguages) =>
      _saveToDisk(AppLanguagesKey, appLanguages);

  bool get hasSignedUp => _getFromDisk(SignedUpKey) ?? false;

  set hasSignedUp(bool value) => _saveToDisk(SignedUpKey, value);

  bool get hasLoggedIn => _getFromDisk(LoggedInKey) ?? false;

  set hasLoggedIn(bool value) => _saveToDisk(LoggedInKey, value);

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance!;
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences?.get(key);

    log?.v('(TRACE) LocalStorageService:_getFromDisk. key: $key value: $value');
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    log?.v('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences?.setString(key, content);
    }
    if (content is bool) {
      _preferences?.setBool(key, content);
    }
    if (content is int) {
      _preferences?.setInt(key, content);
    }
    if (content is double) {
      _preferences?.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences?.setStringList(key, content);
    }
  }
}
