import 'package:flutter/material.dart';
import 'package:kidromeda/utils/math_utils.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/widgets/task_info_card.dart';
import '../models/kid.dart';

class ChildTasksPage extends StatefulWidget {
  static const routeName = '/child_tasks';
  final Kid kid;
  ChildTasksPage({this.kid});
  @override
  _ChildTasksPageState createState() => _ChildTasksPageState();
}

class _ChildTasksPageState extends State<ChildTasksPage> {
  @override
  Widget build(BuildContext context) {
    final list = buildList(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.kid.name}'s Tasks"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ChildDetailsCard(
                    kid: widget.kid,
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => list[index]),
              ],
            )));
  }

  @override
  List<Widget> buildList(BuildContext context) {
    final widgets = <Widget>[];

    final renderTask = (task) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: TaskInfoCard(
          summary: task.summary,
          status: task.status,
        ));

    final renderHeading = (text) => Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(text,
            style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w700)));

    final pendingTasks = getPendingTasks(widget.kid.tasks);
    if (pendingTasks.isNotEmpty) {
      widgets.add(renderHeading("Pending"));
      widgets.addAll(pendingTasks.map(renderTask));
    }

    final remainingTasks = getRemainingTask(widget.kid.tasks);

    if (remainingTasks.isNotEmpty) {
      widgets.add(renderHeading("Remaining"));
      widgets.addAll(remainingTasks.map(renderTask));
    }

    final completedTasks = getCompletedTaskas(widget.kid.tasks);

    if (completedTasks.isNotEmpty) {
      widgets.add(renderHeading("Completed"));
      widgets.addAll(completedTasks.map(renderTask));
    }

    return widgets;
  }
}
