import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation{
  double? latitude2 ;
  double? longitude2 ;

  Future<void> getMyCurrentLocation() async{
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude2=position.latitude;
      longitude2=position.longitude;
    }catch(e){
      print('예외가 발생했습니다.');
    }
  }


}