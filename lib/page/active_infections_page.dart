import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:covid_app/widgets/time_series_range_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ActiveInfectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Active Infections'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 141, 72, 1),
        ),
        body: TimeSeriesRangeChart(_createSampleData(),
            new DateTime(2021, 3, 15), new DateTime(2021, 4, 6)),
      );

  static List<charts.Series<DataPoint, DateTime>> _createSampleData() {
    final data = [
      new DataPoint(new DateTime(2021, 3, 10), 5),
      new DataPoint(new DateTime(2021, 3, 26), 25),
      new DataPoint(new DateTime(2021, 4, 5), 100),
      new DataPoint(new DateTime(2021, 4, 10), 75),
    ];

    return [
      new charts.Series<DataPoint, DateTime>(
        id: 'DataPoints',
        domainFn: (DataPoint dataPoint, _) => dataPoint.time,
        measureFn: (DataPoint dataPoint, _) => dataPoint.sales,
        data: data,
      )
    ];
  }
}

class DataPoint {
  final DateTime time;
  final int sales;

  DataPoint(this.time, this.sales);
}
