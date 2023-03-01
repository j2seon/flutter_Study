import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
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
        title: Text('SnackBar'),
        centerTitle: true,
      ),
      body:Builder(
        builder: (context) {
          return Center(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)
              ),
              child: Text(
                'show me',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('hellow'),
                ));
              },
            ),
          );
        },
      ),
    );
  }
}

