import 'package:covid_app/constant.dart';
import 'package:covid_app/widgets/line_chart.dart';
import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

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
  String selectedCat = "Daily Infections";

  Chart chart = new Chart(_createSampleDataInfections());
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
                                "CoronaPredBE \nCovid-19 forecasts.",
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
                "Active Numbers on",
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
                            'Daily Infections',
                            'Daily Recoveries',
                            'Daily Hospitalisations',
                            'Daily Deaths'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == 'Daily Infections') {
                                chart =
                                    new Chart(_createSampleDataInfections());
                              } else if (value == 'Daily Recoveries') {
                                chart =
                                    new Chart(_createSampleDataRecoveries());
                              } else if (value == 'Daily Hospitalisations') {
                                chart = new Chart(
                                    _createSampleDataHospitalisations());
                              } else if (value == 'Daily Deaths') {
                                chart = new Chart(_createSampleDataDeaths());
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
                child: chart,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      );

  static List<charts.Series<DataPointLine, int>> _createSampleDataInfections() {
    final data = [
      new DataPointLine(0, 15),
      new DataPointLine(1, 5),
      new DataPointLine(2, 25),
      new DataPointLine(3, 100),
      new DataPointLine(4, 75),
    ];

    return [
      new charts.Series<DataPointLine, int>(
        id: 'DataPoints',
        domainFn: (DataPointLine dataPoint, _) => dataPoint.time,
        measureFn: (DataPointLine dataPoint, _) => dataPoint.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<DataPointLine, int>> _createSampleDataRecoveries() {
    final data = [
      new DataPointLine(0, 15),
      new DataPointLine(1, 100),
      new DataPointLine(2, 23),
      new DataPointLine(3, 10),
      new DataPointLine(4, 120),
    ];

    return [
      new charts.Series<DataPointLine, int>(
        id: 'DataPoints',
        domainFn: (DataPointLine dataPoint, _) => dataPoint.time,
        measureFn: (DataPointLine dataPoint, _) => dataPoint.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<DataPointLine, int>>
      _createSampleDataHospitalisations() {
    final data = [
      new DataPointLine(0, 25),
      new DataPointLine(1, 122),
      new DataPointLine(2, 65),
      new DataPointLine(3, 1),
      new DataPointLine(4, 3),
      new DataPointLine(5, 25),
      new DataPointLine(6, 122),
      new DataPointLine(7, 65),
      new DataPointLine(8, 1),
      new DataPointLine(9, 3),
      new DataPointLine(10, 25),
      new DataPointLine(11, 122),
      new DataPointLine(12, 65),
      new DataPointLine(13, 1),
      new DataPointLine(14, 3),
      new DataPointLine(15, 25),
      new DataPointLine(16, 122),
      new DataPointLine(17, 65),
      new DataPointLine(18, 1),
      new DataPointLine(19, 3),
      new DataPointLine(20, 25),
      new DataPointLine(21, 122),
      new DataPointLine(22, 65),
      new DataPointLine(23, 1),
      new DataPointLine(24, 3),
      new DataPointLine(25, 25),
      new DataPointLine(26, 122),
      new DataPointLine(27, 65),
      new DataPointLine(28, 1),
      new DataPointLine(29, 3),
    ];

    return [
      new charts.Series<DataPointLine, int>(
        id: 'DataPoints',
        domainFn: (DataPointLine dataPoint, _) => dataPoint.time,
        measureFn: (DataPointLine dataPoint, _) => dataPoint.sales,
        data: data,
      )
    ];
  }

  static List<charts.Series<DataPointLine, int>> _createSampleDataDeaths() {
    final data = [
      new DataPointLine(0, 10),
      new DataPointLine(1, 20),
      new DataPointLine(2, 12),
      new DataPointLine(3, 5),
      new DataPointLine(4, 9),
    ];

    return [
      new charts.Series<DataPointLine, int>(
        id: 'DataPoints',
        domainFn: (DataPointLine dataPoint, _) => dataPoint.time,
        measureFn: (DataPointLine dataPoint, _) => dataPoint.sales,
        data: data,
      )
    ];
  }
}

class DataPointLine {
  final int time;
  final int sales;

  DataPointLine(this.time, this.sales);
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
