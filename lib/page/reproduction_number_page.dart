import 'dart:convert';

import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:fl_animated_linechart/chart/animated_line_chart.dart';
import 'package:fl_animated_linechart/chart/line_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../constant.dart';

class ReproductionNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Reproduction Number'),
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
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
                child: FutureBuilder<List<Map<DateTime, double>>>(
                  future: _fetchInfectionsPred(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return new AnimatedLineChart(
                        new LineChart.fromDateTimeMaps(
                          [snapshot.data[0]],
                          [Colors.red],
                          ["Reproduction number"],
                        ),
                      );
                    } else {
                      return AlertDialog(
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
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
                  "This forecast was obtained using a Neural Network.\n\nThe training of the model happens daily based on the most recent Covid-19 numbers in Belgium.\nIn the chart above you can observe the predictions made by the model.\n\nFor more details on the model please refer to our paper.",
                  style: kSubTextStyle.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );

  Future<List<Map<DateTime, double>>> _fetchInfectionsPred() async {
    List<Map<DateTime, double>> result = [];
    Map<DateTime, double> data = {};
    Map<DateTime, double> data2 = {};

    var response = await http
        .get(Uri.parse("http://139.162.248.210:8000/predictions/Belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      DateFormat formatter2 = new DateFormat('MM-dd-yyyy');

      for (int i = 0; i < responseJson.length; i++) {
        final newDate = responseJson[i]["DATE"].replaceAll('/', '-');
        var newDate2 = formatter2.parse(newDate);
        //var newDate3 = formatter1.parse(newDate2.toString());
        data[newDate2] = double.parse(responseJson[i]["RT"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    result.add(data);

    var response2 =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response2.statusCode == 200) {
      final responseJson2 = jsonDecode(response2.body);
      for (int i = responseJson2.length - 3;
          i > responseJson2.length - 30;
          i--) {
        data2[DateTime.parse(responseJson2[i]["DATE"])] =
            double.parse(responseJson2[i]["ACTIVE_CASES"]);
      }
    } else {
      throw Exception("Failed to load actual data");
    }
    result.add(data2);

    return result;
  }
}
