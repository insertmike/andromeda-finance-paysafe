import 'package:flutter/material.dart';
import 'package:kidromeda/screens/child_tasks_page.dart';
import 'package:kidromeda/screens/logged_child_screen.dart';
import './screens/login_screen.dart';
import './screens/logged_parent_screen.dart';
import './screens/add_kid_screen.dart';
import './screens/new_task_screen.dart';
import './screens/welcome_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => WelcomeScreen(),
    LoggedParentScreen.routeName: (BuildContext context) =>
        LoggedParentScreen(),
    LoggedChildScreen.routeName: (BuildContext context) => LoggedChildScreen(),
    ChildTasksPage.routeName: (BuildContext context) => ChildTasksPage(),
    AddKidScreen.routeName: (BuildContext context) => AddKidScreen(),
  };
}
