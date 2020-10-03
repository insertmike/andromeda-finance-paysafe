import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kidromeda/models/task.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/utils/mockup_data.dart' show getChildren;
import 'package:kidromeda/widgets/task_info_card.dart';

class ChildTasksPage extends StatelessWidget {
  static const routeName = '/child_tasks';

  @override
  Widget build(BuildContext context) {
    List<Kid> children = getChildren();
    int child_index =
        (ModalRoute.of(context).settings.arguments as dynamic)["index"];
    Kid child = children[child_index];

    List<Task> remainingTasks =
        child.tasks.where((task) => task.status == 0).toList();
    List<Task> pendingTasks =
        child.tasks.where((task) => task.status == 1).toList();
    List<Task> completedTasks =
        child.tasks.where((task) => task.status == 2).toList();

    List<Widget> pending = pendingTasks.length > 0
      ? [
            Text(
              "Pending",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            ),
            ...pendingTasks.map((task) => TaskInfoCard(summary: task.summary, status: task.status,))
        ] : [];

    List<Widget> completed = completedTasks.length > 0
      ? [
            Text("Completed", style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            ),
            ...completedTasks.map((task) => TaskInfoCard(summary: task.summary, status: task.status,))
        ] : [];

    List<Widget> remaining = remainingTasks.length > 0
      ? [
            Text("Remaining", style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
            ),
            ...remainingTasks.map((task) => TaskInfoCard(summary: task.summary, status: task.status,))
        ] : [];

    return Scaffold(
        appBar: AppBar(
          title: Text("${child.name}'s Tasks"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: ChildDetailsCard(
                email: "dexter@secret.lab",
                balance: child.balance,
                // TODO FILTER BY COMPLETED TASKS
                completedTasks: 1,
                totalTasks: child.tasks.length,
              ),
            ),
            ...pending,
            ...remaining,
            ...completed,
          ],
        )));
  }
}
