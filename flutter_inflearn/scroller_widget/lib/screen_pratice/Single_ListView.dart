import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/practice_layout.dart';

class Single extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  Single({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'SingleChildScrollerView',
      body: renderNumber(),
    );
  }

  Widget renderContain({
    required Color color,
    int? index,
  }) {

    if(index != null){
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }

  Widget renderDefault() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContain(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderNumber() {
    return SingleChildScrollView(
      child: Column(
        children: numbers.map(
          (e) => renderContain(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        ).toList(),
      ),
    );
  }
}
