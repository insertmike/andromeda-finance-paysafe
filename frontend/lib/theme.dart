import 'package:flutter/material.dart';
import './config.dart';

class AppTheme {
  static final _themeBase = ThemeData(
    primaryColor: primaryColorConfig,
    accentColor: accentColorConfig,

    /// Text
    fontFamily: 'OpenSans',
  );
  static ThemeData get theme => _themeBase.copyWith(
        textTheme: _textTheme,
        inputDecorationTheme: _inputDecorationTheme,
      );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: _themeBase.primaryColorLight,
        width: 1,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: _themeBase.primaryColor,
        width: 2,
      ),
    ),
  );

  static final TextTheme _textTheme = ThemeData.light().textTheme.copyWith();
}
