import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_quiz.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //퀴즈 더미데이터 -> start버튼을 눌렀을 때 불러올수있게 추후 api로 변경
  List<Quiz> quizes = [
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0,
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0,
    }),
    Quiz.fromMap({
      'title': 'test',
      'candidates': ['a', 'b', 'c', 'd'],
      'answer': 0,
    }),
  ];


  @override
  Widget build(BuildContext context) {
    //반응형을 위해서 스크린의 사이즈를 알아냄
    Size screenSize = MediaQuery
        .of(context)
        .size;
    double width = screenSize.width;
    double height = screenSize.height;

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz App'),
            backgroundColor: Colors.deepPurple,
            elevation: 0.0,
            centerTitle: true,
            leading: Container(),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'images/quiz.png',
                  width: width * 0.8,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.024),
              ),
              Text(
                'Quiz App',
                style: TextStyle(
                    fontSize: width * 0.065, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '퀴즈를 풀기 전 안내사항입니다.\n 꼼꼼히 읽고 퀴즈 풀기를 눌러주세요',
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(0.048),
              ),
              _bulidStep(width, '1. 랜덤으로나오는 퀴즈 3개를 풀어보세요'),
              _bulidStep(width, '2. 문제를 잘 읽고 정답을 고른 뒤 버튼을 눌러주세요'),
              _bulidStep(width, '3. 만점을 향해 도전해보세요!'),
              Padding(
                padding: EdgeInsets.all(0.5),
              ),
              Container(
                padding: EdgeInsets.only(bottom: width * 0.039),
                child: Center(
                  child: ButtonTheme(
                    minWidth: width * 0.8,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((
                            context) => QuizScreen(quizes))));
                      },
                      child: Text(
                        'start!!',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bulidStep(double width, String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        width * 0.048,
        width * 0.024,
        width * 0.024,
        width * 0.024,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check_box,
            size: width * 0.04,
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.024),
          ),
          Text(title),
        ],
      ),
    );
  }
}
