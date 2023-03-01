import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum Gender {MAN,WOMEN}

Gender _gender = Gender.MAN;


class _MyHomePageState extends State<MyHomePage> {

  var _isChecked = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (value){
                setState(() {
                  _isChecked = value!;
                });
              }
            ),
            SizedBox(
              height: 10.0,
            ),
            Switch(
              value: _isChecked,
              activeColor: Colors.cyan,
              onChanged: (value){
                setState(() {
                  _isChecked = value;
                });
              }
            ),
          ],
        ) ,
      ),
    );
  }
}


