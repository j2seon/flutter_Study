import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/practice_layout.dart';

class Lists extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'ListView',
      body: renderSep(),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    return Container(
      height: height ?? 300,
      color: color,
      child: Text(
        index.toString(),
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 40.0),
      ),
    );
  }

  Widget renderListView() {
    return ListView(
      children: numbers
          .map(
            (e) => renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
          )
          .toList(),
    );
  }

  Widget renderListBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  Widget renderSep() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return renderContainer(
          color: Colors.cyanAccent,
          index: index,
          height: 50,
        );
      },
    );
  }
}
