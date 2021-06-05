import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class TimeSeriesRangeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final DateTime startDate;
  final DateTime endDate;

  TimeSeriesRangeChart(this.seriesList, this.startDate, this.endDate,
      {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList, animate: animate, behaviors: [
      new charts.RangeAnnotation([
        new charts.RangeAnnotationSegment(this.startDate, this.endDate,
            charts.RangeAnnotationAxisType.domain),
      ]),
    ]);
  }
}
