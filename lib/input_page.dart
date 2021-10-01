import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helios/result_page.dart';
import 'package:helios/brain.dart';
import 'package:helios/networking.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  int fan = 1;
  int light = 1;
  int fridge = 1;
  int ac = 1;
  int watt = 225;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Solar Panel"),
          ),
        ),
        backgroundColor: Colors.white24,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ReusableWidget(
                card: Column(
                  children: [
                    Center(child: Text("FAN")),
                    Center(child: Text(fan.toString())),
                    Slider(
                      value: fan.toDouble(),
                      min: 1,
                      max: 50,
                      onChanged: (double newValue) {
                        setState(() {
                          fan = newValue.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ReusableWidget(
                card: Column(
                  children: [
                    Center(child: Text("LIGHT")),
                    Center(child: Text(light.toString())),
                    Slider(
                      value: light.toDouble(),
                      min: 1,
                      max: 50,
                      onChanged: (double newValue) {
                        setState(() {
                          light = newValue.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ReusableWidget(
                card: Column(
                  children: [
                    Center(child: Text("AC")),
                    Center(child: Text(ac.toString())),
                    Slider(
                      value: ac.toDouble(),
                      min: 1,
                      max: 10,
                      onChanged: (double newValue) {
                        setState(() {
                          ac = newValue.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ReusableWidget(
                card: Column(
                  children: [
                    Center(child: Text("REFRIGERATOR")),
                    Center(child: Text(fridge.toString())),
                    Slider(
                      value: fridge.toDouble(),
                      min: 1,
                      max: 10,
                      onChanged: (double newValue) {
                        setState(() {
                          fridge = newValue.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ReusableWidget(
                card: Column(
                  children: [
                    Center(child: Text("SOLAR PANEL WATT")),
                    Center(child: Text(watt.toString())),
                    Slider(
                      value: watt.toDouble(),
                      min: 225,
                      max: 400,
                      onChanged: (double newValue) {
                        setState(() {
                          watt = newValue.round();
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Brain _brain = Brain(
                    fan: fan, ac: ac, fridge: fridge, watt: watt, light: light);
                var _network = new Network();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => result_page(
                              panel_count: _brain.count(),
                              energy: _brain.sokti(),
                            )));
              },
              child: Container(
                child: Center(child: Text("SUBMIT")),
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(25.0)),
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10),
              ),
            )
          ],
        ));
  }
}

class ReusableWidget extends StatelessWidget {
  ReusableWidget({required this.card});

  final Widget card;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: card,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(5),
    );
  }
}
