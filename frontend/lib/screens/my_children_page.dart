import 'package:flutter/material.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/utils/mockup_data.dart' show getChildren;
import 'package:kidromeda/widgets/child_info_card.dart';
import '../utils/string_utils.dart';

class MyChildrenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Kid> children = getChildren();

    return Container(
        child: ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, position) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: ChildInfoCard(
                index: position,
                name: children[position].name,
                balance: children[position].balance,
                // TODO FILTER BY COMPLETED TASKS
                completedTasks: 1,
                totalTasks: children[position].tasks.length,
              ),
            )
          ],
        );
      },
    ));
  }
}

_displayAddKidDialog(BuildContext context) async {
  final GlobalKey<FormState> _deleteFormKey = GlobalKey<FormState>();
  String _password;
  String _newPassword;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Password Change'),
          content: Form(
            key: _deleteFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  obscureText: true,
                  validator: isPasswordCompliant,
                  onChanged: (val) => _password = val,
                  decoration: InputDecoration(
                    hintText: "Current Password",
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  validator: isPasswordCompliant,
                  onChanged: (val) => _newPassword = val,
                  decoration: InputDecoration(hintText: "New Password"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text(
                'Change Password',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                if (_deleteFormKey.currentState.validate()) {
                  // send request
                }
              },
            ),
          ],
        );
      });
}
