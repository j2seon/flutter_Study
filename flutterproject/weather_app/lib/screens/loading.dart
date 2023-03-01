import 'package:flutter/material.dart';
import 'package:weather_app/data/my_location.dart';
import 'package:weather_app/data/network.dart';
import 'package:weather_app/screens/weather_screen.dart';

const apikey ='17aa944e4c983b47cecf46302d16053a';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  double? latitude3 ;
  double? longtitude3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    MyLocation myLocation = MyLocation();
    await myLocation.getMyCurrentLocation();
    latitude3 = myLocation.latitude2;
    longtitude3 = myLocation.longtitude2;
    print(latitude3);
    print(longtitude3);

    Network network = Network('https://api.openweathermap.org/data/2.5/weather?lat=$latitude3&lon=$longtitude3&appid=$apikey&units=metric',
        'http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude3&lon=$longtitude3&appid=$apikey'
    );
    var weatherData = await network.getJsonData();
    var airData = await network.getAirData();
    print(weatherData);
    print(airData);

    Navigator.push(context,MaterialPageRoute(
        builder: (context) {
          return WeatherScreen(parseWeatherData: weatherData,parseAirPollution: airData);
        }
    ));
  }

  // void fetchData() async {
  //   http.Response response = await http.get(Uri.parse('https://samples.openweathermap.org/data/2.5/weather?q=London&appid=b1b15e88fa797225412429c1c50c122a1'));
  //   if(response.statusCode == 200){
  //     String JsonData = response.body;
  //     var pasingData = jsonDecode(JsonData);
  //     var myJson = pasingData['weather'][0]['description'];
  //       print(myJson);
  //     var windspeed = pasingData['wind']['speed'];
  //     var id = jsonDecode(JsonData)['id'];
  //     print(windspeed);
  //     print(id);
  //   }else{
  //     print(response.statusCode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Get My Location',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: null,
        ),
      ),
    );
  }
}
