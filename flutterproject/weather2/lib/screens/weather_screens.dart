import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:weather2/model/Model.dart';


class WeatherScreens extends StatefulWidget {
  const WeatherScreens({this.parseWeatherData, this.parseAirPollution});
  final parseWeatherData;
  final parseAirPollution;
  @override
  State<WeatherScreens> createState() => _WeatherScreensState();
}

class _WeatherScreensState extends State<WeatherScreens> {

  Model model = Model();
  String? cityName;
  int? temp;
  Widget? icon;
  var date = DateTime.now();
  String? des;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateData(widget.parseWeatherData, widget.parseAirPollution);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
     appBar: AppBar(
       title: Text(''),
       backgroundColor: Colors.transparent,
       elevation: 0.0,
       leading: IconButton(
         icon: Icon(Icons.near_me),
         onPressed: (){},
       ),
       actions: [
         IconButton(
           onPressed: (){},
           icon: Icon(Icons.location_searching),
         ),
       ],
     ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'image/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150.0,
                            ),
                            Text('$cityName',
                              style: GoogleFonts.lato(
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                TimerBuilder.periodic(
                                  (Duration(minutes: 1)),
                                  builder: (context) {
                                    return Text(getSystemTime(),
                                      style: GoogleFonts.lato(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    );
                                  },
                                ),
                                Text(
                                  DateFormat(' - EEEE, ').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('d MMM, yyy').format(date),
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$temp\u2103',
                              style: GoogleFonts.lato(
                                fontSize: 85.0,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                icon!,
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('$des',
                                  style: GoogleFonts.lato(
                                    fontSize: 16.0, color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Divider(
                        height: 15.0,
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('AQI(대기질지수)',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0, color: Colors.white,
                                ),
                              ),
                              Image.asset('image/bad.png',
                                width: 37.0,
                                height: 35.0,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('매우나쁨',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0, color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('174',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text('초미세먼지',
                                style: GoogleFonts.lato(
                                  fontSize: 16.0, color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('84.03',
                                style: GoogleFonts.lato(
                                  fontSize: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text('/m3',
                                style: GoogleFonts.lato(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void updateData(dynamic weatherData, dynamic airData){
    cityName = weatherData['name'];
    double temp2 = weatherData['main']['temp'];
    int condition = weatherData['weather'][0]['id'];
    temp = temp2.toInt();
    icon = model.getWeatherIcon(condition);
    des = weatherData['wea ther'][0]['description'];
    print(airData);
  }

  String getSystemTime(){
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }
}
