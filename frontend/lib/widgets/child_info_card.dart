import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';

class ChildInfoCard extends StatelessWidget {
  final int index;
  final String name;
  final double balance;
  final int completedTasks;
  final int totalTasks;

  const ChildInfoCard(
      {Key key,
      @required this.index,
      @required this.name,
      @required this.balance,
      @required this.completedTasks,
      @required this.totalTasks})
      : super(key: key);

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
              Text(this.name,
                  style:
                      TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
              Text("₩ ${this.balance}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300))
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircularPercentageIndicator(
                      value: this.completedTasks / this.totalTasks, size: 48),
                  Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                          "${this.completedTasks} out of ${this.totalTasks} completed"),
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
                            onPressed: () => Navigator.pushNamed(
                                context, '/child_tasks',
                                arguments: {'index': this.index}),
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
