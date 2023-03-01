import 'dart:async';

import 'package:english_words/english_words.dart';
class Bloc{
  Set<WordPair> saved = Set();
  final _savedController = StreamController<Set<WordPair>>.broadcast(); //컨트롤러생성

  get savedStream { //스트림을 생성
    return _savedController.stream;
  }
  
  addToOrRemoveFromSavedList(WordPair item){
    if(saved.contains(item)){
      saved.remove(item);
    }else{
      saved.add(item);
    }
    _savedController.sink.add(saved); //변경된 데이터를 보내줄때
  }
  
  dispost(){ // 나중에 없애줘야함!!! 
    _savedController.close();
  }
}

var bloc = Bloc();