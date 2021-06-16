import 'dart:convert';

import 'package:covid_app/constant.dart';
import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fl_animated_linechart/fl_animated_linechart.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid-19 Belgium',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        fontFamily: "Poppins",
        textTheme: TextTheme(bodyText1: TextStyle(color: kBodyTextColor)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePage();
}

class HomePage extends State<Home> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String selectedCat = "Active Infections";
  int chartIndex = 1;
  String infectedToday = "NA";
  String recoveredToday = "NA";
  String deathsToday = "NA";

  HomePage() {
    _fetchLatestInfection().then((val) => setState(() {
          infectedToday = val;
        }));

    _fetchLatestDeaths().then((val) => setState(() {
          deathsToday = val;
        }));

    _fetchLatestRecovered().then((val) => setState(() {
          recoveredToday = val;
        }));
  }

  LineChart chart;
  DateFormat formatter = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavigationDrawerWidget(),
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  padding: EdgeInsets.only(left: 5, top: 30, right: 20),
                  height: 310,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF3383CD),
                        Color(0xFF11249F),
                      ],
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/virus.png'),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                          onPressed: () =>
                              scaffoldKey.currentState.openDrawer(),
                          icon: Icon(
                            Icons.menu,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/icons/coronadr.svg',
                              width: 230,
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                            ),
                            Positioned(
                              left: 160,
                              child: Text(
                                "CoronaPredBE \nCovid-19 forecast",
                                style: kHeadingTextStyle.copyWith(
                                    color: Colors.white),
                              ),
                            ),
                            Container(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "Latest Numbers",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              Text(
                formatter.format(DateTime.now()).toString(),
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 60,
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
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: DropdownButton(
                          isExpanded: true,
                          underline: SizedBox(
                            width: 10,
                          ),
                          value: selectedCat,
                          icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                          items: [
                            'Active Infections',
                            'Daily Recoveries',
                            'Hospitalisations',
                            'Daily Deaths'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == 'Active Infections') {
                                chartIndex = 1;
                              } else if (value == 'Daily Recoveries') {
                                chartIndex = 2;
                              } else if (value == 'Hospitalisations') {
                                chartIndex = 3;
                              } else if (value == 'Daily Deaths') {
                                chartIndex = 4;
                              }
                              selectedCat = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 30,
                      color: kShadowColor,
                    ),
                  ],
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Counter(
                      number: infectedToday,
                      title: "infections",
                      color: kInfectedColor,
                    ),
                    Counter(
                      number: recoveredToday,
                      title: "recoveries",
                      color: kRecovercolor,
                    ),
                    Counter(
                      number: deathsToday,
                      title: "deaths",
                      color: kDeathColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                height: 350,
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
                child: FutureBuilder<Map<DateTime, double>>(
                  future: _fetchCovidData(chartIndex),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      chart = new LineChart.fromDateTimeMaps([
                        snapshot.data
                      ], [
                        Colors.blue
                      ], [
                        if (chartIndex == 1)
                          "Cases"
                        else if (chartIndex == 2)
                          "Recoveries"
                        else if (chartIndex == 3)
                          "in ICU"
                        else
                          "Deaths"
                      ], tapTextFontWeight: FontWeight.w400);
                      return new AnimatedLineChart(chart);
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
            ],
          ),
        ),
      );
}

class Counter extends StatelessWidget {
  const Counter({
    Key key,
    @required this.number,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  final String number;
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(6),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.26),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(color: color, width: 2),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          number,
          style: TextStyle(fontSize: 40, color: color),
        ),
        Text(
          title,
          style: kSubTextStyle,
        )
      ],
    );
  }
}

Future<String> _fetchLatestInfection() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print(responseJson[responseJson.length - 1]["NEW_CASES"]);
    return responseJson[responseJson.length - 3]["NEW_CASES"];
  } else {
    return "NA";
  }
}

Future<String> _fetchLatestDeaths() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    return responseJson[responseJson.length - 3]["NEW_DEATHS"];
  } else {
    return "NA";
  }
}

Future<String> _fetchLatestRecovered() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    return responseJson[responseJson.length - 3]["NEW_RECOVERED"];
  } else {
    return "NA";
  }
}

Future<Map<DateTime, double>> _fetchCovidData(int chartIndex) async {
  Map<DateTime, double> data = {};
  var response;
  if (chartIndex == 3) {
    response = await http
        .get(Uri.parse("http://139.162.248.210:8000/hospitalisations/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["TOTAL_IN_ICU"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else if (chartIndex == 2) {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["NEW_RECOVERED"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else if (chartIndex == 4) {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["NEW_DEATHS"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["ACTIVE_CASES"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
