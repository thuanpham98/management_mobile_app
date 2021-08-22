import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// basic colors
const kIndigo800 = Color(0xFF283593);
const kGreenPrimary = Colors.greenAccent;

const kDefaultBackgroundAvatar = '3FC1BE';
const kDefaultTextColorAvatar = 'EEEEEE';
const kDefaultAdminBackgroundAvatar = 'EEEEEE';
const kDefaultAdminTextColorAvatar = '3FC1BE';

const kTeal400 = Colors.green;
const kGrey900 = Color(0xFF263238);
const kGrey600 = Color(0xFF546E7A);
const kGrey200 = Color(0xFFEEEEEE);
const kGrey400 = Color(0xFF90a4ae);
const kErrorRed = Color(0xFFe74c3c);
const kSurfaceWhite = Color(0xFFFFFBFA);
const kBackgroundWhite = Colors.white;

const kLightTextFieldFill = Color(0xFFECEFF1);
const kDarkTextFieldFill = Color(0xFF37474F);

/// color for theme
const kLightPrimary = Color(0xfffcfcff);
const kLightAccent = Color(0xFF546E7A);
const kDarkAccent = Color(0xffF4F5F5);

const kLightBG = Color(0xffF1F2F3);
const kDarkBG = Color(0xff121212);
const kDarkBgLight = Color(0xff1E1E1E);
const kBadgeColor = Colors.red;

const kLightTextSelect = Color(0xFF66BB6A);
const kDarkTextSelect = Color(0xff2196f3);

const kLightAppBarTitle = Color(0xFF283593);
const kDarkAppBarTitle = Color(0xff2196f3);

///color for theme device
const kDeviceConnected = Color.fromRGBO(33, 150, 83, 1);
const kDeviceLost = Color.fromRGBO(79, 79, 79, 1);
const kRelayOn = Color.fromRGBO(47, 128, 237, 1);
const kRelayOff = Color.fromRGBO(79, 79, 79, 1);

// color for Intriduction screen
const kIntroductionBackgroung = Color(0xFF5ECE7B);

/// custom color for background station
const kStationBackground = {
  "kPrimary": 0xFF3FCC28,
  "kSwatch": {
    50: Color.fromRGBO(63, 204, 40, .2),
    100: Color.fromRGBO(63, 204, 40, .2),
    200: Color.fromRGBO(63, 204, 40, .3),
    300: Color.fromRGBO(63, 204, 40, .4),
    400: Color.fromRGBO(63, 204, 40, .5),
    500: Color.fromRGBO(63, 204, 40, .6),
    600: Color.fromRGBO(63, 204, 40, .6),
    700: Color.fromRGBO(63, 204, 40, .6),
    800: Color.fromRGBO(63, 204, 40, .6),
    900: Color.fromRGBO(63, 204, 40, 6),
  },
};

const kProductTitleStyleLarge =
    TextStyle(fontSize: 18, fontWeight: FontWeight.bold);

TextTheme kHeadlineTheme(theme, [language = 'en']) {
  switch (language) {
    case 'vi':
      return GoogleFonts.montserratTextTheme(theme);
    case 'ar':
      return GoogleFonts.ralewayTextTheme(theme);
    default:
      return GoogleFonts.ralewayTextTheme(theme);
  }
}

///Google fonts: https://fonts.google.com/
TextTheme kTextTheme(theme, String language) {
  switch (language) {
    case 'vi':
      return GoogleFonts.montserratTextTheme(theme);
    case 'ar':
      return GoogleFonts.ralewayTextTheme(theme);
    default:
      return GoogleFonts.ralewayTextTheme(theme);
  }
}

InputDecoration kTextField(String hintText, {Widget? icon}) {
  return InputDecoration(
    hintText: hintText,
    icon: icon,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(3.0)),
    ),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kGrey900);
}

