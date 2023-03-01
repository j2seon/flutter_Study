import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:jsondata_practice/user.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appTitle = 'isolate Demo';

    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: appTitle,),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}







class JSONTest extends StatelessWidget {
  const JSONTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String json = '{"name": "John Smith","email": "john@example.com", "created_at" : 123123123, "address": {"street" : "victor street", "city" : "best city"}}';

    Map<String, dynamic> userMap = jsonDecode(json);

    var user = User.fromJson(userMap);
    var jsonData = user.toJson();

    String jsonEncoding = jsonEncode(jsonData);
    // print(jsonEncoding);
    // print(jsonData);


    return Scaffold(
      body: Center(
        child: Text(
           'name: ${user.name}\n email : ${user.email}\n created_at : ${user.createdTime} \n ToJson : ${jsonData}'
        ),
      ),
    );
  }
}


