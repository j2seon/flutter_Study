import 'package:calenduler/component/text_field.dart';
import 'package:calenduler/const/color.dart';
import 'package:calenduler/database/drift_database.dart';
import 'package:calenduler/model/category_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({Key? key}) : super(key: key);

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey(); // 컨트롤러처럼 작용한다.

  int? startTime;
  int? endTime;
  String? content;
  int? select

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height / 2 + bottomInset,
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomInset),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
              child: Form(
                //form 안에있는 필드들을 컨트롤 해주는 역할 (컨트롤러)
                key: formKey,
                autovalidateMode: AutovalidateMode.always, //라이브로 validate를 한다.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //상위의 값들에 form을 주면 한번에 관리할수있다.
                    _Time(
                      onStartSaved: (String? val) {
                        startTime = int.parse(val!);
                      },
                      onEndSaved: (String? val) {
                        endTime = int.parse(val!);
                      },
                    ),
                    SizedBox(height: 16.0),
                    _Content(
                      onSaved: (String? val) {
                        content = val;
                      },
                    ),
                    SizedBox(height: 16.0),
                    FutureBuilder<List<CategoryColor>>(
                        future: GetIt.I<LocalDatabase>().getCategoryColors(),
                        builder: (context, snapshot) {
                          print(snapshot.data);
                          return _ColorPicker(
                            colors: snapshot.hasData
                                ? snapshot.data!
                                : [],
                          );
                        }),
                    SizedBox(height: 8.0),
                    _SaveButton(onPressed: onSavePressed),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSavePressed() {
    //formKey는 생성을 했는데 Form 위젯과 결합을 안했을때
    if (formKey.currentState == null) {
      return;
    }
    if (formKey.currentState!.validate()) {
      print('에러없음');
      formKey.currentState!.save();
      print('---------------');
      print('startTime : $startTime');
      print('endTime : $endTime');
    } else {
      print('에러');
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

class _ColorPicker extends StatelessWidget {
  final List<CategoryColor> colors;

  const _ColorPicker({required this.colors, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: colors.map((e) => renderColor(e)).toList(),
    );
  }

  Widget renderColor(CategoryColor color) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(int.parse('FF${color.hexCode}', radix: 16),
        ),
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: PRIMARY_COLOR,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
