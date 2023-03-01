import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'path1',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: MyPage(),
    );
  }
}


class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('patch1snackbar'),
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('snackbar'),
              duration: Duration(seconds: 5),
              action: SnackBarAction(
                label: 'cancle',
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (_) => Third(),
                  ));
                },
              ),
            ));
        },
        child: Icon(Icons.thumb_up),
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text('Go to Second'),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (_)=> Second(),
          ));
        },
      ),
    );
  }
}

class Second extends StatelessWidget {
  const Second({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('seconde'),
      ),
      body: Center(
        child: Text('second'),
      ),
    );
  }
}

class Third extends StatelessWidget {
  const Third ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Third'),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('좋아요를 취소하겠습니까?',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blue
                  ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('좋아요가 취소되었습니다',),
                            duration: Duration(seconds: 3),
                          ));
                      },
                      child: Text('취소하기'))
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}

