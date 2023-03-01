import 'package:flutter/material.dart';
import 'package:navi/Intro.dart';
import 'package:navi/Shopping.dart';
import 'package:navi/MyPage.dart';
import 'package:navi/Community.dart';


void main()=> runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Intro(),
        '/shopping': (context) => Shopping(),
        '/mypage': (context) => MyPage(),
        '/community': (context) => Community(),
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}





