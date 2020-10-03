import 'package:flutter/material.dart';
import '../widgets/default_btn.dart';
import '../theme.dart';

Future showAddChildDialog(BuildContext context) async {
  await showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AddKidDialog();
      });
}

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
          children: <Widget>[
            new TextField(
              decoration: customInputDecoration.copyWith(hintText: 'Name'),
            ),
            new TextField(
              decoration: customInputDecoration.copyWith(hintText: 'Email'),
            ),
            new TextField(
              decoration: customInputDecoration.copyWith(hintText: 'Password'),
            ),
            new TextField(
              decoration:
                  customInputDecoration.copyWith(hintText: 'Confirm Password'),
            ),
            new FlatButton(
              child: defaultBtn(context, 'ADD'),
              onPressed: () => {Navigator.of(context).pop()},
            )
          ],
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
