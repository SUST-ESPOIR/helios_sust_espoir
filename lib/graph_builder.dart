import 'package:flutter/material.dart';
import 'package:helios/data_model.dart';
import 'package:helios/networking.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphBuilder extends StatefulWidget {
  final String temporal;
  final String parameter;
  final double lat;
  final double long;
  final String start;
  final String end;
  GraphBuilder(
      {required this.temporal,
      required this.parameter,
      required this.lat,
      required this.long,
      required this.start,
      required this.end});

  @override
  _GraphBuilderState createState() => _GraphBuilderState();
}

class _GraphBuilderState extends State<GraphBuilder> {
  late ZoomPanBehavior _zoomPanBehavior;
  Network network = Network();
  Map<String, double> database = {};
  List<DataModel> dataEntries = [];
  TrackballBehavior _trackballBehavior = TrackballBehavior();

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipSettings:
            const InteractiveTooltip(format: 'point.x : point.y W/m^2'));
    getData();
  }

  Future<void> getData() async {
    database = await network.getData(
      temporal: widget.temporal,
      parameter: widget.parameter,
      start: widget.start,
      end: widget.end,
      lat: widget.lat,
      long: widget.long,
    );
    dataEntry();
  }

  void dataEntry() {
    for (var element in database.entries) {
      dataEntries.add(
          DataModel(time: DateTime.parse(element.key), value: element.value));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: "Solar Irradiance"),
      backgroundColor: Colors.white,
      enableAxisAnimation: true,
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: _trackballBehavior,
      primaryXAxis: DateTimeAxis(),
      primaryYAxis: NumericAxis(
        labelFormat: '{value} W/m^2',
      ),
      series: <ChartSeries>[
        LineSeries<DataModel, DateTime>(
          dataSource: dataEntries,
          xValueMapper: (DataModel data, _) => data.time,
          yValueMapper: (DataModel data, _) => data.value,
          enableTooltip: true,
        ),
      ],
    );
  }
}
