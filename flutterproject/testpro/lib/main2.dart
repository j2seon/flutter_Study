import 'package:flutter/material.dart';
import 'dart:math';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hero',
      home: Animated(),
    );
  }
}

class Animated extends StatefulWidget {
  const Animated({Key? key}) : super(key: key);

  @override
  State<Animated> createState() => _AnimatedState();
}

class _AnimatedState extends State<Animated> {
  var _size = 100.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('animated'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            final random = Random();
            setState(() {
              _size = random.nextInt(200).toDouble() + 100;
              // _size= 200;
    });
          },
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            width: _size,
            height: _size,
            child: Image.asset('image/img1.jpg'),
            curve: Curves.easeOutQuint,
          ),
        ),
      ),
    );
  }
}