ThemeData buildLightTheme(String language) {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: kColorScheme.copyWith(
      primary: kGreenPrimary,
    ),
    buttonColor: kTeal400,
    cardColor: Colors.white,
    textSelectionColor: kLightTextSelect,
    errorColor: kErrorRed,
    buttonTheme: const ButtonThemeData(
        colorScheme: kColorScheme,
        textTheme: ButtonTextTheme.normal,
        buttonColor: kDarkBG),
    primaryColorLight: kLightBG,
    primaryIconTheme: _customIconTheme(base.iconTheme),
    textTheme: _buildTextTheme(base.textTheme, language).apply(
      fontFamily: 'SFProDisplayRegular',
    ),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, language),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, language),
    iconTheme: _customIconTheme(base.iconTheme),
    hintColor: Colors.black26,
    backgroundColor: kLightBG,//Color(0xFFF1F2F6), //Colors.white,
    primaryColor: kLightPrimary,
    accentColor: kLightAccent,
    cursorColor: kLightAccent,
    scaffoldBackgroundColor: kLightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: kLightAppBarTitle,
          fontSize: 28.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(
        color: kLightAccent,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kLightTextFieldFill,
    ),
  );
}

TextTheme _buildTextTheme(TextTheme base, String language) {
  return kTextTheme(base, language)
      .copyWith(
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        button: base.button!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        subtitle: base.subtitle!.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      )
      .apply(
        displayColor: kGrey900,
        bodyColor: kGrey900,
      )
      .copyWith(headline: kHeadlineTheme(base).headline?.copyWith());
}

const ColorScheme kColorScheme = ColorScheme(
  primary: kGreenPrimary,
  primaryVariant: kGrey900,
  secondary: kIndigo800,
  secondaryVariant: kGrey900,
  surface: kSurfaceWhite,
  background: kBackgroundWhite,
  error: kErrorRed,
  onPrimary: kDarkBG,
  onSecondary: kGrey900,
  onSurface: kGrey900,
  onBackground: kGrey900,
  onError: kSurfaceWhite,
  brightness: Brightness.light,
);

ThemeData buildDarkTheme(String language) {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    colorScheme: kColorScheme.copyWith(
      primary: kGreenPrimary,
    ),
    textTheme: _buildTextTheme(base.textTheme, language).apply(
      displayColor: kLightBG,
      bodyColor: kLightBG,
      fontFamily: 'SFProDisplayRegular',
    ),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme, language).apply(
      displayColor: kLightBG,
      bodyColor: kLightBG,
    ),
    accentTextTheme: _buildTextTheme(base.accentTextTheme, language).apply(
      displayColor: kLightBG,
      bodyColor: kLightBG,
    ),
    textSelectionColor: kDarkTextSelect,
    cardColor: kDarkBgLight,
    brightness: Brightness.dark,
    backgroundColor: kDarkBG,
    primaryColor: kDarkBG,
    primaryColorLight: kDarkBgLight,
    accentColor: kDarkAccent,
    scaffoldBackgroundColor: kDarkBG,
    cursorColor: kDarkAccent,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: kDarkAppBarTitle,
          fontSize: 28.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(
        color: kDarkAccent,
      ),
    ),
    buttonTheme: ButtonThemeData(
        colorScheme: kColorScheme.copyWith(onPrimary: kLightBG)),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: kDarkTextFieldFill,
    ),
  );
}

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kTeal400, width: 2.0),
  ),
);

const kSendButtonTextStyle = TextStyle(
  color: kTeal400,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

final ThemeData kLightTheme = _buildLightTheme();

ThemeData _buildLightTheme() {
  return buildLightTheme('vi');
}

final ThemeData kDarkTheme = _buildDarkTheme();

ThemeData _buildDarkTheme() {
  return buildDarkTheme('vi');
}

const kShade = RoundedRectangleBorder(
  borderRadius: BorderRadius.only(
    topLeft: const Radius.circular(20.0),
    topRight: const Radius.circular(20.0),
  ),
);
