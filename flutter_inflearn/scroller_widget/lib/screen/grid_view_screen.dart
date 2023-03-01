import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MainLayout(
      title: 'GridViewScreen',
      body: renderMaxExtent(),
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

  //1. 한번에 다 그림
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 2, //가로
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map(
            (e) =>
            renderContainer(
                color: rainbowColors[e % rainbowColors.length], index: e),
      )
          .toList(),
    );
  }


  //2. 보이는 것만
  Widget renderBuilderCrossAxisCount(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ), //
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
    );
  }

  //3. 최대사이즈
  Widget renderMaxExtent(){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, //길이
      ), //
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length], index: index,);
      },
      itemCount: 100,
    );
  }
}
