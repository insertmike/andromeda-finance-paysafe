import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/child_info_card.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';

class MyChildrenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ChildInfoCard(
            name: "Dexter",
            balance: 400,
            completedTasks: 7,
            totalTasks: 10,
          )
        ],
      )
    );
  }
}
