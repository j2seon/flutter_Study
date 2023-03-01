//private 값들을 불러올수 없음.
import 'dart:io';

import 'package:calenduler/model/category_color.dart';
import 'package:calenduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// private 값까지 불러올수있다.
part 'drift_database.g.dart'; //생성이되도록 할것임!

@DriftDatabase(
  tables: [
    //테이블로 만들 모델을 가져온다.
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  @override
  int get schemaVersion => 1;
}

//실제 데이터베이스파일을 어떤 위치에 생성할 것인지를 적는곳!
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFoler = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFoler.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

//flutter pub run build_runner build
