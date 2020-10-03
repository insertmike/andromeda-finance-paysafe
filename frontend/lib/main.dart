import 'package:flutter/material.dart';
import './routes.dart';
import './theme.dart';

void main() => runApp(KidromedaApp());

class KidromedaApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health4Carers',
      theme: AppTheme.theme,
      routes: Routes.routes,
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
    );
  }
}
