import 'package:calenduler/database/drift_database.dart';
import 'package:calenduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
//앱이 실행되면서 intl 패키지를 초기화하겠음! >> main을 async로 만들어줘야한다.

const DEFUALT_COLORS = [
  //빨강
  'F44336',
  'FF9800',
  'FFEB3B',
  'FCAF50',
  '2196F3',
  '3F51B5',
  '9C27B0',
];

void main() async {
  //runapp을 실행하게되면   WidgetsFlutterBinding.ensureInitialized(); 가 자동실행된다.
  //지금은 runapp 실행전에 initializeDateFormatting룰 실행시켜야되기 때문에 !!!<<준비되었는지 확인
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting(); // intl패키지에있는 모든 언어를 사용가능하게 만든다.

  final database = LocalDatabase();
  //중복체크
  final colors = await database.getCategoryColors();

  GetIt.I.registerSingleton<LocalDatabase>(database);

  if (colors.isEmpty) {
    for (String hexCode in DEFUALT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
          // id: Value(1), 실수로 컬러테이블에 auto 안넣어줫음.....다음에 넣어서하자
        ),
      );
    }
  }
  print(await database.getCategoryColors());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: Home_screen(),
    );
  }
}
