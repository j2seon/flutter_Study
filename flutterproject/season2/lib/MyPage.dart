import 'package:flutter/material.dart';
import 'package:season2/responsive/desktopBody.dart';
import 'package:season2/responsive/mobileBody.dart';
import 'package:season2/responsive/responsive_layout.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    //미디어 쿼리
    // final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ResponsiveLayout(
          mobileBody: MobileBody(),
          desktopBody: DesktopBody(),
      ),
    );
  }
}

