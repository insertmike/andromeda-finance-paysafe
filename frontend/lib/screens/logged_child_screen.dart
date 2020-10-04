import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/models/task.dart';
import 'package:kidromeda/services/task_service.dart';
import 'package:kidromeda/theme.dart';
import 'package:kidromeda/utils/authentication_utils.dart';
import 'package:kidromeda/utils/mockup_data.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/widgets/child_task_card.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';
import 'package:kidromeda/widgets/segregated_task_list.dart';

class LoggedChildScreen extends StatelessWidget {
  static const routeName = '/logged_child';
  final Future<Kid> _kidFuture = _getKid();

  static Future<Kid> _getKid() async {
    AuthToken token = await AuthenticationUtils.getToken();
    int id = await AuthenticationUtils.getId();
    return await fetchKid(token, id);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<Kid>(
          future: _kidFuture,
          builder: (BuildContext context, AsyncSnapshot<Kid> snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              return SingleChildScrollView(
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
                              child: Text("Hello, ${snapshot.data.name}!",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700))),
                          Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: ChildDetailsCard(
                              kid: snapshot.data,
                            ),
                          ),
                          SegregatedTaskList(
                            physics: NeverScrollableScrollPhysics(),
                            tasks: snapshot.data.tasks,
                            builder: (context, task) => ChildTaskCard(
                              task: task,
                              onConfirm: () =>
                                  _showConfirmDialog(context, task),
                            ),
                          )
                        ],
                      )));
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(snapshot.hasError
                          ? snapshot.error.toString()
                          : 'Loading...'),
                    )
                  ],
                ),
              );
            }
          }),
    );
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
            child: CompleteTaskDialogContent(task: task)));
  }
}

class CompleteTaskDialogContent extends StatefulWidget {
  final Task task;

  CompleteTaskDialogContent({Key key, @required this.task}) : super(key: key);

  @override
  _CompleteTaskDialogContentState createState() =>
      _CompleteTaskDialogContentState();
}

class _CompleteTaskDialogContentState extends State<CompleteTaskDialogContent> {
  String comment;

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(widget.task.summary,
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
                        SizedBox(
                          width: 240,
                          child: TextFormField(
                            obscureText: true,
                            onChanged: (val) => {comment = val},
                            decoration: customInputDecoration.copyWith(
                              hintText: "Comment",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Align(
                        alignment:
                            Alignment.bottomRight, // FIXME: Doesn't work?
                        child: MiniFlatButton(
                            child: Text("Confirm"),
                            onPressed: () {
                              // TODO: Send update tasks status to pending and refresh
                            }),
                      ))
                ],
              )
            ],
          ))
    ]);
  }
}
