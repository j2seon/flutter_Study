import 'package:drift/drift.dart';


class Schedules extends Table{
  //함수가 리턴됨. 그래서 모양이 ()();

  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();

  //내용
  TextColumn get content => text()();

  //일정 날짜
  DateTimeColumn get date => dateTime()();

  //시작시간
  IntColumn get startTime => integer()();

  //끝시간
  IntColumn get endTime => integer()();

  //Category Color table ID
  IntColumn get colorId => integer()();

  //생성날짜
  //항상  DateTime.now()가 와야한다.clientDefault를 쓰면 디폴트 값을 정할 수 있다.
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();
}