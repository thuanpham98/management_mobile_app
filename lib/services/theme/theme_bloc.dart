import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '/services/navigation_service.dart';

import 'theme.dart';
import '../../service_locator.dart';
import '../localstorage_service.dart';
import 'package:flutter/services.dart';

import 'styles.dart';
import 'package:flutter/material.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.uninitialized());

  void onLightThemeChange() => this.add(LightTheme());

  void onDarkThemeChange() => this.add(DarkTheme());

  void onDecideThemeChange() => this.add(DecideTheme());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is DarkTheme) {
      yield ThemeState.darkTheme();
    }
    if (event is LightTheme) {
      yield ThemeState.lightTheme();
    }

    if (event is DecideTheme) {
      var storageService = locator<LocalStorageService>();
      if (storageService.darkMode) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent.withOpacity(0),
            statusBarIconBrightness: Brightness.light, 
            systemNavigationBarColor: kDarkBG,
            systemNavigationBarIconBrightness: Brightness.light, 
        ));
        yield ThemeState.darkTheme();
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent.withOpacity(0),
            statusBarIconBrightness: Brightness.dark, 
            systemNavigationBarColor: kLightBG,
            systemNavigationBarIconBrightness: Brightness.dark, 
        ));
        yield ThemeState.lightTheme();
      }
    }
  }
}
