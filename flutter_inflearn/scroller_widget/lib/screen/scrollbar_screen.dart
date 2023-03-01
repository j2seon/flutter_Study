import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/main_layout.dart';

class ScrollbarScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ScrollbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ScrollbarScreen',
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainer(
                    color: rainbowColors[e % rainbowColors.length],
                    index: e,
                  ),
                ).toList(),
          ),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    return Container(
      key: Key(index.toString()), //시스템이 변화한 값이라고 인식할수있는 key가 필요하다.
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
