import 'dart:convert';

import 'package:covid_app/constant.dart';
import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:fl_chart/fl_chart.dart' as bar;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mobility_detail_page.dart';

class Mobility extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MobilityDifferencePage();
}

class MobilityDifferencePage extends State<Mobility> {
  double retail = 0.0;
  double grocery = 0.0;
  double park = 0.0;
  double transit = 0.0;
  double workplace = 0.0;

  MobilityDifferencePage() {
    _fetchNumber("RETAIL").then((val) => setState(() {
          retail = val;
        }));
    _fetchNumber("GROCERY").then((val) => setState(() {
          grocery = val;
        }));
    _fetchNumber("PARKS").then((val) => setState(() {
          park = val;
        }));
    _fetchNumber("TRANSIT").then((val) => setState(() {
          transit = val;
        }));
    _fetchNumber("WORKPLACE").then((val) => setState(() {
          workplace = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Mobility Differences"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 28, 76, 178),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Mobility data \n", style: kTitleTextstyle),
                        TextSpan(
                          text: "What does this data mean?",
                          style: TextStyle(color: kTextLightColor),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  InkWell(
                      child: Text(
                        "See details",
                        style: TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.w600),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MobilityDetailPage()));
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: <Widget>[
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        _buildStatCard("Retail", "${retail}%", Colors.orange),
                        _buildStatCard("Grocery", "${grocery}%", Colors.yellow),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        _buildStatCard("Park", "${park}%", Colors.green),
                        _buildStatCard(
                            "Transit", "${transit}%", Colors.lightBlue),
                        _buildStatCard(
                            "Workplace", "${workplace}%", Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: 460,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 30,
                    color: kShadowColor,
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Mobility Difference Yesterday",
                    style: kTitleTextstyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 350.0,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: FutureBuilder<List<double>>(
                      future: _fetchMobilityData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return new bar.BarChart(
                            bar.BarChartData(
                              alignment: bar.BarChartAlignment.spaceAround,
                              maxY: 130,
                              barTouchData: bar.BarTouchData(enabled: true),
                              titlesData: bar.FlTitlesData(
                                show: true,
                                bottomTitles: bar.SideTitles(
                                  rotateAngle: 35,
                                  margin: 10.0,
                                  showTitles: true,
                                  getTitles: (double value) {
                                    switch (value.toInt()) {
                                      case 0:
                                        return 'retail';
                                      case 1:
                                        return 'grocery';
                                      case 2:
                                        return 'park';
                                      case 3:
                                        return 'transit';
                                      case 4:
                                        return 'workplace';
                                      default:
                                        return "";
                                    }
                                  },
                                ),
                                leftTitles: bar.SideTitles(
                                  margin: 15,
                                  showTitles: true,
                                  getTitles: (value) {
                                    if (value == 0) {
                                      return "0";
                                    } else if (value % 2 == 0) {
                                      return "${value}%";
                                    }
                                    return '';
                                  },
                                ),
                              ),
                              gridData: bar.FlGridData(
                                  show: true,
                                  checkToShowHorizontalLine: (value) =>
                                      value % 2 == 0,
                                  getDrawingHorizontalLine: (value) =>
                                      bar.FlLine(
                                          color: Colors.black12,
                                          strokeWidth: 1.0,
                                          dashArray: [5])),
                              borderData: bar.FlBorderData(show: false),
                              barGroups: snapshot.data
                                  .asMap()
                                  .map((key, value) => MapEntry(
                                        key,
                                        bar.BarChartGroupData(x: key, barRods: [
                                          bar.BarChartRodData(
                                              y: value, colors: [Colors.blue])
                                        ]),
                                      ))
                                  .values
                                  .toList(),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<double> _fetchNumber(String type) async {
    var response;
    var result;
    response = await http
        .get(Uri.parse("http://139.162.248.210:8000/mobility/belgium"));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      result = double.parse(responseJson[responseJson.length - 1][type]);
    } else {
      throw Exception("Failed to load data.");
    }
    return result;
  }

  Future<List<double>> _fetchMobilityData() async {
    List<double> data = [];
    var response;
    response = await http
        .get(Uri.parse("http://139.162.248.210:8000/mobility/belgium"));
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      data.add(double.parse(responseJson[responseJson.length - 1]["RETAIL"]));
      data.add(double.parse(responseJson[responseJson.length - 1]["GROCERY"]));
      data.add(double.parse(responseJson[responseJson.length - 1]["PARKS"]));
      data.add(double.parse(responseJson[responseJson.length - 1]["TRANSIT"]));
      data.add(
          double.parse(responseJson[responseJson.length - 1]["WORKPLACE"]));
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  }

  Expanded _buildStatCard(String title, String count, MaterialColor color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: color),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 20,
              color: kActiveShadowColor,
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
