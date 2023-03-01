import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

void main(){
  runApp(Subway());
}


class Subway extends StatelessWidget {
  const Subway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '지하철 실시간 정보',
      home : MainPage();
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('지하철 실시간 정보'),
      ),
    );
  }
}
