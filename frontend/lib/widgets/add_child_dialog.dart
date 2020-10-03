import 'package:flutter/material.dart';
import '../widgets/default_btn.dart';
import '../theme.dart';

Future showAddChildDialog(BuildContext context) async {}

class AddKidDialog extends StatelessWidget {
  const AddKidDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new AlertDialog(
        title: new Text('Add Child'),
        content: Column(
          children: <Widget>[],
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text('CANCEL'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
