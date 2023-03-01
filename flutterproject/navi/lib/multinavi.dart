import 'package:flutter/material.dart';
import 'package:navi/ScreenA.dart';
import 'package:navi/ScreenB.dart';
import 'package:navi/ScreenC.dart';


// void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ScreenA(),
        '/B': (context) => ScreenB(),
        '/C': (context) => ScreenC(),
      },
    );
  }
}


