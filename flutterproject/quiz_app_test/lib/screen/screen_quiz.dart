import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app_test/model/model_quiz.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:quiz_app_test/screen/screen_result.dart';
import 'package:quiz_app_test/widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  //start버튼을 클릭했을 때 quizScreen페이지로 데이터를 건네받을 변수필요
  List<Quiz> quizs = [];

  QuizScreen(this.quizs);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  //퀴즈별 사용자의 정답을 담을 리스트
  List<int> _answer = [-1, -1, -1];

  //보기 4개에 선택지가 선택되었는지 확인하는 리스트
  List<bool> _answerState = [false, false, false, false];

  //현재 어떤문제를 보고있는지에대한 인덱스
  int _currentIndex = 0;

  SwiperController _controller = SwiperController();

  @override
  Widget build(BuildContext context) {
    //반응형을 위해서 스크린의 사이즈를 알아냄
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Colors.deepPurple),
            ),
            width: width * 0.7,
            height: height * 0.6,
            child: Swiper(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (context, index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + '.',
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top: width * 0.012),
            child: AutoSizeText(
              quiz.title!,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                  fontSize: width * 0.048, fontWeight: FontWeight.bold),
            ),
          ),
          //아래에서 부터 배치되도록하는 효과
          Expanded(
            child: Container(),
          ),
          Column(
            children: _bulidCandidates(width, quiz),
          ),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  child: _currentIndex == widget.quizs.length - 1
                      ? Text('결과보기')
                      : Text('다음문제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  onPressed: _answer[_currentIndex] == -1
                      ? null
                      : () {
                          if (_currentIndex == widget.quizs.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                      answer: _answer, quizs: widget.quizs),
                                ));
                          } else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _bulidCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for (int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          text: quiz.candidates![i],
          index: i,
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for (int j = 0; j < 4; j++) {
                if (j == i) {
                  _answerState[j] = true;
                  _answer[_currentIndex] = j;
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.022),
        ),
      );
    }
    return _children;
  }
}
