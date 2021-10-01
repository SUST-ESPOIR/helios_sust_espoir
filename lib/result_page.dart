import 'package:flutter/material.dart';
import 'input_page.dart';

class result_page extends StatelessWidget {
  result_page({required this.panel_count, required this.energy});

  final String panel_count;
  final String energy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    "Results",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ReusableWidget(
                card: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Solar Panel Needed',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      panel_count,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Hourly Energy",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      energy,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
