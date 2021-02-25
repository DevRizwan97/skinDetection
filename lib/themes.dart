import 'package:flutter/material.dart';

class Themes {
  static const DARK_THEME_CODE = 1;
  static const LIGHT_THEME_CODE = 0;

  static final _dark = ThemeData(
    primarySwatch: MaterialColor(
      Color(0xffF6A545).value,
      const <int, Color>{
        50: Colors.black12,
        100: Color(0xffF6A545),
        200: Color(0xffF6A545),
        300: Color(0xffF6A545),
        400: Color(0xffF6A545),
        500: Color(0xffF6A545),
        600: Color(0xffF6A545),
        700: Color(0xffF6A545),
        800: Color(0xffF6A545),
        900: Color(0xffF6A545),
      },
    ),
    accentColor: Colors.white,
    disabledColor: Colors.green
  );

  static final _light = ThemeData(
    primarySwatch: MaterialColor(
      Colors.white.value,
      const <int, Color>{
        50: Colors.white10,
        100: Colors.white12,
        200: Colors.white24,
        300: Colors.white30,
        400: Colors.white54,
        500: Colors.white70,
        600: Colors.white70,
        700: Colors.white70,
        800: Colors.white70,
        900: Colors.white70,
      },
    ),
    accentColor: Colors.black,
      disabledColor: Colors.green

  );

  static ThemeData getTheme(int code) {
    if(code == LIGHT_THEME_CODE){
      return _light;
    }
    return _dark;
  }

}
