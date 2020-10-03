import 'package:flutter/material.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/utils/mockup_data.dart' show getChildren;
import 'package:kidromeda/widgets/child_info_card.dart';
import '../utils/string_utils.dart';
import '../utils/math_utils.dart';

class MyChildrenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Kid> children = getChildren();

    return Container(
        child: ListView.builder(
      itemCount: children.length,
      itemBuilder: (context, position) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8),
              child: ChildInfoCard(
                kid: children[position],
              ),
            )
          ],
        );
      },
    ));
  }
}
