import 'package:calendar_scheduler/component/text_field.dart';
import 'package:calendar_scheduler/const/color.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:drift/drift.dart' show Value; //
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final DateTime selectedData;

  const ScheduleBottomSheet({
    required this.selectedData,
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  //값을 저장하기위해서 상위에서 상태관리
  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    //viewInsets은 가려진만큼의 사이즈를 가져올 수 있다.
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode()); //외우기
        },
        child: Container(
          // 화면의 반을 차지하게만들어주고 가려진 사이즈만 큼 올라오도록만들어준다.
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Form(
                //Form은 key로 값들을 컨트롤해준다.==> 저장버튼을 눌렀을때!
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                //라이브로 validate되는 것을 볼 수 있다.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Time(
                      onStartSaved: (String? val) {
                        startTime = int.parse(val!);
                      },
                      onEndSaved: (String? val) {
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    _Content(
                      onSaved: (String? val) {
                        content = val;
                      },
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData &&
                              selectedColorId == null &&
                              snapshot.data!.isNotEmpty) {
                            selectedColorId = snapshot.data![0].id;
                          }
                          return _ColorPicker(
                            colors: snapshot.hasData ? snapshot.data! : [],
                            selectedColorId: selectedColorId,
                            colorIdSetter: (id) {
                              setState(() {
                                selectedColorId = id;
                              });
                            },
                          );
                        }),
                    SizedBox(
                      height: 8.0,
                    ),
                    _SaveButton(
                      onPressed: onSavePressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() async {
    //저장버튼을 눌렀을때 검증조건을 넣을것임!
    if (formKey.currentState == null) {
      //formKey 생성은 했는데 Form 위젯과 결함을 안했을 때
      return;
    }
    //Formkey 안에있는 모든 textFormField의 validator가 실행된다.
    //String 값이 리턴되면 formKey.currentState!.validate()가 false가 된다.
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save(); // 저장버튼누르면! 저장되게함! << 하위의 save들을 실행시킨다.

      //데이터베이스에 넣어주기 >> future<int>로 리턴되기떄문에 await해주기
     final key = await GetIt.I<LocalDatabase>().createSchedule(
        SchedulesCompanion(
          // 저장할 값들을 적어주면된다. >> id랑 createAt은 디폴트 있어서 없어도됨
          date: Value(widget.selectedData),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          colorId: Value(selectedColorId!),
        ),
      );
      print('save 완료 $key');
      //저장하고 bottom시트를 닫을 것임!
      Navigator.of(context).pop();

    } else {
      print('에러있음');
    }
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;

  const _Time({required this.onStartSaved, required this.onEndSaved, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: '시작시간',
            isTime: true,
            onSaved: onStartSaved,
          ),
        ),
        SizedBox(width: 16.0),
        Expanded(
          child: CustomTextField(
            isTime: true,
            label: '마감시간',
            onSaved: onEndSaved,
          ),
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Content({required this.onSaved, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
      ),
    );
  }
}

typedef ColorIdSetter = void Function(int id);

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  const _ColorPicker({
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, //좌우
      runSpacing: 10.0, //위아래
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(e, selectedColorId == e.id),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      width: 32.0,
      height: 32.0,
      decoration: BoxDecoration(
        border: isSelected
            ? Border.all(
                color: Colors.black,
                width: 4.0,
              )
            : null,
        shape: BoxShape.circle,
        color: Color(
          int.parse(
            'FF${color.hexCode}',
            radix: 16, //16진수로 바꿔줌
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text('저장'),
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
