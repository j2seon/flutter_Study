import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
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

  //GetIt을 이용하면 따로 파라미터를 이용하지 않아도 어디에서든지 database를 사용할수있게된다.
  GetIt.I.registerSingleton<LocalDatabase>(database);

  final colors = await database.getCategoryColors();

  if(colors.isEmpty){
    for(String hexCode in DEFAULT_COLORS){
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  }


  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: HomeScreen(),
    ),
  );
}

