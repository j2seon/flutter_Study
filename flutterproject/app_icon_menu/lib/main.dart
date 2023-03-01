import 'dart:ui';

import 'package:flutter/material.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appbar',
      theme: ThemeData(
        primarySwatch: Colors.red
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
        title: Text('Appbar icon menu'),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[ //한개이상의 뭔가가 온다.
          IconButton(  // 메뉴버튼생성
            icon: Icon(Icons.shopping_cart),
            onPressed: () {// onPressed:(){} 반환값이 없는 함수가 온다.
              print('shopping cart is clicked');
            },
          ),
          IconButton(  // 메뉴버튼생성
            icon: Icon(Icons.search),
            onPressed: () {// onPressed:(){} 반환값이 없는 함수가 온다.
              print('search is clicked');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/img1.png'),
                backgroundColor: Colors.white,
              ),
              otherAccountsPictures: <Widget>[ //다른 계정위젯
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/img2.png'),
                ),
              ],
              accountName: Text('진선'),
              accountEmail: Text('aaa@aaa.com'),
              onDetailsPressed: () { //함수구현
                print('클릭');
              },
              decoration: BoxDecoration(
                  color: Colors.red[400],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  )
              ),
            ),
            ListTile(
              leading: Icon(Icons.home,
                  color: Colors.grey[800],
              ),
              title: Text('home'),
              onTap: () {
                print('home');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.settings,
                color: Colors.grey[800],
              ),
              title: Text('Setting'),
              onTap: () {
                print('settings');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.question_answer,
                color: Colors.grey[800],
              ),
              title: Text('Q&A'),
              onTap: () {
                print('Q&A');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
