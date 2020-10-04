import 'dart:convert';

import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/models/kid.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

Future<List<Kid>> fetchKidsAsync(AuthToken token, int parentId) async {
  // FIXME: Needs improvement
  final response =
      await http.get("$API_SERVER_ADDRESS/parent/$parentId/kid", headers: {
    "Accept": "application/json",
    "Authorization": token.toString(),
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['children'].map<Kid>((obj) => Kid.fromJson(obj)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}
