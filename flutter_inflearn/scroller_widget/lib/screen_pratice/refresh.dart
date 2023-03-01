import 'package:flutter/material.dart';
import 'package:scroller_widget/layout/practice_layout.dart';

import '../const/colors.dart';

class RefreshIndi extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  RefreshIndi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'RefreshIndicator',
      body: RefreshIndicator(
        child: ListView(
          children: numbers
              .map(
                (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          ).toList(),
        ),
        onRefresh:() async{
          await Future.delayed(Duration(seconds: 3));
        },
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
