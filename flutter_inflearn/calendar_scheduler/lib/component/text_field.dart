import 'package:calendar_scheduler/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  //시간필드와 문자필드 구분을 위해서 변수선언 true면 시간
  final bool isTime;
  final FormFieldSetter<String> onSaved;

  const CustomTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: PRIMARY_COLOR,
            fontWeight: FontWeight.w600,
          ),
        ),
       if(isTime) renderTextField(),
        if(!isTime) Expanded(child: renderTextField()),
      ],
    );
  }
  Widget renderTextField(){
    return TextFormField(
      onSaved: onSaved,
      //Form을 이용하면 따로관리할 필요없이 동시에 값을 관리해준다 >> TextFormField를 사용하고 상위에 Form을 감싸줘야함.
      //onchange를 통해서 변화하는 값들을 확인할 수 있었지만 TextFormField에서 validator로 체크가능하다
      //null이면 에러가 없는거고 있으면 String 값으로 에러를 반환한다.
      validator: (String? val){
        if(val == null || val.isEmpty){
          return '값을 입력해주세요';
        }

        if(isTime){
          //시간값이 들어오고 변환해줘야한다.
          int time = int.parse(val);

          if(time < 0){
            return '0 이상의 숫자를 입력해주세요';
          }

          if(time > 24){
            return '24 이하의 숫자를 입력해주세요';
          }
        }else{
          if(val.length>500){
            return '500자 이하를 입력해주세요';
          }
        }
        return null;
      },
      maxLength: 500, // 이렇게도 글자수를 제한할 수 있음.
      expands: !isTime, // 텍스트필드 길이를 늘리기위해서 설정!!!
      maxLines: isTime? 1 : null, // 최대 줄의 갯수 null을 넣으면 무한
      keyboardType: isTime ? TextInputType.number : TextInputType.text,
      inputFormatters: isTime ? [
        FilteringTextInputFormatter.digitsOnly, //숫자만쓸수있게 지정
      ] : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey[300],
        suffixText: isTime ? '시' : null, //접미사!
      ),
      cursorColor: Colors.grey,
    );
  }
}
