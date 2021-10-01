import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'dart:async';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Timer _everySecond;
  String desired = "30";
  static const api = "e6a8cf3bb9579b7f489624e2e3c6fa51";
  double? celsius;
  WeatherFactory wf = WeatherFactory(api, language: Language.ENGLISH);

  Future<void> weatherdata() async {
    // Imagine that this function is fetching user info from another service or database.
    Weather w = await wf.currentWeatherByCityName("Dhaka");
    celsius = w.temperature!.celsius;
    desired = 'Temperature :' + celsius!.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();

    // sets first value

    weatherdata();

    // defines a timer
    _everySecond = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        weatherdata();
        int i = 0;
        if (celsius != null)
          desired = 'Temperature : ' + celsius!.toStringAsFixed(2) + "\u2103";
      });
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
                    "Dhaka, Bangladesh",
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.edit_location_alt_outlined,
                    color: Colors.teal,
                  ),
                )),
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
                      desired,
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Long: 23',
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontFamily: 'Source Sans Pro',
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lat: 90',
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
                  'Advanced Data',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Color(0xffffd946),
                textColor: Colors.black,
                onPressed: () {},
              ),
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
