import 'package:flutter/material.dart';
import '../const/colors.dart';

class MainAppbar extends StatelessWidget {
  const MainAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ts = TextStyle(color: Colors.white, fontSize: 30.0);

    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: kToolbarHeight), //kToolbarHeight - appbar에 기본적으로 세팅되는 사이즈를 알수있다.
            child: Column(
              children: [
                Text(
                  '서울',
                  style: ts.copyWith(
                      fontSize: 40.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  DateTime.now().toString(),
                  style: ts.copyWith(fontSize: 20.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  'asset/img/mediocre.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '보통',
                  style: ts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 40.0,
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '나쁘지않네요',
                  style: ts.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
