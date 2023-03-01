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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Text('남자'),
                leading: Radio(
                  value: Gender.MAN,
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('여자'),
                leading: Radio(
                  value: Gender.WOMEN,
                  groupValue: _gender,
                  onChanged: (value){
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
              ),
              RadioListTile(
                title: Text('여자'),
                  value: Gender.WOMEN,
                  groupValue: _gender,
                  onChanged: (value){
                    setState(() {
                      _gender = value!;
                    });
                  },
              ),
              RadioListTile(
                title: Text('여자'),
                  value: Gender.WOMEN,
                  groupValue: _gender,
                  onChanged: (value){
                    setState(() {
                      _gender = value!;
                    });
                  },
              ),
            ],
          ),
        ),
      )
    );
  }
}


