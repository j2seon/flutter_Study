import 'package:flutter/material.dart';

import '../../model/AnimalItem.dart';

class SecondApp extends StatefulWidget {
  final List<Animal> list;
  const SecondApp({required this.list, Key? key}) : super(key: key);

  @override
  State<SecondApp> createState() => _SecondAppState();
}

class _SecondAppState extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
              Row(
                children: [
                  Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange,),
                  Text('양서류'),
                  Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                  Text('파충류'),
                  Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                  Text('포유류'),
                ],
              ),
              Row(
                children: [
                  Text('날수있나요?'),
                  Checkbox(value: flyExist, onChanged: (value) {
                    setState(() {
                      flyExist = value;
                    });
                  },),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  _radioChange(int? value){
     setState(() {
      _radioValue = value;
    });
  }
}
