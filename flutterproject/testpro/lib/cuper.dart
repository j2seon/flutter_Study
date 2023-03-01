import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hero',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _isOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('쿠퍼티노'),
      ),
      body: Column(
        children: [
          CupertinoSwitch(
              value: _isOn,
              onChanged: (bool value){
                setState(() {
                  _isOn = value;
                });
              },
          ),
          CupertinoButton(
            borderRadius: BorderRadius.circular(16.0),
            color: Colors.orange,
            child: const Text('버튼'),
            onPressed: (){
              _showCupertinoDialog();
            }
          ),
          CupertinoButton(
            child: const Text('버튼1'),
            onPressed: (){
              _showCupertinoPicker();
            }
          ),
        ],
      ),
    );
  }

  _showCupertinoDialog(){
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('제목'),
        content: const Text('본문'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancle'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text('ok'),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  _showCupertinoPicker() async {

    final _items = List.generate(10, (index) => index);
    var result =_items[0];

    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 200,
        child: CupertinoPicker(
          itemExtent: 50.0, // 항목1개의 높이
          onSelectedItemChanged: (int value) {
            result = _items[value];
          },
          children: _items.map((e) => Text('no $e')).toList(),
        ),
      ),
    );
    print(result);
  }

}
