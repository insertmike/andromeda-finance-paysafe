import 'package:flutter/material.dart';
import 'package:kidromeda/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationUtils {
  String _email;
  String _password;

  // -- DEVELOPMENT SAVING FOR BASIC AUTH ---
  static void saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }

  static void savePassword(String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('password', password);
  }

  // -- DEVELOPMENT --
  static Future<bool> isLogged() async {
    String email = await getEmail();

    if (email == null) {
      return false;
    }
    return email.isNotEmpty;
  }

  AuthenticationUtils.map(dynamic obj) {
    this._email = obj['email'];
    this._password = obj['password'];
    print(_email);
  }

  // -- DEVELOPMENT ---

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? null;
  }

  void saveSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
    prefs.setString('password', _password);
  }

  static Future<void> nullLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('password', null);
  }

  static void logout(BuildContext context) {
    AuthenticationUtils.nullLoginInfo();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
