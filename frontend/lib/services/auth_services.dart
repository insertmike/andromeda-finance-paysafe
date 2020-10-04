import '../config.dart';
import '../utils/http_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../utils/authentication_utils.dart';
import '../models/auth_token.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class User {
  final int id;
  final String email;
  final String name;
  final bool isParent;

  User({this.id, this.email, this.name, this.isParent});
}

Future<User> login(AuthToken token) async {
  final response = await http.get(API_SERVER_ADDRESS + LOGIN_PATH, headers: {
    "Accept": "application/json",
    "Authorization": token.toString(),
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return User(
        id: data['current_id'],
        email: data['email'],
        name: data['name'],
        isParent: data['is_parent']);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}
