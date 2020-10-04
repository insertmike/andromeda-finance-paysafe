import '../models/kid.dart';
import 'dart:convert';

List<Kid> getChildren() {
  String sampleResponse = '''{
        "children": [
            {
                "id":1,
                "parent_id": 0,
                "name": "Dexter",
                "balance": 100.0,
                "tasks": [
                    {   
                        "task_id":1,
                        "summary": "Task 1",
                        "status": "0",
                        "reward": 50.0,
                        "comment": null
                    },
                    {
                        "task_id":2,
                        "summary": "Task 2",
                        "status": "1",
                        "reward": 150.0,
                        "comment": "This is a comment"
                    },
                    {
                        "task_id":3,
                        "summary": "Task 2",
                        "status": "2",
                        "reward": 150.0,
                        "comment": "This is a comment"
                    }
                ]
            },
            {
                "id":2,
                "parent_id": 0,
                "name": "Dee Dee",
                "balance": 50.0,
                "tasks": [
                    { 
                        "task_id":4,
                        "summary": "Task 1",
                        "status": "0",
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
