import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/component/number_row.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screens2.dart';

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  int maxnumber =1000;
  List<int> randomNumber = [123, 456, 789];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _Header(
                onPressed: onSettingsPop,
              ),
              _Body(randomNumber: randomNumber),
              _Footer(onPressed: onRandomGenerated),
            ],
          ),
        ),
      ),
    );
  }

  void onRandomGenerated() {
    final rand = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length != 3) {
      final number = rand.nextInt(maxnumber);
      newNumbers.add(number);
    }

    setState(() {
      randomNumber = newNumbers.toList();
    });
  }
  void onSettingsPop() async { // 페이지이동을 하는 곳에서 넘겨받을수있다. > 넘겨받는 타입도 지정가능
    final int? result = await Navigator.of(context).push<int>(
      MaterialPageRoute(
        builder: (context) {
          return SettingsScreens2(maxNumber: maxnumber);
        },
      ),
    );

   if(result !=null){
     setState(() {
       maxnumber= result;
     });
   }
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;
  const _Header({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '랜덤숫자생성기',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
            color: RED_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> randomNumber;

  const _Body({required this.randomNumber, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: randomNumber
              .asMap()
              .entries
              .map(
                (x) => Padding(
                  padding: EdgeInsets.only(bottom: x.key == 2 ? 0 : 16.0),
                  child: NumberRow(number: x.value
                  ),
                ),
              )
              .toList()),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          onPressed: onPressed,
          child: Text('버튼')),
    );
  }
}
