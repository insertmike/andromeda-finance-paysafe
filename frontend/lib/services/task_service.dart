import 'dart:convert';

import 'package:kidromeda/models/auth_token.dart';

import '../config.dart';
import '../utils/http_response.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<dynamic> fetchKidsAsync(AuthToken token, String parentId) async {
  // FIXME: Needs improvement
  final response =
      await http.get("$API_SERVER_ADDRESS/parent/$parentId/kid", headers: {
    "Accept": "application/json",
    "Authorization": token.toString(),
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data;
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}
