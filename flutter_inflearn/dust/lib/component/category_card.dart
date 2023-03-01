import 'package:dust/component/card_title.dart';
import 'package:dust/component/main_card.dart';
import 'package:flutter/material.dart';

import '../const/colors.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        child: LayoutBuilder(
          builder: (context, constraint) {//constraint 하고 . 하면 최대높이 최소높이 너비 등을 알수있다.
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
                ),
                Expanded( //스크롤 가능한 위젯이 column 안에 있을때 expanded를 해야한다.
                  child: ListView(
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal, //방향변경
                    children: List.generate(
                      20,
                      (index) => MainStat(
                        category: '미세먼지',
                        imgPath: 'asset/img/best.png',
                        level: '최고',
                        stat: '0μg/m3',
                        width: constraint.maxWidth / 3,
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
