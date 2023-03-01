import 'package:dust/component/card_title.dart';
import 'package:dust/component/category_card.dart';
import 'package:dust/component/main_Drawer.dart';
import 'package:dust/component/main_app_bar.dart';
import 'package:dust/component/main_card.dart';
import 'package:dust/component/main_stat.dart';
import 'package:dust/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      backgroundColor: primaryColor,
      body: CustomScrollView(
        slivers: [
          MainAppbar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                const SizedBox(
                  height: 16.0,
                ),
                MainCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle(
                        title: '시간별 미세먼지',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: List.generate(24, (index) {
                            final now = DateTime.now();
                            final hour = now.hour;
                            int currentHour = hour - index;

                            if(currentHour < 0){
                              currentHour +=24;
                            }
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$currentHour 시'),
                                Image.asset(
                                  'asset/img/best.png',
                                  height: 20.0,
                                ),
                                Text('좋음'),
                              ],
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
