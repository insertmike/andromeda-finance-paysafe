import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';

class ChildDetailsCard extends StatelessWidget {
  final String email;
  final double balance;
  final int completedTasks;
  final int totalTasks;

  const ChildDetailsCard(
      {Key key,
      @required this.balance,
      @required this.email,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text("₩ ${this.balance}",
                      style:
                          TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(this.email,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).primaryColorLight)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                      "${this.completedTasks} out of ${this.totalTasks} completed",),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 8),
                  child: MiniFlatButton(
                    child: Text("+ Add Task"),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            CircularPercentageIndicator(
              size: 96,
              strokeWidth: 8,
              value: this.completedTasks / this.totalTasks,
            ),
          ],
        ),
    );
  }
}
