import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../const/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool isTime; //시간관련일 때만 숫자 키보드를 보이기위한 구분 변수
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
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      //onChanged를 통해 텍스트 필드의 값을 받을 수 있다.(변화할때마다)
      //Form을 사용해야한다. 그럼 TextField가 아니라 TextFormField를 사용
      // onChanged: (String? value) {
      //   print(value);
      // },
      //null이 return 되면 에러가 없다.
      //에러가 있으면 에러를 String 값으로 리턴해준다.
      validator: (String? val){
        if(val == null || val.isEmpty){
          return '값을 입력해주세요!';
        }
        if(isTime){
          //isTime일 때 숫자만 받을 수 있도록 inputFormatters에서 작성함!!!
          //즉 String으로 들어오지만 int로 바꿀수있다는것
          int time = int.parse(val);

          if(time < 0){
            //시간이 0이면 안되니까
            return '0이상의 숫자를 입력해주세요';
          }

          if(time>24){
            //시간이 25면 안되니까
            return '24이하의 숫자를 입력해주세요';
          }
        }else{
          if(val.length > 500){
            //내용
            return '500자 이하만 입력 가능합니다.';
          }
        }

        return null;
      },
      //검증에 다 성공하고 어떤 함수를 실행할건지!
      //TextFormField 상위의 Form에서 save함수를 실행시에 불려진다!
      onSaved: onSaved,
      cursorColor: Colors.grey,
      maxLength: 500, //이렇게 적어도 500이하만 입력가능하도록 조치된다.
      maxLines: isTime ? 1 : null,
      // null을 할 경우 줄바꿈이 되어서 내려감!!!!
      expands: !isTime, // 세로로 확장시킴
      keyboardType: isTime ? TextInputType.number : TextInputType.multiline,
      inputFormatters: isTime
          ? [
              // 숫자외에 다른 게 들어오는걸 막기위해서!
              FilteringTextInputFormatter.digitsOnly,
            ]
          : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true, //색을 넣기위함
        fillColor: Colors.grey[300],
      ),
    );
  }
}
