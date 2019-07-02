import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';

class ThemeOptions implements AppThemeOptions {
  final Color eventCardTimeTextColor;
  final Color textOnPrimaryColorTextColor;
  final Color pullToRefreshBallColor;
  final Color pullToRefreshBackgroundColor;
  final Color iconColor;
  final Color normalTextColor;

  ThemeOptions({
    this.eventCardTimeTextColor,
    this.textOnPrimaryColorTextColor,
    this.pullToRefreshBallColor,
    this.pullToRefreshBackgroundColor,
    this.iconColor,
    this.normalTextColor = Colors.black,
  });
}

class ThemeRepository {
  static get darkTheme => AppTheme(
        id: "dark_theme",
        description: "Default Dark Theme",
        data: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.black,
          bottomAppBarTheme: BottomAppBarTheme(
            shape: CircularNotchedRectangle(),
            color: Colors.black,
          ),
        ),
        options: ThemeOptions(
          eventCardTimeTextColor: Colors.white,
          pullToRefreshBallColor: Colors.white,
          pullToRefreshBackgroundColor: Colors.black,
          textOnPrimaryColorTextColor: Colors.white,
          iconColor: Colors.white,
          normalTextColor: Colors.white,
        ),
      );

  static get defaultTheme => AppTheme(
        id: "default_theme",
        description: "Default Theme",
        data: ThemeData(
          primaryColor: Color(0xff58355E),
          accentColor: Color(0xffE03616),
          bottomAppBarTheme: BottomAppBarTheme(
            shape: CircularNotchedRectangle(),
            color: Color(0xff58355E),
          ),
        ),
        options: ThemeOptions(
          eventCardTimeTextColor: Colors.white,
          pullToRefreshBallColor: Color(0xffE03616),
          pullToRefreshBackgroundColor: Colors.white,
          textOnPrimaryColorTextColor: Colors.white,
          iconColor: Color(0xffE03616),
        ),
      );
}
