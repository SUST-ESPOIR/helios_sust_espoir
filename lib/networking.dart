import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {
  Map<String, double> _database = {};

  Future<Map<String, double>> getData() async {
    http.Response response = await http.get(Uri.parse(
        "https://power.larc.nasa.gov/api/temporal/daily/point?parameters=ALLSKY_SFC_SW_DWN&community=SB&longitude=91.783180&latitude=22.356852&start=20210901&end=20210930&format=JSON"));

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      decodedData["properties"]["parameter"]["ALLSKY_SFC_SW_DWN"]
          .forEach((key, value) {
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
