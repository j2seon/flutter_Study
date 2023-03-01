import 'dart:math';

import 'package:flutter/material.dart';
import 'package:random_number_generator/constant/color.dart';
import 'package:random_number_generator/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int maxNumeber = 1000;

  List<int> randomNumber=[
    123,
    456,
    789
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(onPressed: onSettingsPop),
              _Body(randomNumber: randomNumber),
              _Footer(onPressed: onRandomNumberGenerate),
            ],
          ),
        ),
      ),
    );
  }
  void onRandomNumberGenerate(){
    final rand = Random();

    final Set<int> newNumbers = {};
    while(newNumbers.length !=3){
      final number = rand.nextInt(maxNumeber);
      newNumbers.add(number);
    }
    setState(() {
      randomNumber = newNumbers.toList();
    });
  }

  void onSettingsPop() async {
      final int? result = await Navigator.of(context).push<int>( //push에 <>를 반영은 리턴할 타입의미
        MaterialPageRoute(
            builder: (context){
              return SettingsScreen(maxNumber: maxNumeber);
            }
        ),
      );
     if(result !=null){
       setState(() {
         maxNumeber = result;
       });
     }
  }
}

class _Header extends StatelessWidget {
  VoidCallback onPressed;

   _Header({required this.onPressed, Key? key}) : super(key: key);

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
          children : randomNumber.asMap().entries.
          map((x) => Padding(
            padding: EdgeInsets.only(bottom: x.key == 2 ? 0:16.0),
            child: Row(
              children: x.value
                  .toString()
                  .split('')
                  .map(
                    (e) => Image.asset(
                  'asset/img/$e.png',
                  height: 70.0,
                  width: 50.0,
                ),
              )
                  .toList(),
            ),
          ),
          )
              .toList()
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;
  const _Footer({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: RED_COLOR,
          ),
          onPressed : onPressed,
          child: Text('버튼')),
    );
  }
}

