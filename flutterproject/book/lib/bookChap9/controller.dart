import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text',
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {


  final myController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();

  }

  _printLatestValue(){
    print("두번째 text field: $myController");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('input'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text){
              print('첫번째 텍스트 : $text');
            },
          ),
          TextField(
            controller: myController,
          )
        ],
      ),
    );
  }
}
