import 'dart:convert';

import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/models/task.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

Future<Kid> fetchKid(AuthToken token, int kidId) async {
  // FIXME: Needs improvement
  final response = await http.get("$API_SERVER_ADDRESS/kid/$kidId", headers: {
    "Accept": "application/json",
    "Authorization": token.toString(),
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return Kid.fromJson(data);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load data');
  }
}

Future<List<Kid>> fetchKidsAsync(AuthToken token, int parentId) async {
  // FIXME: Needs improvement
  final response =
      await http.get("$API_SERVER_ADDRESS/parent/$parentId/kid", headers: {
    "Accept": "application/json",
    "Authorization": token.toString(),
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(response.body);
    return data['children'].map<Kid>((obj) => Kid.fromJson(obj)).toList();
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch data');
  }
}

Future<void> addKidAsync(AuthToken token, int parentId,
    {String name, String email, String password}) async {
  // FIXME: Needs improvement
  final response = await http.post("$API_SERVER_ADDRESS/parent/$parentId/kid",
      headers: {
        "Accept": "application/json",
        "Authorization": token.toString(),
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }));

  if (response.statusCode != 201) {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch data');
  }
}

Future<void> addTaskAsync(
    AuthToken token, int parentId, int kidId, Task task) async {
  // FIXME: Needs improvement
  final response =
      await http.post("$API_SERVER_ADDRESS/parent/$parentId/kid/$kidId/task",
          headers: {
            "Accept": "application/json",
            "Authorization": token.toString(),
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            'summary': task.summary,
            'reward': task.reward,
          }));

  if (response.statusCode != 200) {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch data');
  }
}

Future<void> confirmTaskAsync(
    AuthToken token, int parentId, int kidId, int taskId) async {
  // FIXME: Needs improvement
  final response = await http.put(
      "$API_SERVER_ADDRESS/parent/$parentId/kid/$kidId/task/$taskId/verify",
      headers: {
        "Accept": "application/json",
        "Authorization": token.toString(),
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        'verify': 'True',
      }));

  if (response.statusCode != 200) {
    // If that call was not successful, throw an error.
    throw Exception('Failed to fetch data');
  }
}
