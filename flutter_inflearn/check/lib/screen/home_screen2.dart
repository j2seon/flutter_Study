import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//37.4957323974
//127.038156868
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  bool choolCheckDone = false;
  GoogleMapController? mapController;

  static final LatLng companyLocation = LatLng(37.4957323974, 127.038156868);
  static final CameraPosition initialPosition = CameraPosition(
    target: companyLocation,
    zoom: 15,
  );

  static final double okdistance = 100;
  static final Circle withinDistanceCircle = Circle(
    circleId: CircleId('withinDistanceCircle'),
    center: companyLocation,
    fillColor: Colors.blue.withOpacity(0.5),
    strokeColor: Colors.blue,
    strokeWidth: 1,
    radius: okdistance,
  );
  static final Circle notwithinDistanceCircle = Circle(
    circleId: CircleId('notwithinDistanceCircle'),
    center: companyLocation,
    fillColor: Colors.red.withOpacity(0.5),
    strokeColor: Colors.red,
    strokeWidth: 1,
    radius: okdistance,
  );
  static final Circle checkDoneCircle = Circle(
    circleId: CircleId('checkDoneCircle'),
    center: companyLocation,
    fillColor: Colors.green.withOpacity(0.5),
    strokeColor: Colors.green,
    strokeWidth: 1,
    radius: okdistance,
  );

  static final Marker marker = Marker(
    markerId: MarkerId('marker'),
    position: companyLocation,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppbar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == '위치권한이 허가되었습니다.') {
            return StreamBuilder<Position>(
                stream: Geolocator.getPositionStream(),
                builder: (context, snapshot) {
                  bool isWithinRange = false;
                  if (snapshot.hasData) {
                    final start = snapshot.data!; //내위치
                    final end = companyLocation; //회사위치

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
          return Center(
            child: Text(snapshot.data!),
          );
        },
      ),
    );
  }

  onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

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

  Future<String> checkPermission() async {
    final isLocationEnable = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnable) {
      return '위치서비스를 활성화 해주세요';
    }
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    if (checkedPermission == LocationPermission.denied) {
      checkedPermission = await Geolocator.requestPermission();
      if (checkedPermission == LocationPermission.denied) {
        return '위치권한을 허가해주세요';
      }
    }
    if (checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치권한을 핸드폰 setting에서 허가해주세요';
    }

    return '위치권한이 허가되었습니다.';
  }

  AppBar renderAppbar() {
    return AppBar(
      title: Text(
        '오늘도 출근',
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.blue,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
            if (mapController == null) {
              return;
            }
            final myLocation = await Geolocator.getCurrentPosition();

            mapController!.animateCamera(
              CameraUpdate.newLatLng(
                LatLng(
                  myLocation.latitude,
                  myLocation.longitude,
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
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
      flex: 2,
    );
  }
}

class _ChoolCheckButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isWithinRange;
  final bool choolCheckDone;

  const _ChoolCheckButton({
    required this.isWithinRange,
    required this.onPressed,
    required this.choolCheckDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_rounded,
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
          if (!choolCheckDone && isWithinRange)
            TextButton(
              onPressed: onPressed,
              child: Text('출근하기'),
            ),
        ],
      ),
    );
  }
}
