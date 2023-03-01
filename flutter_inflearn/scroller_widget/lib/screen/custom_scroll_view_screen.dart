import 'package:flutter/material.dart';
import 'package:scroller_widget/const/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate{
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override // 최대높이
  double get maxExtent => maxHeight;

  @override //최소높이
  double get minExtent => minHeight;

  @override // 자동완성
  //covariant - 상속된 클래스도 사용가능
  //oldDelegate - build가 실행 됐을때 이전 Delegate
  //this - 새로운 delegate
  //shouldRebuild - 새로 build를 할지말지 결정
  //false - build안함 , true - 빌드 다시함.
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;

  }

}


class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          //직접 class를 구현해야한다.
          renderHeader(),
          renderBuliderSliverList(),
          renderHeader(),
          renderSliverGridBulider(),
          renderBuliderSliverList(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader(){
    return SliverPersistentHeader(
      pinned: true, //header가 쌓임!!!
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text('신기',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        maxHeight: 150,
        minHeight: 50,
      ),
    );
  }


  //AppBar
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      floating: true,
      // 내릴때는 appbar안보이고 위로 올리면 보임.
      pinned: false,
      //appbar 완전고정
      snap: true,
      //자석효과 floating이 true일때 쓸수있다.
      stretch: true,
      // 맨위에서 한 개 이상으로 스크롤 했을 때 남는 공간을 차지
      expandedHeight: 200,
      //최대사이즈(appbar)
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpaceBar'),
      ),
      title: Text('CustomScrollviewScreen'),
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

  //GridView.count와 비슷
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList()),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
    );
  }

  //GridView.builder와 비슷
  SliverGrid renderSliverGridBulider() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 100),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
      ),
    );
  }

  //ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      //delegate 안에는 ListView의 child의 내용에 들어갈 것들을 넣으면된다.
      delegate: SliverChildListDelegate(numbers
          .map(
            (e) =>
            renderContainer(
              color: rainbowColors[e % rainbowColors.length],
              index: e,
            ),
      )
          .toList()),
    );
  }

  //ListView.bulider 생성자와 유사함.
  SliverList renderBuliderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
    );
  }
}
