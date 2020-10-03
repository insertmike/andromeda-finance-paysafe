import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/custom_snackbar.dart';
import '../theme.dart';
import '../widgets/default_btn.dart';
import 'dart:async';
import 'dart:io';

class NewTaskScreen extends StatefulWidget {
  static const routeName = '/newTaskScreen';
  final String kidName;
  final int kidId;

  const NewTaskScreen(this.kidName, this.kidId);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _password;
  String _passwordConfirmed;
  String _name;
  String _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(widget.kidName + '\'s New Task'),
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
                  children: <Widget>[
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) => _name = val,
                      decoration: customInputDecoration.copyWith(
                        hintText: "Summary",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                        onChanged: (val) => _name = val,
                        decoration: customInputDecoration.copyWith(
                          hintText: "Reward",
                        ),
                        keyboardType: TextInputType.number),
                    SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      child: defaultBtn(context, 'Add Task'),
                      onTap: () => {
                        if (_formKey.currentState.validate())
                          {
                            _scaffoldKey.currentState.showSnackBar(
                                CustomSnackbar.buildSuccessSnackBar(
                                    context, 'Success')),
                            Future.delayed(Duration(seconds: 2)).then((_) {
                              // this code is executed after the future ends.
                              Navigator.of(context).pop(true);
                            }),
                          }
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
