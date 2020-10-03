import '../models/kid.dart';
import 'dart:convert';

List<Kid> getChildren() {
  String sampleResponse = '''{
        "children": [
            {
                "parent_id": 0,
                "name": "Dexter",
                "balance": 100.0,
                "tasks": [
                    {
                        "summary": "Task 1",
                        "status": 0,
                        "reward": 50.0,
                        "comment": null
                    },
                    {
                        "summary": "Task 2",
                        "status": 1,
                        "reward": 150.0,
                        "comment": "This is a comment"
                    },
                    {
                        "summary": "Task 2",
                        "status": 2,
                        "reward": 150.0,
                        "comment": "This is a comment"
                    }
                ]
            },
            {
                "parent_id": 0,
                "name": "Dee Dee",
                "balance": 50.0,
                "tasks": [
                    {
                        "summary": "Task 1",
                        "status": 0,
                        "reward": 50.0,
                        "comment": null
                    }
                ]
            }
        ]
    }''';

  List<Kid> children = json
      .decode(sampleResponse)['children']
      .map<Kid>((str) => Kid.fromJson(str))
      .toList();

  return children;
}
