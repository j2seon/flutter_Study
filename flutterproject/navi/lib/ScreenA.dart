import 'package:flutter/material.dart';


class ScreenA extends StatelessWidget {
  const ScreenA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScreenA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/B');
                },
                child: Text('Go to Screen B'),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/C');
                },
                child: Text('Goto Screen C'),
            ),
          ],
        ),
      )
    );
  }
}

