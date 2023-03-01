import 'package:flutter/material.dart';

class WidgetApp extends StatefulWidget {
  const WidgetApp({Key? key}) : super(key: key);

  @override
  State<WidgetApp> createState() => _WidgetAppState();
}

class _WidgetAppState extends State<WidgetApp> {
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();
  List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  List<DropdownMenuItem<String>> _dropDownMenuItem = List.empty(growable: true);
  String? _buttonText;

  @override
  void initState() {
    super.initState();
    for(var item in _buttonList){
      _dropDownMenuItem.add(DropdownMenuItem(child: Text(item),value: item,));
    }
    _buttonText = _dropDownMenuItem[0].value;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Example'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text('flutter'),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: value1,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: value2,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '결과 : $sum',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.amber)),
                  onPressed: () {
                    setState(() {
                      double d1 = double.parse(value1.value.text);
                      double d2 = double.parse(value2.value.text);
                      var result;
                      if(_buttonText == '더하기'){
                        result = d1+d2;
                      }
                      if(_buttonText == '빼기'){
                        result = d1-d2;
                      }
                      if(_buttonText == '곱하기'){
                        result = d1*d2;
                      }
                      if(_buttonText == '나누기'){
                        result = d1/d2;
                      }

                      sum = '$result';
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text(_buttonText!),
                    ],
                  ),
                ),
                DropdownButton(
                  items: _dropDownMenuItem,
                  onChanged: (value) {
                    setState(() {
                      _buttonText = value.toString();
                    });
                  },
                  value: _buttonText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
