import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/models/task.dart';
import 'package:kidromeda/theme.dart';
import 'package:kidromeda/utils/mockup_data.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/widgets/child_task_card.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';
import 'package:kidromeda/widgets/segregated_task_list.dart';

class LoggedChildScreen extends StatelessWidget {
  static const routeName = '/logged_child';

  @override
  Widget build(BuildContext context) {
    // FIXME
    Kid kid = getChildren().first;

    return Scaffold(
        appBar: AppBar(
          title: Text("My Tasks"),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      '/',
                    )),
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 16),
                        child: Text("Hello, ${kid.name}!",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w700))),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: ChildDetailsCard(
                        kid: kid,
                      ),
                    ),
                    SegregatedTaskList(
                      physics: NeverScrollableScrollPhysics(),
                      tasks: kid.tasks,
                      builder: (context, task) => ChildTaskCard(
                        task: task,
                        onConfirm: () => _showConfirmDialog(context, task),
                      ),
                    )
                  ],
                ))));
  }

  void _showConfirmDialog(BuildContext context, Task task) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: _buildConfirmDialogContent(context, task)));
  }

  Widget _buildConfirmDialogContent(BuildContext context, Task task) {
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Complete Task",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(task.summary,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black54)),
                  ),
                  Form(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // FIXME
                        // TextFormField(
                        //   obscureText: true,
                        //   onChanged: (val) => {},
                        //   decoration: customInputDecoration.copyWith(
                        //     hintText: "Name",
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight, // FIXME: Doesn't work?
                    child: MiniFlatButton(child: Text("Confirm"), onPressed: () {}),
                  )
                ],
              )
            ],
          ))
    ]);
  }
}
