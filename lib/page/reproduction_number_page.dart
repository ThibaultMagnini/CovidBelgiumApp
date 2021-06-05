import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReproductionNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Reproduction Number'),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 141, 72, 1),
        ),
      );
}
