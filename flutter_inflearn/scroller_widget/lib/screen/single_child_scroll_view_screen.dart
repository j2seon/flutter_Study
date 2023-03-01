import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';
import 'package:scroller_widget/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(),
    );
  }

  Widget renderContainer({
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

  //1. 기본 랜더링 방법
  Widget renderSimple() {
    return SingleChildScrollView(
      //화면이 넘어가면 스크롤이 가능해짐
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(color: e),
            )
            .toList(),
      ),
    );
  }

  //2. 화면을 넘어가지 않아도 스크롤 되게하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      physics: AlwaysScrollableScrollPhysics(), //스크롤이 안되는데 가능하게 만드는 방법
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //3. 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(), //스크롤이 안되는데 가능하게 만드는 방법
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  //4. 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics - 스크롤 안됨
      // AlwaysScrollableScrollPhysicsa - 스크롤 됨.
      // BouncingScrollPhysics() - ios 스타일로
      // ClampingScrollPhysics - 안드로이드 스타일로
      physics: ClampingScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map(
              (e) => renderContainer(
                color: e,
              ),
            )
            .toList(),
      ),
    );
  }

  //5. SingleChildScrollView 퍼포먼스
  Widget renderPerformance(){
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
            color: rainbowColors[e % rainbowColors.length],
            index: e,
          ),
        ).toList(),
      ),
    );
  }

}
