import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? timer;
  PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        int currentPage = controller.page!.toInt();
        int nextPage = currentPage + 1;

        if (nextPage > 4) {
          nextPage = 0;
        }
        controller.animateToPage(
            nextPage,
            duration: Duration(milliseconds: 400),
            curve: Curves.linear);
      },
    );
  }

  @override
  void dispose() {
    if (timer != null) {
      timer!.cancel();
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //앱과관련 없는 상태바를 변경할 수 있다.
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [1, 2, 3, 4, 5]
            .map(
              (e) => Image.asset('asset/img/image_$e.jpeg', fit: BoxFit.cover),
            )
            .toList(),
      ),
    );
  }
}
