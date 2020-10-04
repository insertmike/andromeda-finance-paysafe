import 'package:flutter/material.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/services/task_service.dart';
import 'package:kidromeda/utils/authentication_utils.dart';
import 'package:kidromeda/widgets/child_info_card.dart';

class MyChildrenPage extends StatefulWidget {
  @override
  _MyChildrenPageState createState() => _MyChildrenPageState();
}

class _MyChildrenPageState extends State<MyChildrenPage> {
  final Future<List<Kid>> _kidsFuture = _getKids();

  static Future<List<Kid>> _getKids() async {
    return fetchKidsAsync(await AuthenticationUtils.getToken(),
        await AuthenticationUtils.getId());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Kid>>(
        future: _kidsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Kid>> snapshot) {
          if (snapshot.hasData) {
            final children = snapshot.data;
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
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(snapshot.hasError ? snapshot.error.toString() : 'Loading...'),
                  )
                ],
              ),
            );
          }
        });
  }
}
