import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen_stream extends StatefulWidget {
  const HomeScreen_stream({Key? key}) : super(key: key);

  @override
  State<HomeScreen_stream> createState() => HomeScreen_streamState();
}

class HomeScreen_streamState extends State<HomeScreen_stream> {
  final textStyle = const TextStyle(
    fontSize: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //future를 반환하는 함수를 받을 수 있다.`
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<int>(
          stream: streamNumbers(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'StreamBuilder',
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'ConState : ${snapshot.connectionState}',
                  style: textStyle,
                ),
                Row(
                  children: [
                    Text(
                      'Data : ${snapshot.data}',
                      style: textStyle,
                    ),
                    if (snapshot.connectionState == ConnectionState.waiting)
                      CircularProgressIndicator(),
                  ],
                ),
                Text(
                  'Error : ${snapshot.error}',
                  style: textStyle,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  child: Text('setState'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  //future를 반환하는 함수
  Future<int> getNumber() async {
    await Future.delayed(Duration(seconds: 3));
    final random = Random();

    // throw Exception('에러가 발생했습니다');

    return random.nextInt(100);
  }

  //Stream 사용
  Stream<int> streamNumbers() async* {
    for(int i = 0; i<10 ; i++){
      if(i == 5){
        throw Exception('에러발생');
      }
      await Future.delayed(Duration(seconds: 1));
      yield i;
    }
  }
}
