import 'package:flutter/material.dart';
import 'package:kidromeda/widgets/circular_percentage_indicator.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';

class TaskInfoCard extends StatelessWidget {
  final String summary;
  final int status;

  const TaskInfoCard({
    Key key,
    @required this.summary,
    @required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = [Icons.hourglass_empty, Icons.warning, Icons.check][this.status];

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
            Row(children: [
              Icon(icon),
              Text(this.summary),
            ]),
            // TODO: Only show these for pending tasks (status=1)
            Row(children: [
              MiniFlatButton(
                child: Text("✓ Confirm"),
                onPressed: () {},
              ),
              MiniFlatButton(
                child: Text("X Deny"),
                onPressed: () {},
              ),
              MiniFlatButton(
                child: Text("🛈 Details"),
                onPressed: () {},
              ),
            ])
          ],
        ));
  }
}
