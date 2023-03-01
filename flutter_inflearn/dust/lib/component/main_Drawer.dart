import 'package:dust/const/colors.dart';
import 'package:flutter/material.dart';

const regions = [
  //추후 변경
  '서울',
  '경기',
  '대구',
  '충남',
  '인천',
  '대전',
  '경북',
  '새종',
  '광주',
  '전북',
  '강원',
  '전남',
  '울산',
  '제주',
  '부산',
  '충북',
  '경남',
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          //타이틀
          DrawerHeader(
            child: Text(
              '지역선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...regions.map(
            (e) => ListTile(
              onTap: () {},
              tileColor: Colors.white,
              selectedTileColor: lightColor,
              //선택된 타일배경색
              selectedColor: Colors.black,
              //선택된 글자색
              selected: e == '서울',
              //bool타입
              title: Text(e),
            ),
          ).toList(),
        ],
      ),
    );
  }
}
