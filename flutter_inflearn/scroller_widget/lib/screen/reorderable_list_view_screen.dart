import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return renderContainer(
            color: rainbowColors[numbers[index] % rainbowColors.length],
            index: numbers[index],
          );
        },
        itemCount: numbers.length,
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            // [red, orange, yellow]
            //index[0, 1, 2]
            // red를 yellow 다음으로 옮기고 싶을 때
            // red : 0(oldIndex) -> 3(newIndex) 즉, 옮기기전에 산정된다.

            // [red, orange, yellow]
            // yellow를 맨앞 로 옮기고싶다.
            // yellow :2(oldIndex) -> 0 (newIndex)
            // [yellow, red, orange]
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final item = numbers.removeAt(oldIndex); //특정위치에 있는 값을 뺀다.
            numbers.insert(newIndex, item); //새로운위치에 , 뭘 넣어줄것인지?
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

  Widget renderDefault() {
    return ReorderableListView(
      // 화면에서 순서를 바꿔주는 역할을 한다.
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // [red, orange, yellow]
          //index[0, 1, 2]
          // red를 yellow 다음으로 옮기고 싶을 때
          // red : 0(oldIndex) -> 3(newIndex) 즉, 옮기기전에 산정된다.

          // [red, orange, yellow]
          // yellow를 맨앞 로 옮기고싶다.
          // yellow :2(oldIndex) -> 0 (newIndex)
          // [yellow, red, orange]
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = numbers.removeAt(oldIndex); //특정위치에 있는 값을 뺀다.
          numbers.insert(newIndex, item); //새로운위치에 , 뭘 넣어줄것인지?
        });
      },
    );
  }
}
