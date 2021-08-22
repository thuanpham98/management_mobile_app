import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class DecideTheme extends ThemeEvent {
  @override
  String toString() => 'Decide Theme';
}

class LightTheme extends ThemeEvent {
  @override
  String toString() => 'Light Theme';
}

class DarkTheme extends ThemeEvent {
  @override
  String toString() => 'Dark Theme';
}
