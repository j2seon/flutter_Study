import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart/';

void main() => runApp(const MyApp());



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'snackbar2',
      theme: ThemeData(
        primarySwatch: Colors.red,
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
         title: Text('snackbar2'),
         centerTitle: true,
       ),
       body: MySnackBar(),
     );
   }
 }

 class MySnackBar extends StatelessWidget {
   const MySnackBar({Key? key}) : super(key: key);

   @override
   Widget build(BuildContext context) {
     return Center(
       child: ElevatedButton(
         child: Text('show me'),
         onPressed: (){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
               content: Text('hello',
               textAlign: TextAlign.center,
                 style: TextStyle(
                   color: Colors.white,
                 ),
               ),
             backgroundColor: Colors.teal,
             duration: Duration(milliseconds: 1000),
           ),
           );
         },
       ),

     );
   }
 }
