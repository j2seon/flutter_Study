import 'package:flutter/material.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quize',
      initialRoute: '/',
      home: Builder(
        builder: (context) {
          return Center(
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => Two(),
                ));
              },
              child: Text('go to'),
            ),
          );
        }
      ),
    );
  }
}
//
// class One extends StatelessWidget {
//   const One({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElevatedButton(
//         child: Text('goto'),
//         onPressed: () => Navigator.push(context, MaterialPageRoute(
//             builder: (_) => Two(),
//         )),
//       ),
//     );
//   }
// }




class Two extends StatelessWidget {
  const Two({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('two'),
      ),
      body: Center(
        child: Text('hiiiiiii'),
      ),
    );
  }
}
