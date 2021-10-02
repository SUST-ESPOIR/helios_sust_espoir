import 'package:flutter/material.dart';
import 'package:helios/utilities/constants.dart';
import 'package:helios/services/weather.dart';
import 'package:async/async.dart';
import 'city_screen.dart';

class HomeView extends StatefulWidget {
  HomeView({this.locationWeather});

  final locationWeather;


  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  WeatherModel weather = WeatherModel();
  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String country;
  late String weatherMessage;
  late double longi;
  late double lat;


  @override
  void initState() {
    super.initState();


    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        return;
      }
      double temp = weatherData['main']['temp'];
      longi = weatherData['coord']['lon'];
      lat = weatherData['coord']['lat'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      country = weatherData['sys']['country'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                margin: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 25.0),
                child: ListTile(

                    title: Text(
                      '$cityName, $country',
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                      ),
                    ),
                    trailing: FlatButton(
                        child: Icon(
                          Icons.edit_location_alt_outlined,
                          color: Colors.teal,
                        ),
                        textColor: Colors.black,
                        onPressed: () async {
                          var typedName = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return CityScreen();
                              },
                            ),
                          );
                          if (typedName != null) {
                            var weatherData =
                                await weather.getCityWeather(typedName);
                            updateUI(weatherData);
                          }
                        }))),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.yellow,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.only(left: 20.0, top: 30, right: 20.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(

                      'Temperature: $temperature\u2103',

                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
     'Lat: ${lat.toStringAsFixed(2)}',
         style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(

                      'Long: ${longi.toStringAsFixed(2)}',

                     

                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              margin: EdgeInsets.all(25),
              child: FlatButton(
                child: const Text(

                  'my location',
                  style: TextStyle(fontSize: 15.0),
                ),
                color: Color(0xffffd946),
                textColor: Colors.black,
                onPressed: () async {
                  var weatherData = await weather.getLocationWeather();
                  updateUI(weatherData);
                },


              ),
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
