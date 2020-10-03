import 'package:flutter/material.dart';
import './config.dart';

InputDecoration customInputDecoration = InputDecoration(
  border: new OutlineInputBorder(
      borderRadius: const BorderRadius.all(
    const Radius.circular(0.0),
  )),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(0.0),
    borderSide: BorderSide(
      color: accentColorConfig,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(5.0),
    borderSide: BorderSide(
      color: primaryColorConfig,
      width: 1.5,
    ),
  ),
);

class AppTheme {
  static final _themeBase = ThemeData(
    primaryColor: primaryColorConfig,
    accentColor: accentColorConfig,
    scaffoldBackgroundColor: Color.fromARGB(255, 0xEE, 0xEE, 0xEE),
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
