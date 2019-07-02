import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Define default theme for All devices
ThemeData buildTheme(BuildContext context) {
  final Color primary = Color(0xff103f54);
  final Color accent = Colors.red[900];
  return ThemeData(
      primaryColor: primary,
      accentColor: accent,
      textTheme: TextTheme(
        body1: TextStyle(
          fontWeight: FontWeight.w400,
        ),
        button: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w500),
        subhead: TextStyle(
          fontWeight: FontWeight.w700,
        ),
        headline: TextStyle(
          letterSpacing: 2.0,
          fontWeight: FontWeight.w800,
          decoration: TextDecoration.underline,
          fontSize: 20.0,
          color: primary,
        ),
        body2: TextStyle(letterSpacing: 2.0, fontWeight: FontWeight.w800),
      ),
      dividerColor: primary,
      splashColor: primary,
      primaryColorDark: Colors.black,
      secondaryHeaderColor: Colors.black,
      platform: defaultTargetPlatform,
      brightness: Brightness.light);
}
