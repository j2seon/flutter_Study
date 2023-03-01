import 'package:flutter/material.dart';
import 'package:scroller_widget/screen/custom_scroll_view_screen.dart';
import 'package:scroller_widget/screen/grid_view_screen.dart';
import 'package:scroller_widget/screen/list_view_screen.dart';
import 'package:scroller_widget/screen/refresh_indicator.dart';
import 'package:scroller_widget/screen/reorderable_list_view_screen.dart';
import 'package:scroller_widget/screen/scrollbar_screen.dart';
import 'package:scroller_widget/screen/single_child_scroll_view_screen.dart';
import 'package:scroller_widget/layout/main_layout.dart';

class ScreenModel {
  final WidgetBuilder builder;
  final String name;

  ScreenModel({
    required this.builder,
    required this.name,
  });
}

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
      builder: (_) => SingleChildScrollViewScreen(),
      name: 'SingleChildScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ListViewScreen(),
      name: 'ListViewScreen',
    ),
    ScreenModel(
      builder: (_) => GridViewScreen(),
      name: 'GridViewScreen',
    ),
    ScreenModel(
      builder: (_) => ReorderableListViewScreen(),
      name: 'ReorderableListViewScreen',
    ),
    ScreenModel(
      builder: (_) => CustomScrollViewScreen(),
      name: 'CustomScrollViewScreen',
    ),
    ScreenModel(
      builder: (_) => ScrollbarScreen(),
      name: 'ScrollbarScreen',
    ),
    ScreenModel(
      builder: (_) => RefreshIndicatorScreen(),
      name: 'RefreshIndicatorScreen',
    ),
  ];

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens
                .map(
                  (screen) => ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: screen.builder),
                      );
                    },
                    child: Text(screen.name),
                  ),
                ).toList(),
          ),
        ),
      ),
    );
  }
}
