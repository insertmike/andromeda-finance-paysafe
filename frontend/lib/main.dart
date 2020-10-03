import 'package:flutter/material.dart';

void main() => runApp(KidromedaApp());


class KidromedaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kidromeda',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text('Kidromeda'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Financial Application For Kids',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
    ),
    );
  }
}
