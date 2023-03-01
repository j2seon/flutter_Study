import 'package:flutter/material.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quize',
      home: MyButton(),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('button'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                // onPressed: (){
                //   print('test');
                // },
                onLongPress: (){
                  print('txt');
                },
                onPressed: (){},
                child: Text('text',
                style: TextStyle(
                  fontSize: 20.0,
                  ),
                ),
                style: TextButton.styleFrom(
                  primary: Colors.redAccent,
                  // backgroundColor: Colors.white
                ),
              ),
              ElevatedButton(
                  onPressed: null,
                  child: Text('ElevatedButton'),
                    style: ElevatedButton.styleFrom(
                    onSurface: Colors.purpleAccent,
                    primary: Colors.orangeAccent,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0.0,
                ),
              ),
              OutlinedButton(
                  onPressed: (){
                    print('OutlinedButton');
                  },
                  child: Text('OutlinedButton'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.greenAccent,
                    side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                    )
                  ),
              ),
              TextButton.icon(
                  onPressed: (){
                    print('TextButton.icon');
                  },
                    icon: Icon(Icons.home,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  label: Text('go to home'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.deepOrangeAccent,
                  ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonPadding: EdgeInsets.all(20.0),
                children: [
                  TextButton(
                      onPressed:(){},
                      child: Text('txt'),
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('elev'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
}

