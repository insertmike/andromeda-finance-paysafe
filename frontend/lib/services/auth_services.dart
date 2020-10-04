import '../config.dart';
import '../utils/http_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../utils/authentication_utils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

Future<HttpResponse> login({
  @required String email,
  @required String password,
}) async {
  final response = await http.get(API_SERVER_ADDRESS + LOGIN_PATH, headers: {
    "Accept": "application/json",
    "Authorization": "Basic " + base64Encode(utf8.encode('$email:$password'))
  });

  print("Basic " + base64Encode(utf8.encode('$email:$password')));

  if (response.statusCode != null) {
    return HttpResponse(response);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}
