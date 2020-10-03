import 'package:flutter/material.dart';
import 'package:kidromeda/models/task.dart';
import 'package:kidromeda/utils/math_utils.dart';

class SegregatedTaskList extends StatelessWidget {
  final List<Task> tasks;
  final ScrollPhysics physics;
  final Widget Function(BuildContext, Task) builder;

  SegregatedTaskList({Key key, @required this.tasks, @required this.builder, this.physics})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    final renderTask = (Task task) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: builder(context, task));

    final renderHeading = (text) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(text,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)));

    final pendingTasks = getPendingTasks(tasks);
    if (pendingTasks.isNotEmpty) {
      widgets.add(renderHeading("Pending"));
      widgets.addAll(pendingTasks.map(renderTask));
    }

    final remainingTasks = getRemainingTask(tasks);

    if (remainingTasks.isNotEmpty) {
      widgets.add(renderHeading("Remaining"));
      widgets.addAll(remainingTasks.map(renderTask));
    }

    final completedTasks = getCompletedTaskas(tasks);

    if (completedTasks.isNotEmpty) {
      widgets.add(renderHeading("Completed"));
      widgets.addAll(completedTasks.map(renderTask));
    }

    return ListView.builder(
        physics: physics,
        itemCount: widgets.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => widgets[index]);
  }
}
