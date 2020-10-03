import 'package:flutter/material.dart';
import './screens/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginScreen()
  };
}
