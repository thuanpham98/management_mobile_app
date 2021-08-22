import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:logger/logger.dart';
import '../services/logger_service.dart';

import 'localstorage_service.dart';

class LanguageService {
  static LanguageService? _instance;
  static Locale? _defaultLocale;
  static Logger? log = GetIt.I<LoggerService>().getLog();

  static LanguageService getInstance() {
    if (_instance == null) {
      _instance = LanguageService();
      Translations.missingKeyCallback = (key, locale) {
//        log.v('missing key $key} for lang $locale');
      };
      Translations.missingTranslationCallback = (key, locale) {};
    }
    return _instance!;
  }

  String get lang {
    return GetIt.I<LocalStorageService>().language;
  }

  set lang(String value) {
    GetIt.I<LocalStorageService>().language = value;
  }

  Locale get locale {
    if (lang == "en") {
      return Locale("en", "gb");
    }
    return Locale("vi", "");
  }

  set defaultLocale(Locale locale) {
    _defaultLocale = locale;
  }
}
