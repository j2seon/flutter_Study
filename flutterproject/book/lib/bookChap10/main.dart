import 'package:flutter/material.dart';
import 'dart:async';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StopWatchPage(),
    );
  }
}


class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);

  @override
  State<StopWatchPage> createState() => _StopWatchPageState();
}

class _StopWatchPageState extends State<StopWatchPage> {

  Timer? _timer; // 타이머

  var _time = 0; // 증가 시킬 초
  var _isRunning = false; //시작상태

  List<String> _lapTime = []; // 랩타입 저장 리스트

  @override
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch'),
      ),
      body: _bulidBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _isRunning ? Icon(Icons.pause) : Icon(Icons.play_arrow),
        onPressed: (){
          setState(() {
            _clickButton();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _bulidBody(){
    var sec = _time ~/ 100; //초
    var hundredth = '${_time % 100}'.padLeft(2,'0');
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top:30),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('$sec',
                      style: TextStyle(fontSize: 50.0),
                    ),
                    Text('$hundredth'),
                  ],
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: ListView(
                    children: _lapTime.map((time) => Text(time)).toList(),
                  ),
                )
              ],
            ),
            Positioned(
              left:10,
              bottom: 10,
              child: FloatingActionButton(
                backgroundColor: Colors.deepOrange,
                onPressed: _reset,
                child: Icon(Icons.rotate_left),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: ElevatedButton(
                child: Text('랩타임'),
                onPressed: (){
                  setState(() {
                    _recordLapTime('$sec.$hundredth');
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _clickButton(){
    _isRunning =! _isRunning;
    if(_isRunning){
      _start();
    }else{
      _pause();
    }
  }

  void _start(){
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _time++;
      });
    });
  }

  void _pause(){
    _timer?.cancel();
  }

  void _reset(){
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _lapTime.clear();
      _time = 0;
    });
  }
  void _recordLapTime(String time){
    _lapTime.insert(0, '${_lapTime.length +1}등 $time ');
    print(time);
  }

}
