import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalRecoveriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Total Recoveries'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 141, 72, 1),
        ),
      );
}
