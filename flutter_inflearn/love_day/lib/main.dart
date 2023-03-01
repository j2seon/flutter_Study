import 'package:flutter/material.dart';
import 'package:love_day/screen/Home_Screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sunflower', // 기본 폰트지정
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.white,
            fontFamily: 'parisienne',
            fontSize: 80.0,
          ),
          headline2: TextStyle(
              color: Colors.white,
              fontSize: 50.0,
              fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
          bodyText2: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      home: const HomeScreen(),
    ),
  );
}
