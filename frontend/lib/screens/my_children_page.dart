import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kidromeda/models/auth_token.dart';
import 'package:kidromeda/models/kid.dart';
import 'package:kidromeda/services/task_service.dart';
import 'package:kidromeda/utils/authentication_utils.dart';
import 'package:kidromeda/widgets/child_info_card.dart';

class MyChildrenPage extends StatefulWidget {
  @override
  _MyChildrenPageState createState() => _MyChildrenPageState();
}

class _MyChildrenPageState extends State<MyChildrenPage> {
  Future<List<Kid>> _kidsFuture = _getKids();
  Timer _timer;

  static Future<List<Kid>> _getKids() async {
    AuthToken token = await AuthenticationUtils.getToken();
    int id = await AuthenticationUtils.getId();
    print(id);
    return await fetchKidsAsync(token, id);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(new Duration(seconds: 1), (timer) {
      refreshData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void refreshData() {
    setState(() {
      _kidsFuture = _getKids();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Kid>>(
        future: _kidsFuture,
        builder: (BuildContext context, AsyncSnapshot<List<Kid>> snapshot) {
          print(snapshot.data);
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
                    child: Text(snapshot.hasError
                        ? snapshot.error.toString()
                        : 'Loading...'),
                  )
                ],
              ),
            );
          }
        });
  }
}
