import 'package:flutter/material.dart';
import 'package:weather2/data/network.dart';

import 'package:weather2/data/my_location.dart';
import 'package:weather2/screens/weather_screens.dart';

final apikey = '17aa944e4c983b47cecf46302d16053a';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);


  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3 ;
  double? longitude3 ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: null,
          child: const Text('myLocation',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  void getLocation() async {
   MyLocation myLocation = MyLocation();
   await myLocation.getMyCurrentLocation();
   latitude3 = myLocation.latitude2;
   longitude3 = myLocation.longitude2;
   print(latitude3);
   print(longitude3);

   Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=${latitude3}&lon=${longitude3}&appid=$apikey&units=metric',
       'http://api.openweathermap.org/data/2.5/air_pollution?lat=${latitude3}&lon=${longitude3}&appid=$apikey');
   var weatherData = await network.getJsonData();
   var AirData = await network.getAirData();

    Navigator.push(context, MaterialPageRoute(builder:(context) {
      return WeatherScreens(parseWeatherData: weatherData, parseAirPollution: AirData);
    }));
  }



  // void fetchData() async {
  //   var id = paringData['id'];
  //   var wind = paringData['weather'][0]['description'];
  // }

}
