import 'package:flutter/material.dart';
import 'package:scroller_widget/layout/practice_layout.dart';
import 'package:scroller_widget/screen_pratice/CustomScroll.dart';
import 'package:scroller_widget/screen_pratice/Single_ListView.dart';
import 'package:scroller_widget/screen_pratice/grid_view.dart';
import 'package:scroller_widget/screen_pratice/list_view.dart';
import 'package:scroller_widget/screen_pratice/refresh.dart';
import 'package:scroller_widget/screen_pratice/reorder.dart';

class ScreenButton {
  final String name;
  final WidgetBuilder builder;

  ScreenButton({required this.builder, required this.name});
}

class HomeScreen2 extends StatelessWidget {
  final screens = [
    ScreenButton(builder: (_) => Single(), name: 'SingleChildScrollViewScreen'),
    ScreenButton(builder: (_) => Lists(), name: 'ListView'),
    ScreenButton(builder: (_) => Grids(), name: 'GridView'),
    ScreenButton(builder: (_) => reOrder(), name: 'reOrderable'),
    ScreenButton(builder: (_) => CustomScroll(), name: 'CustomScroll'),
    ScreenButton(builder: (_) => RefreshIndi(), name: 'RefreshIndi'),
  ];

  HomeScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PracticeLayout(
      titles: 'mainHome',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: screens
              .map(
                (e) => ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: e.builder,
                      ),
                    );
                  },
                  child: Text(e.name),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
