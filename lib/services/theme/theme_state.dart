import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class ThemeState {
  final ThemeData? themeData;

  ThemeState({@required this.themeData});

  factory ThemeState.lightTheme() {
    return ThemeState(themeData: kLightTheme);
  }

  factory ThemeState.darkTheme() {
    return ThemeState(themeData: kDarkTheme);
  }

  factory ThemeState.uninitialized() {
    return ThemeState(themeData: kLightTheme);
  }

}
