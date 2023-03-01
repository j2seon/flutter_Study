import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schdule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import '../component/schedule_card.dart';
import '../const/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: OnDayselected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,
            ),
            SizedBox(
              height: 8.0,
            ),
            TodayBanner(
              selectedDay: selectedDay,
            ),
            SizedBox(
              height: 8.0,
            ),
            _ScheduleList(selectedDate: selectedDay),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: PRIMARY_COLOR,
      onPressed: () {
        //showModalBottomSheet는 최대값의 기본이 화면의 반이다. >> 전체로 늘려야한다.
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return ScheduleBottomSheet(
              selectedData: selectedDay,
            );
          },
        );
      },
    );
  }

  OnDayselected(selectedDay, focusedDay) {
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;

  const _ScheduleList({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('스테줄이 없습니다.'),
                );
              }

              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 8.0,
                  );
                },
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {

                  final scheduleWithColor = snapshot.data![index];

                  return Dismissible(
                    // key가 필수적이고 여기에 유니크한 값이 들어가야한다.
                    key: ObjectKey(scheduleWithColor.schedule.id),
                    //스와이프할 방향정해주기 >> 화면에서는 삭제되지만 db에 삭제안됌
                    direction: DismissDirection.endToStart,
                    //그래서 onDismissed함수를 실행해야된다.
                    onDismissed: (direction) {
                      GetIt.I<LocalDatabase>().removeSchedule(scheduleWithColor.schedule.id);
                    },
                    child: ScheduleCard(
                      startTime: scheduleWithColor.schedule.startTime,
                      content: scheduleWithColor.schedule.content,
                      endTime: scheduleWithColor.schedule.endTime,
                      color: Color(
                        int.parse(
                          'FF${scheduleWithColor.categoryColor.hexCode}',
                          radix: 16,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
