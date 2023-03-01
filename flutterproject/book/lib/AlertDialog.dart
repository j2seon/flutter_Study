import 'package:flutter/material.dart';

void main() =>runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'text',
      home: HeroPage(),
    );
  }
}


class HeroPage extends StatelessWidget {
  const HeroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text('Dialog'),
    ),
    body: Center(
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HeroDetailPage()),
          );
        },
        child: Hero(
            tag: 'image',
            child: Image.asset('image/img1.png',
            width: 100,
            height: 100,),
        ),
      ),
    )
    );
  }
}

class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: Hero(
        tag: 'image', 
        child: Image.asset('image/img1.png'),
      ),
    );
  }
}


class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                print('GestureDetector');
              },
              child: Text('클릭'),
            ),
            InkWell(
              onTap: (){
                print('InkWell');
              },
              child: Text('클릭'),
            ),
          ],
        ),
      ),
    );
  }
}
