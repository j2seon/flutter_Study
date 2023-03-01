import 'package:flutter/material.dart';
import 'package:scroller_widget/layout/practice_layout.dart';

import '../const/colors.dart';

class Grids extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  Grids({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'GridView',
      body: BuilderGridViewExtent(),
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

  Widget renderGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map(
            (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
          )
          .toList(),
    );
  }

  Widget BuilderGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
    );
  }

  Widget BuilderGridViewExtent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
      itemCount: 100,
    );
  }
}
