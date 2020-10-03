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
    final icon =
        [Icons.hourglass_empty, Icons.warning, Icons.check][this.status];

    final buttonWrapper =
        (widget) => Padding(padding: EdgeInsets.only(right: 8), child: widget);

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
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Row(children: [
                Icon(icon),
                Text(this.summary),
              ]),
            ),
            Row(children: [
              status == 0 || status == 2
                  ? SizedBox.shrink()
                  : buttonWrapper(MiniFlatButton(
                      color: Colors.green.shade100,
                      child: Text("✓ Confirm"),
                      onPressed: () {},
                    )),
              status == 2
                  ? SizedBox.shrink()
                  : buttonWrapper(MiniFlatButton(
                      color: Colors.red.shade100,
                      child: Text("X Deny"),
                      onPressed: () {},
                    )),
              buttonWrapper(MiniFlatButton(
                child: Text("🛈 Details"),
                onPressed: () {},
              )),
            ])
          ],
        ));
  }
}
