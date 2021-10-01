import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


//  late ZoomPanBehavior _zoomPanBehavior;
//   Network network = Network();
//   Map<String, double> database = {};
//   List<DataModel> dataEntries = [];
//   @override
//   void initState() {
//     super.initState();
//     _zoomPanBehavior = ZoomPanBehavior(
//       enablePinching: true,
//       enableDoubleTapZooming: true,
//       zoomMode: ZoomMode.x,
//       enablePanning: true,
//     );
//     getData();
//   }

//   Future<void> getData() async {
//     database = await network.getData();
//     dataEntry();
//   }

//   void dataEntry() {
//     for (var element in database.entries) {
//       dataEntries.add(
//           DataModel(time: DateTime.parse(element.key), value: element.value));
//     }
//     setState(() {});
//   }








// SfCartesianChart(
//       enableAxisAnimation: true,
//       zoomPanBehavior: _zoomPanBehavior,
//       primaryXAxis: DateTimeAxis(),
//       series: <ChartSeries>[
//         LineSeries<DataModel, DateTime>(
//           dataSource: dataEntries,
//           xValueMapper: (DataModel data, _) => data.time,
//           yValueMapper: (DataModel data, _) => data.value,
//         ),
//       ],
//     )