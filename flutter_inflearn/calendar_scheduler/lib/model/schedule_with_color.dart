import 'package:calendar_scheduler/database/drift_database.dart';

//조인한 값을 넣기위한 모델
class ScheduleWithColor {
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.schedule,
    required this.categoryColor,
  });
}
