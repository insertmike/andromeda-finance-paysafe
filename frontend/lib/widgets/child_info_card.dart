import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';
import '../models/kid.dart';
import '../utils/math_utils.dart';
import '../screens/child_tasks_page.dart';

class ChildInfoCard extends StatelessWidget {
  final Kid kid;

  const ChildInfoCard({Key key, @required this.kid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
              Text(this.kid.name,
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
              Text("₩ ${this.kid.balance}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300))
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularPercentageIndicator(
                      value: getCompletedTasksNumber(this.kid.tasks) /
                          this.kid.tasks.length,
                      size: 48),
                  Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          "${getCompletedTasksNumber(this.kid.tasks)} out of ${this.kid.tasks.length} completed"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: MiniFlatButton(
                            child: Text("₩ Transaction"),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          child: MiniFlatButton(
                            child: Text("✓ Tasks"),
                            onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChildTasksPage(kid: kid))),
                          ),
                        ),
                      ],
                    )
                  ])
                ])
          ],
        ));
  }
}
