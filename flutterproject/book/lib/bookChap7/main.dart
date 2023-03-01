import 'package:book/AlertDialog.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  runApp(MyApp());
}

final dummyItems = [
  'https://cdn.pixabay.com/photo/2013/11/01/11/13/dolphin-203875_960_720.jpg',
  'https://cdn.pixabay.com/photo/2018/08/14/13/23/ocean-3605547_960_720.jpg',
  'https://cdn.pixabay.com/photo/2016/10/18/21/22/beach-1751455_960_720.jpg',
];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  var _index = 0;

  var _pages = [
    Page1(),
    Page2(),
    Page3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          '복잡',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: '홈',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: '이용서비스',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: '내정보',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildTop(),
        _buildMiddle(),
        _buildBottom(),
      ]
    );
  }
}

  Widget _buildTop(){
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  print('클릭');
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40.0,
                    ),
                    Text("택시"),
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  print('클릭');
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40.0,
                    ),
                    Text("택시"),
                  ],
                ),
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40.0,
                  ),
                  Text("택시"),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40.0,
                  ),
                  Text("택시"),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40.0,
                  ),
                  Text("택시"),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40.0,
                  ),
                  Text("택시"),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.local_taxi,
                    size: 40.0,
                  ),
                  Text("택시"),
                ],
              ),
              Opacity(
                opacity: 0.0,
                child: Column(
                  children: [
                    Icon(
                      Icons.local_taxi,
                      size: 40.0,
                    ),
                    Text("택시"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildMiddle(){
  return CarouselSlider(
    options: CarouselOptions(height: 150.0, autoPlay: true), //  자동 슬라이드
    items: dummyItems.map((url) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              ),
          );
        },
      );
    }).toList(),
  );
}

Widget _buildBottom(){
  final items = List.generate(10, (index) {
    return ListTile(
      leading: Icon(Icons.notifications_none),
      title: Text('[공지]이벤트입니다.'),
    );
  });
  return ListView(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    children: items,
  );

}


class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '홈페이지',
        style: TextStyle(
          fontSize: 40.0,
        ),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '홈페이지',
        style: TextStyle(
          fontSize: 40.0,
        ),
      ),
    );
  }
}
