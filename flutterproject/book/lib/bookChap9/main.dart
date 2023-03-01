import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BmiMain(),
    );
  }
}

class BmiMain extends StatefulWidget {
  const BmiMain({Key? key}) : super(key: key);

  @override
  State<BmiMain> createState() => _BmiMainState();
}

class _BmiMainState extends State<BmiMain> {

  final _formKey = GlobalKey<FormState>(); // 폼의 상태 얻기
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: '키',
                  border: OutlineInputBorder(),
                ),
                controller: _heightController,
                keyboardType: TextInputType.number, //숫자만 입력
                validator: (value) {
                  if(value!.trim().isEmpty){
                    return '키를 입력해주세요';
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: '몸무게',
                  border: OutlineInputBorder(),
                ),
                controller: _weightController,
                keyboardType: TextInputType.number, //숫자만 입력
                validator: (value) {
                  if(value!.trim().isEmpty){
                    return '몸무게를 입력하세요';
                  }
                },
              ),
              Container(
                margin: EdgeInsets.only(top:16.0),
                child: ElevatedButton(
                  child: Text('결과확인'),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => BmiResult(double.parse(_heightController.text.trim()),
                        double.parse(_weightController.text.trim())),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class BmiResult extends StatelessWidget {

  final double height;
  final double weight;
  const BmiResult(this.height, this.weight, {super.key}); // 키랑 몸무게 받아야지

  @override
  Widget build(BuildContext context) {

    final bmi = weight /((height/100) * (height / 100));
    print(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text('비만도 계산기'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_calcBmi(bmi),  // 추후 변경
            style: TextStyle(fontSize : 36.0),
            ),
            SizedBox(
              height: 16.0,
            ),
            _bulidIcon(bmi),
          ],
        ),
      ),
    );
  }
  
  String _calcBmi(double bmi){
    var result = '저체중';
    if(bmi >= 35 ){
      result = '고도비만';
    }else if(bmi >= 30){
      result = '2단계 비만';
    }else if(bmi >= 25){
      result = '1단계 비만';
    }else if(bmi >= 23){
      result = '과체중';
    }else if(bmi >= 18.5){
      result = '정상';
    }
    return result;
  }

  Widget _bulidIcon(double bmi){
    if(bmi >=23){
      return Icon(
        Icons.sentiment_very_dissatisfied,
        color: Colors.red,
        size: 100,
      );
    }else if(bmi >= 18.5){
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green,
        size: 100,
      );
    }else{
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.orange,
        size: 100,
      );
    }
  }

}
