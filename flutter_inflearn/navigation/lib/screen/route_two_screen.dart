import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({Key? key}) : super(key: key);

  //ModalRoute은 전체스크린의 위젯을 의미 > 여기선 RouteTwoScreen 이겠지!
  // => RouteTwoScreen의 값을 가져오겠다는 의미
  // . 을 찍어서 보면 settings.arguments가 있다! < 페이지 넘길때 해당 값으로 넘겼잖아!

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments;

    return MainLayout(
      title: 'Route Two',
      children: [
        Text(
          'arguments : $arguments',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('pop'),
        ),
        //two에서 three로 이동 pushNamed를 이용
        // pushNamed는 바로 argument를 사용할 수 있다.
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/three', arguments: 999);
          },
          child: Text('Push Named'),
        ),
        //push 다른방법 1. pushReplacement
        //pushReplacement: push랑 같은 방식! but 전에 있던 페이지를 대체하는형식
        //[HomeScreen(), RouteOne(), RouteTwo(), RouteThree()] 순서로 넘어왓지만 pushReplacement
        //[HomeScreen(), RouteOne(),RouteThree()] RouteTwo()삭제됨 < 즉 바로 전페이지 삭제하고 대체

        // pushReplacementNamed(push) pushNamed와 같은 방식 +pushReplacement처럼 페이지 대체함.

        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => RouteThreeScreen(),
              ),
            );
          },
          child: Text('Push Replacement '),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => RouteThreeScreen()),
              // (route) => false를 하게되면 뒤에 있던 페이지들 전부삭제된다. true 하면 그대로있음.
              //named로 지정해준 값이랑 같으면 true로하면 해당 페이지만 true

              //pushNamedAndRemoveUntil 하면 이름지정해주는것!

              (route) => route.settings.name == '/',
            );
          },
          child: Text('pushAndRemoveUntil'),
        ),
      ],
    );
  }
}
