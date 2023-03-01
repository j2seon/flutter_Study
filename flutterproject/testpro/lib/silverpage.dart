import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hero',
      home: SilverPage(),
    );
  }
}

class SilverPage extends StatefulWidget {
  const SilverPage({Key? key}) : super(key: key);

  @override
  State<SilverPage> createState() => _SilverPageState();
}

class _SilverPageState extends State<SilverPage> {

  var _items = List.generate(50, (index) => ListTile(title: Text('No $index'),));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true, // 축소될때 상단 Appbar가 고정될지
            expandedHeight: 180.0, //확대될때 최대 높이 => 헤더의 최대 높이
            flexibleSpace: FlexibleSpaceBar(// 확대 츅소되는 영역의 UI작성
              title: const Text('Sliver'),
              background: Image.asset('image/img1.jpg',
              fit: BoxFit.fill,
              ),
            ),
          ),
          // const SliverFillRemaining(
          //   child: Center(
          //     child: Text('center'),
          //   ),
          // ),
          SliverList(
              delegate: SliverChildListDelegate(_items),
          ),
        ],
      ),
    );
  }
}
