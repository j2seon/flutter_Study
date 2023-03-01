import 'dart:io';

void main(){
  showData();
}

void showData() async{
  startTask();
  String account = await accessData();
  fetchData(account);
}

void startTask(){
  String info1='요청수행 시작';
  print(info1);
}

Future<String> accessData() async{

  String account='' ;

  Duration time = Duration(seconds: 3);
  if(time.inSeconds > 2){
    // sleep(time);
    await Future.delayed(time, () {
      account = '8500';
      print(account);
    });
  }else{
    String account = '데이터를 가져왔습니다.';
    print(account);
  }
  return account;
}

void fetchData (String account){
  String info3='잔액은 $account입니다.';
  print(info3);
}