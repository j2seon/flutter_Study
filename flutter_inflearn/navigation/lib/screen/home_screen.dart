import 'package:flutter/material.dart';
import 'package:navigation/layout/main_layout.dart';
import 'package:navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        // 기본적으로 안드로이드는 뒤로가기가 가능함. --> 이걸 막아야될때 WillPopScope를 사용할수있다.
        //true - pop 가능 
        //false - pop 불가능
        //작업실행
        final canPop =Navigator.of(context).canPop(); //만약에 canpop이 ture면 pop가능하다
        return canPop;
      },
      child: MainLayout(
        title: 'HomeScreen',
        children: [
          //실수로 pop하다가 뒤에 페이지값이 없어서 검은화면이 나올때!
          //maybePop()을 사용하면 pop이 실행되지 않게함!!
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).maybePop();
            },
            child: Text('maybePop'),
          ),
          //canPop은 pop을 할 수 있는 상태인지 아닌지를 알수있음!!
          ElevatedButton(
            onPressed: (){
              print(Navigator.of(context).canPop());
            },
            child: Text('Can Pop'),
          ),


          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return RouteOneScreen(
                      number: 123,
                    );
                  },
                ),
              );
              print(result);
            },
            child: Text('push'),
          ),
        ],
      ),
    );
  }
}
