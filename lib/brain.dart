import 'dart:math';
import 'package:helios/input_page.dart';
import 'package:helios/networking.dart';

class Brain {
  Brain(
      {required this.fan,
      required this.ac,
      required this.fridge,
      required this.watt,
      required this.light});
  final int fan;
  final int ac;
  final int watt;
  final int fridge;
  final int light;
  int peakhour = 5;
  var panel_count;
  var energy;

  String count() {
    var fan_watt = fan * 75;
    var ac_watt = ac * 3500;
    var fridge_watt = fridge * 180;
    var light_watt = light * 10;
    var usage = (fan_watt + ac_watt + fridge_watt + light_watt);
    panel_count = (usage * peakhour) / watt;
    return panel_count.toStringAsFixed(0);
  }

  String sokti() {
    energy = peakhour * watt;
    return energy.toStringAsFixed(2);
  }
}
