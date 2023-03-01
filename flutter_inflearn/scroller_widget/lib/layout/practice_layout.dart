import 'package:flutter/material.dart';

class PracticeLayout extends StatelessWidget {
  final String titles;
  final Widget body;
 //외부에서 받아서~ 레이아웃을 만들어주자

  const PracticeLayout({
    required this.titles,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles),
      ),
      body: body,
    );
  }
}
