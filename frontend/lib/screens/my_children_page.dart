import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/child_info_card.dart';
import '../models/kid.dart';
import 'dart:convert';

class MyChildrenPage extends StatelessWidget {
  String sampleResponse =
      '{ "children": [{ "parent_id": 0, "name": "Dexter", "balance": 100.0, "tasks": [{ "summary": "Task 1", "status": 0, "reward": 50.0, "comment": null }] },{ "parent_id": 0, "name": "Dexter", "balance": 100.0, "tasks": [{ "summary": "Task 1", "status": 0, "reward": 50.0, "comment": null }] },] }';
  @override
  Widget build(BuildContext context) {
    List<Kid> children = json
        .decode(sampleResponse)['children']
        .map<Kid>((str) => Kid.fromJson(str))
        .toList();
    print(children);
    print(json.decode(sampleResponse));
    return Container(
        child: ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, position) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ChildInfoCard(
              name: children[position].name,
              balance: children[position].balance,
              // TODO FILTER BY COMPLETED TASKS
              completedTasks: 1,
              totalTasks: children[position].tasks.length,
            ),
          ],
        );
      },
    ));
  }
}
