
import 'package:flutter/material.dart';

import '../const/colors.dart';

class _SliverFixedHeaderDel extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double max;
  final double min;

  _SliverFixedHeaderDel({
    required this.child,
    required this.max,
    required this.min
  });

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => max;

  @override
  // TODO: implement minExtent
  double get minExtent => min;

  @override
  bool shouldRebuild(_SliverFixedHeaderDel oldDelegate) {
    return oldDelegate.min != min ||
    oldDelegate.max != max ||
    oldDelegate.child != child;
  }

}


class CustomScroll extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScroll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderAppBar(),
          rendHeader(),
          renderChildGrid(),
          renderChildSliverList(),
        ],
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

  SliverList renderChildSliverList() {
    return SliverList(
        delegate: SliverChildListDelegate(
          numbers
              .map(
                (e) =>
                renderContainer(
                  color: rainbowColors[e % rainbowColors.length],
                  index: e,
                ),
          )
              .toList(),
        ));
  }

  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      }, childCount: 10),
    );
  }

  SliverGrid renderChildGrid() {
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
          crossAxisCount: 3
      ),
    );
  }

  SliverAppBar renderAppBar() {
    return SliverAppBar(
      title: Text('customSliverAppbar'),
      floating: true,
      snap: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  SliverPersistentHeader rendHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDel(
        child: Container(
          color: Colors.cyanAccent,
          child: Center(
            child: Text('Text',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        max: 100,
        min: 50,
      )
    );
  }

}
