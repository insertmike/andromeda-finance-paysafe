import 'package:flutter/material.dart';
import 'package:kidromeda/services/task_service.dart';
import 'package:kidromeda/utils/authentication_utils.dart';
import 'package:kidromeda/widgets/custom_snackbar.dart';
import '../theme.dart';
import '../widgets/default_btn.dart';
import 'dart:async';
import 'dart:io';

class AddKidScreen extends StatefulWidget {
  static const routeName = '/addKidScreen';
  @override
  _AddKidScreenState createState() => _AddKidScreenState();
}

class _AddKidScreenState extends State<AddKidScreen> {
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
          //`true` if you want Flutter to automatically add Back Button when needed,
          //or `false` if you want to force your own back button every where
          title: Text('Add Kid'),
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
                      obscureText: false,
                      onChanged: (val) => _name = val,
                      decoration: customInputDecoration.copyWith(
                        hintText: "Name",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: false,
                      onChanged: (val) => _email = val,
                      decoration: customInputDecoration.copyWith(
                        hintText: "Email",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      //validator: isPasswordCompliant,
                      onChanged: (val) => _password = val,
                      decoration: customInputDecoration.copyWith(
                        hintText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      obscureText: true,
                      //   validator: isPasswordCompliant,
                      onChanged: (val) => _passwordConfirmed = val,
                      decoration: customInputDecoration.copyWith(
                          hintText: "Confirm Password"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: defaultBtn(context, 'Add'),
                      onTap: () => {
                        if (_formKey.currentState.validate())
                          {
                            _scaffoldKey.currentState.showSnackBar(
                                CustomSnackbar.buildSuccessSnackBar(
                                    context, 'Success')),
                            Future.delayed(Duration(seconds: 2)).then((_) async {
                              // this code is executed after the future ends.
                              Navigator.of(context).pop(true);

                              final token = await AuthenticationUtils.getToken();
                              final parentId = await AuthenticationUtils.getId();
                              await addKidAsync(token, parentId, name: _name, email: _email, password: _password);
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
