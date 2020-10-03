import 'package:flutter/material.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/utils/mockup_data.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/widgets/child_task_card.dart';
import 'package:kidromeda/widgets/segregated_task_list.dart';

class LoggedChildScreen extends StatelessWidget {
  static const routeName = '/logged_child';

  @override
  Widget build(BuildContext context) {
    // FIXME
    Kid kid = getChildren().first;

    return Scaffold(
        appBar: AppBar(
          title: Text("My Tasks"),
          centerTitle: true,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      '/',
                    )),
          ],
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: ChildDetailsCard(
                      kid: kid,
                    ),
                  ),
                  SegregatedTaskList(
                    physics: NeverScrollableScrollPhysics(),
                    tasks: kid.tasks,
                    builder: (context, task) => ChildTaskCard(task: task),
                  )
                ],
            )))
    );
  }
}
