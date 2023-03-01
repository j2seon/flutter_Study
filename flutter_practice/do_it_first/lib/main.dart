import 'package:do_it_first/screen/tab_bar/firstpage.dart';
import 'package:do_it_first/screen/tab_bar/secondpage.dart';
import 'package:do_it_first/screen/widget_example.dart';
import 'package:flutter/material.dart';
import 'package:do_it_first/model/AnimalItem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String _title = 'Widget Example';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TabBarPage(),
    );
  }
}

class TabBarPage extends StatefulWidget {
  const TabBarPage({Key? key}) : super(key: key);

  @override
  State<TabBarPage> createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    animalList.add(Animal(animalName: "벌", kind: "곤충",
        imagePath: "assets/images/bee.png"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류",
        imagePath: "assets/images/cat.png"));
    animalList.add(Animal(animalName: "젖소", kind: "포유류",
        imagePath: "assets/images/cow.png"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류",
        imagePath: "assets/images/dog.png"));
    animalList.add(Animal(animalName: "여우", kind: "포유류",
        imagePath: "assets/images/fox.png"));
    animalList.add(Animal(animalName: "원숭이", kind: "영장류",
        imagePath: "assets/images/monkey.png"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류",
        imagePath: "assets/images/pig.png"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류",
        imagePath: "assets/images/wolf.png"));
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBar'),
        centerTitle: true,
      ),
      body: TabBarView(
        children: [
          FirstApp(list: animalList),
          SecondApp(list: animalList),
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(
        tabs: [
          Tab(
            icon: Icon(
              Icons.looks_one,
              color: Colors.blue,
            ),
          ),
          Tab(
            icon: Icon(
              Icons.looks_two,
              color: Colors.blue,
            ),
          ),
        ],
        controller: controller,
      ),
    );
  }
}
