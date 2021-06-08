import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:covid_app/widgets/time_series_range_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../constant.dart';

class ActiveInfectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Active Infections'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 28, 76, 178),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 320,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 30,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: TimeSeriesRangeChart(_createSampleData(),
                    new DateTime(2021, 3, 15), new DateTime(2021, 4, 6)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "INFO",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 30,
                      color: kShadowColor,
                    )
                  ],
                ),
                child: Text(
                  "This forecast was obtained using by a Neural Network.\n\nThe training of the model happens daily based on the most recent Covid-19 numbers in Belgium.\nIn the chart above you can observe the predictions made by the model.\n\nFor more details on the model please refer to our paper.",
                  style: kSubTextStyle.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
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
