import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:quiz_app_test/screen/screen_home.dart';

class ResultScreen extends StatelessWidget {
  List<int> answer;
  List<Quiz> quizs;

  ResultScreen({required this.answer, required this.quizs});

  @override
  Widget build(BuildContext context) {
    //반응형을 위해서 스크린의 사이즈를 알아냄
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    int score = 0;
    for (int i = 0; i < quizs.length; i++) {
      if (quizs[i].answer == answer[i]) {
        score += 1;
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Quiz APP'),
            backgroundColor: Colors.deepPurple,
            leading: Container(),
          ),
          body: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.deepPurple),
                color: Colors.deepPurple,
              ),
              width: width * 0.85,
              height: height * 0.5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.white,
                    ),
                    width: width * 0.73,
                    height: height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              0, width * 0.01, 0, width * 0.02),
                          child: Text(
                            '수고하셨습니다.',
                            style: TextStyle(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '당신의 점수는 ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.048),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        Text(
                          score.toString() + '/' + quizs.length.toString(),
                          style: TextStyle(
                              fontSize: width * 0.20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Padding(padding: EdgeInsets.all(width * 0.012))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                    child: ButtonTheme(
                      minWidth: width * 0.73,
                      height: height * 0.05,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        child: Text('홈으로 돌아가기',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
