import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Future',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String res ='no data found';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Future Test',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  futureTest();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Future test',
                    style: TextStyle(
                        fontSize: 20.0
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                res,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.redAccent,
                ),
              ),
              const Divider(
                height: 20.0,
                thickness: 2.0,
              ),
              FutureBuilder(
                future: myFuture(),
                builder: (context, snapshot) { //snapshot특정시점에 데이터를 복사해서 보관하는곳
                  if(snapshot.connectionState == ConnectionState.done){
                    return Text(snapshot.data.toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue,
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                } ,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> futureTest() async {
    await Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        res = 'The data is fetched';
        print(res);
        print('Here comes third');
      });
    });
    print('Here comes first');
    print('Here is the last one');
  }

  Future<String> myFuture() async {
    await Future.delayed(Duration(seconds: 3));
    return 'another Future completed';
  }
}


