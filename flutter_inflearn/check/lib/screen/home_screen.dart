import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  //위치
  static final LatLng companyLating = LatLng(37.5233273, 126.921252);

  //zoom가능설정 - CameraPositiond 위에서 볼때
  static final CameraPosition initialPosition = CameraPosition(
      //tartget에 위도경도를 넣으면된다.
      target: companyLating,
      zoom: 15 //zoom된 정도를 조절할 수 있다.
      );

  //위치확인하는 버튼 직접만들기 --> 이걸 구글 맵에 놔줘야한다.
  static final double okdistance = 100;
  static final Circle withinDistanceCircle = Circle(
    circleId: CircleId('withinDistanceCircle'),
    // 동그라미구분할수있는 기준!
    center: companyLating,
    //
    fillColor: Colors.blue.withOpacity(0.5),
    radius: okdistance,
    //반지름 설정
    strokeColor: Colors.blue,
    //원둘레의 색깔
    strokeWidth: 1, //원둘레 두께
  );
  static final Circle notwithinDistanceCircle = Circle(
    circleId: CircleId('notwithinDistanceCircle'),
    // 동그라미구분할수있는 기준!
    center: companyLating,
    //
    fillColor: Colors.red.withOpacity(0.5),
    radius: okdistance,
    //반지름 설정
    strokeColor: Colors.red,
    //원둘레의 색깔
    strokeWidth: 1, //원둘레 두께
  );

  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    // 동그라미구분할수있는 기준!
    center: companyLating,
    //
    fillColor: Colors.green.withOpacity(0.5),
    radius: okdistance,
    //반지름 설정
    strokeColor: Colors.green,
    //원둘레의 색깔
    strokeWidth: 1, //원둘레 두께
  );

  //내 위치 확인하는 마커찍기
  static final Marker marker = Marker(
    markerId: MarkerId('maker'), //여러개도 가능함. 대신이름으로 구분가능하게하기
    position: companyLating,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      //FutureBuilder는 builder: BuildContext context, AsyncSnapshot snapshot 두개를 받고
      //future 함수를 넣어줄수있다.
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // print(snapshot.connectionState); //waiting에서 done으로 바뀜(허용하면)
          // print(snapshot.data);
          //ConnectionState가 waiting이면 로딩중이라는 의미이다.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          //위치권한이 허가된경우에만 띄우자
          if (snapshot.data == '위치권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  // print(snapshot.data); //위도경도확인할수있음.
                  bool isWithinRange = false;

                  //거리구하기
                  if (snapshot.hasData) {
                    final start = snapshot.data!; //내위치
                    final end = companyLating; //회사위치

                    final distance = Geolocator.distanceBetween(
                      start.latitude,
                      start.longitude,
                      end.latitude,
                      end.longitude,
                    );
                    if (distance < okdistance) {
                      isWithinRange = true;
                    }
                  }

                  return Column(
                    children: [
                      _CustomGoogleMap(
                        initialPosition: initialPosition,
                        circle: choolCheckDone
                            ? checkDoneCircle
                            : isWithinRange
                                ? withinDistanceCircle
                                : notwithinDistanceCircle,
                        marker: marker,
                        onMapCreated: onMapCreated,
                      ),
                      _ChoolCheckButton(
                        isWithinRange: isWithinRange,
                        choolCheckDone: choolCheckDone,
                        onPressed: onChoolCheckPressed,
                      ),
                    ],
                  );
                });
          }

          //허가되지 않은경우
          return Center(
            child: Text(snapshot.data),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //
  onChoolCheckPressed() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('출근하기'),
          content: Text('출근을 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('출근하기'),
            ),
          ],
        );
      },
    );
    if (result) {
      setState(() {
        choolCheckDone = true;
      });
    }
  }

  //권한설정 - 권한관련된 설정은 ascyn이다 > why? 권한승인할건지 말껀지 기다려야하니까.
  Future<String> checkPermission() async {
    //위치권한 서비스가 활성화되어있는지 확인
    final isLocationEnable = await Geolocator.isLocationServiceEnabled();
    //위치권한서비스가 안켜져있는 경우 처리필요
    if (!isLocationEnable) {
      return '위치서비스를 활성화 해주세요';
    }
    //현재 앱이가지고있는 위치서비스의 권한을 가져옴
    //LocationPermission enum 값으로 되어있음!! 따라서 조건을 설정하자.
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    //denied라고 할 경우 요청을 다시 할수있음!
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      //근데 권한 안한다고 해서 또 denied상태면
      if (checkedPermission == LocationPermission.denied) {
        return '위치권한을 허가해주세요';
      }
    }
    //deniedForever상태면 직접 유저가 핸드폰설정을 변경해줘야함.
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치권한을 핸드폰 setting에서 허가해주세요';
    }
    //다통과하면 ~
    return '위치권한이 허가되었습니다.';
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        '오늘도 출근',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700,
        ),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          //눌렀을때 현재위치 받아와야 이동되니까
          onPressed: () async {
            if (mapController == null) {
              return;
            }
            final location = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  location.latitude,
                  location.longitude,
                ),
              ),
            );
          },
          icon: Icon(Icons.my_location),
          color: Colors.blue,
        ),
      ],
    );
  }
}

class _CustomGoogleMap extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const _CustomGoogleMap(
      {required this.initialPosition,
      required this.circle,
      required this.marker,
      required this.onMapCreated,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GoogleMap(
        //처음 위치 - 어디에 위치할건지
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        //hybrid-위성지도,
        myLocationEnabled: true,
        // 내위치
        myLocationButtonEnabled: false,
        //내위치를 나타내는 버튼(직접만들어보자!)<<여러게 넣고싶으면 넣을수있다
        circles: Set.from([circle]),
        //마커<<여러개 넣고싶으면 넣을수있다!
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
      flex: 2,
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool choolCheckDone;

  const _ChoolCheckButton(
      {required this.isWithinRange,
      required this.onPressed,
      required this.choolCheckDone,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.timelapse_outlined,
          size: 50.0,
          color: choolCheckDone
              ? Colors.green
              : isWithinRange
                  ? Colors.blue
                  : Colors.red,
        ),
        const SizedBox(
          height: 20.0,
        ),
        if (!choolCheckDone && isWithinRange) //이렇게 바로쓸수도있다.
          TextButton(
            //출근가능할때만 보이기
            onPressed: onPressed,
            child: Text(
              '출근하기',
            ),
          ),
      ],
    ));
  }
}
