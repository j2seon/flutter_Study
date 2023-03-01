import 'package:flutter/material.dart';

// void main()=> runApp(const MyApp());
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Apps',
//       theme: ThemeData(
//         primarySwatch: Colors.amber,
//       ),
//       home: MyPage(),
//     );
//   }
// }


class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('JJS\'s  App',
          style:TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed:(){
              print('click shopping');
            },
            icon: Icon(Icons.shopping_bag),
            color: Colors.white,
          ),
          IconButton(
            onPressed:(){
              print('click search');
            },
            icon: Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/img1.png'),
                backgroundColor: Colors.white,
              ),
              accountName: Text('Ju Jin Seon'),
              accountEmail: Text('JJS@aaa.com'),
              onDetailsPressed: () {
                print('click userDetail');
              },
              decoration: BoxDecoration(
                color: Colors.amber[600],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('HOME'),
              onTap: () {
                print('click home');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('settings'),
              onTap: () {
                print('click settings');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.wallet_giftcard),
              title: Text('Gift Card'),
              onTap: () {
                print('click GiftCard');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('Q & A'),
              onTap: () {
                print('question_answer');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.deepOrangeAccent,
      ),
    );
  }
}




class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 0.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/img2.png'),
                radius: 80.0,
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.9,
              height: 70.0,
            ),
            Center(
              child:IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Welcome! ',
                      style: TextStyle(
                        letterSpacing: 3.0,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/shopping');
                      },
                      child: Text('Go To Shopping',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.amber[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/mypage');
                      },
                      child: Text('Go To My Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.amber[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/community');
                      },
                      child: Text('Go To Community',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Colors.amber[500],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
