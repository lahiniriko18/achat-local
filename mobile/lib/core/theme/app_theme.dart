import 'package:flutter/material.dart';
import 'package:premier_app/configuration/config.dart';

class AppTheme {
  static ThemeData getTheme(Config config) {
    return ThemeData(
        brightness: config.isDark ? Brightness.dark : Brightness.light,
        primaryColor: Color(int.parse(config.theme.replaceFirst('#', '0xff'))),
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: config.taillePolice + 5),
          bodyMedium: TextStyle(fontSize: config.taillePolice),
          bodySmall: TextStyle(fontSize: config.taillePolice - 5),
        )
    );
  }
}