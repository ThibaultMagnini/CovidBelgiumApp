import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text("About"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 28, 76, 178),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                "Goal of this research",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 285,
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
                  "The main goal of this Project and its research is to provide some unique insights into the COVID-19 numbers. With all the provided data one can think and compare numbers to make different conclusions.\n\nProviding the general public with a deeper understanding of the current situation and how it is developing. ",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Who & How",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 10,
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
                child: Text(
                  "This research was in collaboration with UNESP, Universidade Estadual Paulista at the Department of Computational Mathematis, guided by Professor Cássio M. Oishi. \n\nThe research specifically for the Belgian region has been done over a period of 3 months of Internship. The internship was carried out by 2 students, Jonas De Boeck & Thibault Magnini, Both last year students at UCLL, University College Leuven Limburg.",
                ),
              ),
            ],
          ),
        ),
      );
}
