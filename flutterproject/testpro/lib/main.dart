import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hero',
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
        title: const Text('hero'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => HeroDetailPage(),
            ),
            );
          },
          child: Hero(
            tag: 'image',
            child: Image.asset('image/img1.jpg',
              width: 100,
              height: 100,
            ),
          ),
        ),
      ),
    );
  }
}
class HeroDetailPage extends StatelessWidget {
  const HeroDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Detail'),
      ),
      body: Hero(
        tag: 'image',
        child: Image.asset('image/img1.jpg'),
      ),
    );
  }
}

