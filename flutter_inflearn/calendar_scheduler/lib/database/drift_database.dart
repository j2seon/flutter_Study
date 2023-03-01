//private변수는 가져올 수 없음
import 'dart:io';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//import랑 비슷한데 private 변수를 가져올수 있다.
part 'drift_database.g.dart'; //자동으로 생성이 될 예정이다.

//1. part로 선언하기
//2. @DriftDatabase에 테이블 작성
//3. LocalDatabase를 본따서 _$붙여서 _$LocalDatabase를 상속받기 << 나중에 drift가 생성해주는 값을 받는거라고생각
//4. 상속받을거니까 연결을 위한 super(_openConnection())
@DriftDatabase(
  tables: [
    //타입선언하듯이 선언한다.
    Schedules,
    CategoryColors,
  ],
)
//_$LocalDatabase은 drift가 생성해준다.
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  //자동으로 primarykey값을 리턴받음.
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  //삭제쿼리 >> 삭제한 스케쥴의 id를 리턴한다.
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();


  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    final query = select(schedules).join([
      innerJoin(categoryColors, categoryColors.id.equalsExp(schedules.colorId)),
    ]);

    query.where(schedules.date.equals(date));
    query.orderBy([
      OrderingTerm.asc(schedules.startTime),
    ]);

    return query.watch().map(
          (rows) => rows.map(
            (row) => ScheduleWithColor(
              schedule: row.readTable(schedules),
              categoryColor: row.readTable(categoryColors),
            ),
          ).toList(),
        );

    //위의 코드와 같은 코드이다. ..을 붙이면 앞의 대상이 리턴된다.
    // return (select(schedules)..where((tbl) => tbl.date.equals(date))).watch(); // watch를 사용하면 stream으로 받을 수 있다.
  }

  @override
  int get schemaVersion => 1; //앱의 버전

}

LazyDatabase _openConnection() {
  //

  return LazyDatabase(() async {
    //저장할 폴더를 지정한다.
    final dbFolder = await getApplicationDocumentsDirectory();
    //저장할 파일 생성
    final file = File(p.join(dbFolder.path, 'db.sqllite'));
    return NativeDatabase(file); // 데이터베이스 생성해서 리턴
  });
}

//데이터베이스 생성을 위해서 터미널에 실행해야되는 명령어
// flutter pub run build_runner build
