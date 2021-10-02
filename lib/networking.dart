import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  final Map<String, double> _database = {};

  Future<Map<String, double>> getData(
      {required String temporal,
      required String parameter,
      required double lat,
      required double long,
      required String start,
      required String end}) async {
    http.Response response = await http.get(Uri.parse(
        "https://power.larc.nasa.gov/api/temporal/$temporal/point?parameters=$parameter&community=SB&longitude=$long&latitude=$lat&start=$start&end=$end&format=JSON"));

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      decodedData["properties"]["parameter"][parameter].forEach((key, value) {
        if (value == -999.0) {
          _database[key] = 0;
        } else {
          _database[key] = value;
        }
      });
    } else {
      print(response.statusCode);
    }

    return _database;
  }
}
