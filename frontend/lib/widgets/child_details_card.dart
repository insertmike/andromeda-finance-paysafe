import 'package:flutter/material.dart';
import 'package:kidromeda/screens/new_task_screen.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';
import '../widgets/child_details_card.dart';
import '../models/kid.dart';
import '../models/task.dart';

class ChildDetailsCard extends StatefulWidget {
  final Kid kid;
  final bool canAddTasks;

  const ChildDetailsCard({this.kid, this.canAddTasks = false});

  @override
  _ChildDetailsCardState createState() => _ChildDetailsCardState();
}

class _ChildDetailsCardState extends State<ChildDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text("₩ ${this.widget.kid.balance}",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text("dexter@secret.lab",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Theme.of(context).primaryColorLight)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text(
                  "${getCompletedTasks(this.widget.kid.tasks)} out of ${this.widget.kid.tasks.length} completed",
                ),
              ),
              widget.canAddTasks ? Padding(
                padding: EdgeInsets.only(top: 8),
                child: MiniFlatButton(
                  child: Text("+ Add Task"),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NewTaskScreen(widget.kid.name, widget.kid.id))),
                ),
              ) : SizedBox.shrink(),
            ],
          ),
          CircularPercentageIndicator(
            size: 96,
            strokeWidth: 8,
            value: getCompletedTasks(widget.kid.tasks) /
                this.widget.kid.tasks.length,
          ),
        ],
      ),
    );
  }

  int getCompletedTasks(List<Task> tasks) {
    int completedTasks = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].status == 2) {
        completedTasks = completedTasks + 1;
      }
    }
    return completedTasks;
  }
}
