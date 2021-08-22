import 'package:get_it/get_it.dart';

import 'theme/theme_bloc.dart';
import 'localstorage_service.dart';

class ThemeService {
  static ThemeService ?_instance;
  static ThemeBloc? _appBloc;

  static ThemeService getInstance() {
    if (_instance == null) {
      _instance = ThemeService();
    }

    if (_appBloc == null) {
      _appBloc = ThemeBloc();
      _appBloc?..onDecideThemeChange();
    }
    return _instance!;
  }

  ThemeBloc getBloc() {
    return _appBloc!;
  }

  bool get darkMode {
    return GetIt.I<LocalStorageService>().darkMode;
  }

  set darkMode(bool value) {
    GetIt.I<LocalStorageService>().darkMode = value;
    _appBloc?..onDecideThemeChange();
  }
}
