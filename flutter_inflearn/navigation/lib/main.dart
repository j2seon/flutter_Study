
import 'package:flutter/material.dart';
import 'package:navigation/screen/home_screen.dart';
import 'package:navigation/screen/route_one_screen.dart';
import 'package:navigation/screen/route_three_screen.dart';
import 'package:navigation/screen/route_two_screen.dart';

//routes를 사용할 때 이름이 변경되서 오류가날수있음. 따라서 따로 변수로 선언해서 관리해주면된다.
const HOME_ROUTE = '/';

void main() {
  runApp(
    MaterialApp(
      // home: HomeScreen(),
      initialRoute: '/', //routeㄴ를 썼을 때 초기값 지정
      //www.google.com -> www.google.com/
      routes: {
        HOME_ROUTE : (context) => HomeScreen(),
        '/one' : (context) => RouteOneScreen(),
        '/two' : (context) => RouteTwoScreen(),
        '/three' : (context) => RouteThreeScreen(),
      },
    ),
  );
}
