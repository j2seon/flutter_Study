import 'package:flutter/material.dart';
import 'package:scroller_widget/layout/practice_layout.dart';

import '../const/colors.dart';

class reOrder extends StatefulWidget {
  const reOrder({Key? key}) : super(key: key);

  @override
  State<reOrder> createState() => _reOrderState();
}

class _reOrderState extends State<reOrder> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'reOrder',
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        itemCount: numbers.length,
        onReorder:(oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
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
