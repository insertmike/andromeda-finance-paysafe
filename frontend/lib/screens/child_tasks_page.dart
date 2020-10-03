import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/child_details_card.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/widgets/task_info_card.dart';
import '../models/kid.dart';

class ChildTasksPage extends StatefulWidget {
  static const routeName = '/child_tasks';
  final Kid kid;
  ChildTasksPage({this.kid});
  @override
  _ChildTasksPageState createState() => _ChildTasksPageState();
}

class _ChildTasksPageState extends State<ChildTasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.kid.name}'s Tasks"),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ChildDetailsCard(
                    kid: widget.kid,
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.kid.tasks.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TaskInfoCard(
                          summary: widget.kid.tasks[index].summary,
                          status: widget.kid.tasks[index].status,
                        )),
              ],
            )));
  }
}
