import 'package:flutter/material.dart';
import 'package:videocallchat/screen/Home_Screen.dart';

// 1d3a9dd4cad445d1b21304e4ee3a008f
//testchannel
//007eJxTYLAX0ng1IaHaUvBrEB8bu03iupj+pRz3TiWFTY5aubznYLYCg2GKcaJlSopJcmKKiYlpimGSkaGxgUmqSWqqcaKBgUWaXXdCckMgI4OMoiMzIwMEgvjcDCWpxSXJGYl5eak5DAwAWrsfVQ==


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: const Home_Screen(),
    );
  }
}
