import 'package:flutter/material.dart';
import 'package:kidromeda/models/task.dart';
import 'package:kidromeda/widgets/mini_flat_button.dart';
import './custom_dialog.dart';

/// The child sees these.
class ChildTaskCard extends StatelessWidget {
  final Task task;

  const ChildTaskCard({
    Key key,
    @required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = [
      Icons.hourglass_empty,
      Icons.warning_amber_rounded,
      Icons.check
    ][this.task.status];

    final buttonWrapper =
        (widget) => Padding(padding: EdgeInsets.only(left: 8), child: widget);

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
                Padding(child: Icon(icon), padding: EdgeInsets.only(right: 8)),
                Text(task.summary),
              ]),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  task.status == 0
                      ? buttonWrapper(MiniFlatButton(
                          color: Colors.green.shade100,
                          child: Text("✓ Confirm"),
                          onPressed: () {},
                        ))
                      : buttonWrapper(MiniFlatButton(
                          child: Text("🛈 Details"),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (_) => CustomDialogBox(
                                    img: Image.asset(
                                        'assets/images/piggy_bank.png'),
                                    title: 'Task Details',
                                    text: 'OK',
                                    descriptions: task.summary,
                                  )),
                        )),
                ])
          ],
        ));
  }
}
