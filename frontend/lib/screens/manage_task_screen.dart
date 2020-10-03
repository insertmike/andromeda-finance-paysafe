import 'package:flutter/material.dart';
import '../models/task.dart';
import '../models/kid.dart';

class ManageTaskScreen extends StatefulWidget {
  static const routeName = '/ManageTaskScreen';
  final Task task;
  final Kid kid;
  const ManageTaskScreen(this.task, this.kid);

  @override
  _ManageTaskScreenState createState() => _ManageTaskScreenState();
}

class _ManageTaskScreenState extends State<ManageTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('Manage' + this.widget.kid.name + '\'s Task'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Center(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[Text('asdasdasd')],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
