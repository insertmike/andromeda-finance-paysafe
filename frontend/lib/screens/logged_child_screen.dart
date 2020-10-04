import 'dart:async';
import 'dart:ui';
import 'dart:convert';

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
import '../services/task_service.dart';
import 'dart:convert';
import '../widgets/custom_snackbar.dart';
import 'package:flutter/widgets.dart';
import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/models/kid.dart';

import '../config.dart';
import 'package:http/http.dart' as http;

class LoggedChildScreen extends StatefulWidget {
  static const routeName = '/logged_child';

  static Future<Kid> _getKid() async {
    AuthToken token = await AuthenticationUtils.getToken();
    int id = await AuthenticationUtils.getId();
    return await fetchKid(token, id);
  }

  @override
  _LoggedChildScreenState createState() => _LoggedChildScreenState();
}

class _LoggedChildScreenState extends State<LoggedChildScreen> {
  Future<Kid> _kidFuture = LoggedChildScreen._getKid();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(new Duration(seconds: 2), (timer) {
      refreshData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void refreshData() {
    setState(() {
      this._kidFuture = LoggedChildScreen._getKid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                              onConfirm: () => _showConfirmDialog(
                                  context, task, _scaffoldKey),
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

  void _showConfirmDialog(
      BuildContext context, Task task, GlobalKey<ScaffoldState> scaffoldKey) {
    showDialog(
        context: context,
        builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: CompleteTaskDialogContent(
              task: task,
              scaffoldKey: scaffoldKey,
            )));
  }
}

class CompleteTaskDialogContent extends StatefulWidget {
  final Task task;
  GlobalKey<ScaffoldState> scaffoldKey;
  CompleteTaskDialogContent(
      {Key key, @required this.task, @required this.scaffoldKey})
      : super(key: key);

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
                        SizedBox(
                          width: 240,
                          child: TextFormField(
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
                        alignment: Alignment.bottomRight,
                        child: MiniFlatButton(
                            child: Text("Confirm"),
                            onPressed: () async {
                              AuthToken token =
                                  await AuthenticationUtils.getToken();
                              final msg = jsonEncode({
                                "image": "oldPassword",
                                "comment": "newPassword"
                              });

                              final response = await http.put(
                                "$API_SERVER_ADDRESS/parent/0/kid/0/task/${widget.task.id}",
                                headers: {
                                  "Content-Type": "application/json",
                                  "Authorization": token.toString(),
                                },
                                body: msg,
                              );
                              print(response.statusCode);
                              if (response.statusCode == 200) {
                                Navigator.of(context).pop();
                                widget.scaffoldKey.currentState.showSnackBar(
                                    CustomSnackbar.buildSuccessSnackBar(
                                        context, 'Submitted'));
                                setState(() {});
                              }
                            }),
                      ))
                ],
              )
            ],
          ))
    ]);
  }
}
