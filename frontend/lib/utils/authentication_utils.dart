import 'package:flutter/material.dart';
import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationUtils {
  String _email;
  String _password;
  int _id;

  // -- DEVELOPMENT --
  static Future<bool> isLogged() async {
    String email = await getEmail();

    if (email == null) {
      return false;
    }
    return email.isNotEmpty;
  }

  AuthenticationUtils.map(int id, String email, String password) {
    this._email = email;
    this._password = password;
    this._id = id;
    print(_email);
  }

  static Future<AuthToken> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    if (email == null || password == null) {
      return null;
    }
    return AuthToken.basic(
        prefs.getString('email'), prefs.getString('password'));
  }

  // -- DEVELOPMENT ---

  static Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email') ?? null;
  }

  static Future<int> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id') ?? null;
  }

  void saveSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', _email);
    prefs.setString('password', _password);
    prefs.setInt('id', _id);
  }

  static Future<void> nullLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', null);
    prefs.setString('password', null);
    prefs.setInt('id', null);
  }

  static void logout(BuildContext context) {
    AuthenticationUtils.nullLoginInfo();
    Navigator.pushReplacementNamed(context, '/');
  }
}
