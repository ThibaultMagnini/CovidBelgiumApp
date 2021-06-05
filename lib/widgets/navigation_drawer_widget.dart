import 'package:covid_app/main.dart';
import 'package:covid_app/page/active_infections_page.dart';
import 'package:covid_app/page/prediction_range_page.dart';
import 'package:covid_app/page/province_clustering_page.dart';
import 'package:covid_app/page/reproduction_number_page.dart';
import 'package:covid_app/page/total_recoveries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 10);
  final urlimage =
      "https://www.london.gov.uk/sites/default/files/styles/gla_2_1_medium/public/covid-19-992x496px-fa.png?itok=PESyXRa1";
  final title = "Corona Pred";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(0, 141, 72, 1),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(
              urlImage: urlimage,
              title: title,
              date: DateTime.now(),
              onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MyHomePage(
                        title: 'Covid-19 Belgium',
                      ))),
            ),
            //const SizedBox(height: 10),
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
            buildMenuItem(
              text: 'Prediction Range',
              icon: Icons.straighten,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 15),
            Divider(color: Colors.white70),
            const SizedBox(height: 15),
            buildMenuItem(
              text: 'Province Clustering',
              icon: Icons.group_work,
              onClicked: () => selectedItem(context, 4),
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
              text: 'Contributers',
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
    String urlImage,
    String title,
    DateTime date,
    VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(urlimage),
              ),
              SizedBox(
                width: 20,
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
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ActiveInfectionsPage(),
          ),
        );
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
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PredictionRangePage(),
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
    }
  }
}
