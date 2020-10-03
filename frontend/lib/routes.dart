import 'package:flutter/material.dart';
import 'package:kidromeda/screens/child_tasks_page.dart';
import './screens/login_screen.dart';
import './screens/logged_parent_screen.dart';
import './screens/add_kid_screen.dart';
import './screens/new_task_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (BuildContext context) => LoginScreen(),
    LoggedParentScreen.routeName: (BuildContext context) =>
        LoggedParentScreen(),
    ChildTasksPage.routeName: (BuildContext context) =>
      ChildTasksPage(),
    AddKidScreen.routeName: (BuildContext context) => AddKidScreen(),
  };
}
