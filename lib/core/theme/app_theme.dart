import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(Locale locale) => ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    fontFamily: locale.languageCode == 'km' ? "KantumruyPro" : "Inter",
  );

  static ThemeData darkTheme(Locale locale) => ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.teal,
    fontFamily: locale.languageCode == 'km' ? "KantumruyPro" : "Inter",
  );
}
