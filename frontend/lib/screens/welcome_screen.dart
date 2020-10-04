import 'package:kidromeda/screens/login_screen.dart';
import '../utils/authentication_utils.dart';
import 'package:flutter/material.dart';
import '../widgets/default_btn.dart';
import '../widgets/backround.dart';
import '../screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _subtitle(BuildContext context, String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.subhead,
      textAlign: TextAlign.center,
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: defaultBtn(context, 'Login'));
  }

  Widget _signUpButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        child: defaultBtn(context, 'Register'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _save = Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/piggy_bank.png',
              width: 200,
            ),
            Row(
              children: <Widget>[
                Spacer(flex: 1),
                Expanded(
                  flex: 6,
                  child: _subtitle(context, 'Andromeda Finance - Kids Choice'),
                ),
                Spacer(flex: 1),
              ],
            ),
            SizedBox(
              height: 36,
            ),
            _submitButton(context),
            SizedBox(
              height: 20,
            ),
            _signUpButton(context),
            SizedBox(
              height: 50,
            ),
          ],
        ));

    return Scaffold(
        body: Stack(children: <Widget>[
      Background(),
      _save,
      //Login(),
    ]));
  }
}
