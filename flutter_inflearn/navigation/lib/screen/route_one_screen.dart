import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int? number;

  const RouteOneScreen({this.number, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'Route One',
      children: [
        Text(
          'arguments: ${number.toString()}',
          textAlign: TextAlign.center,
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.of(context).maybePop(444); //그냥 pop이랑 기능은 같음!
          },
          child: Text('maybePop')
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(456);
          },
          child: Text('Pop'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RouteTwoScreen(),
                settings: RouteSettings( //페이지에 값을 전달할 수 있는 방법 2번째
                  arguments: 789,
                ),
              ),
            );
          },
          child: Text('GO TO Route Two push'),
        ),
      ],
    );
  }
}
