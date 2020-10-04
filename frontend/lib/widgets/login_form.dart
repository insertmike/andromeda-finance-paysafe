import 'package:flutter/material.dart';
import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/screens/logged_child_screen.dart';
import 'package:kidromeda/screens/logged_parent_screen.dart';
import 'package:kidromeda/services/auth_services.dart';
import 'package:kidromeda/utils/authentication_utils.dart';
import './default_btn.dart';
import '../widgets/custom_snackbar.dart';
import '../theme.dart';
import '../utils/http_response.dart';
import 'dart:convert';

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
            decoration: customInputDecoration.copyWith(
              labelText: 'Email',
            ),
            onChanged: (value) => _email = value,
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            obscureText: true,
            decoration: customInputDecoration.copyWith(
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

  void _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildErrorSnackBar(
          context, 'Invalid Authentication Details'));
      return;
    }

    final token = AuthToken.basic(_email, _password);
    try {
      final _ = await login(token);
      FocusScope.of(context).requestFocus(FocusNode());
      final auth = AuthenticationUtils.map(_email, _password);

      Scaffold.of(context).showSnackBar(
          CustomSnackbar.buildSuccessSnackBar(context, 'Success'));

      auth.saveSession();

      Navigator.pushReplacementNamed(context, LoggedChildScreen.routeName);
    } on Exception catch(e) {
      print(e);
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildErrorSnackBar(
          context,
          'Please insert at least one number, one capital letter and one symbol'));
    }
  }
}
