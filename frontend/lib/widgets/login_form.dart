import 'package:flutter/material.dart';
import 'package:kidromeda/screens/logged_parent_screen.dart';
import './default_btn.dart';
import 'custom_snackbar.dart';
import '../theme.dart';

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

    FocusScope.of(context).requestFocus(FocusNode());
    // HARDCODED UNTIL API AVAILABLE
    if (_email == "admin" && _password == "admin") {
      Navigator.pushReplacementNamed(
        context,
        LoggedParentScreen.routeName,
      );
    } else {
      Scaffold.of(context).showSnackBar(CustomSnackbar.buildErrorSnackBar(
          context,
          'Please insert at least one number, one capital letter and one symbol'));
    }
  }
}
