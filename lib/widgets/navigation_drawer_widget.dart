import 'package:covid_app/main.dart';
import 'package:covid_app/page/about_page.dart';
import 'package:covid_app/page/active_infections_page.dart';
import 'package:covid_app/page/contributers_page.dart';
import 'package:covid_app/page/province_clustering_page.dart';
import 'package:covid_app/page/reproduction_number_page.dart';
import 'package:covid_app/page/total_recoveries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final title = "CoronaPredBE";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromARGB(255, 28, 76, 178),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
              title: title,
              date: DateTime.now(),
              onClicked: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home())),
            ),
            buildMenuItem(
              text: 'Active Infections',
              icon: Icons.bolt,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Total recoveries',
              icon: Icons.healing,
              onClicked: () => selectedItem(context, 1),
            ),
            buildMenuItem(
              text: 'Reproduction Number',
              icon: Icons.exposure_plus_1,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 15),
            Divider(color: Colors.white70),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'About',
              icon: Icons.info,
              onClicked: () => selectedItem(context, 5),
            ),
            buildMenuItem(
              text: 'Contributors',
              icon: Icons.people,
              onClicked: () => selectedItem(context, 6),
            ),
            buildMenuItem(
              text: 'Official Paper',
              icon: Icons.description,
              onClicked: () => selectedItem(context, 7),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      onTap: onClicked,
    );
  }

  Widget buildHeader({
    String title,
    DateTime date,
    VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(
            vertical: 40,
          )),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/wear_mask.png"),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    formatter.format(date).toString(),
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Active()));
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TotalRecoveriesPage(),
          ),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ReproductionNumberPage(),
          ),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProvinceClusteringPage(),
          ),
        );
        break;
      case 5:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AboutPage(),
          ),
        );
        break;
      case 6:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ContributerPage(),
          ),
        );
    }
  }
}
