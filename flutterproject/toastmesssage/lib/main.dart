import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'toast',
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('toastMessage'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('showme'),
          onPressed: (){
            flutterToast();
          },
        ),
      ),
    );
  }
}

void flutterToast(){
  Fluttertoast.showToast(msg: 'flutter',
  gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.blue,
    fontSize: 20.0,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_SHORT,
  );

}