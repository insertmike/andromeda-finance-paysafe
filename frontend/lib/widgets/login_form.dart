import 'package:flutter/material.dart';
import 'dart:convert';
import './default_btn.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                const Radius.circular(0.0),
              )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              labelText: 'Email',
            ),
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                const Radius.circular(0.0),
              )),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: BorderSide(
                  color: Theme.of(context).accentColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              labelText: 'Password',
            ),
            onChanged: (value) => _password = value,
            validator: (String value) => null,
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: InkWell(
              onTap: () {
                _submit(context);
              },
              child: defaultBtn(context, 'Login'),
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) async {}
}
