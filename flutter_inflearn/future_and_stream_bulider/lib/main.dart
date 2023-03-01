import 'package:flutter/material.dart';
import 'package:future_and_stream_bulider/screen/HomeScreen.dart';
import 'package:future_and_stream_bulider/screen/HomeSreen_stream.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen_stream(),
    );
  }
}


