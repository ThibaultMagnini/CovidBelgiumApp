import 'package:flutter/material.dart';

import '../constant.dart';

class ClusteringDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Clustering Result Details"),
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
              "How are these categories determined?",
              style: kTitleTextstyle.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              height: 500,
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
                  "The clustering results are obtained by using the kmeans clustering algorithm.\n\nTo Correctly cluster the provinces based on their covid-19 numbers the team carefully selected 3 Parameters. Being: Infection rate, Hospitalization rate and Percentage of positive tests per province.\n\nRunning the kmeans clustering on a daily basis based on these parameters we get the results that can be found on the Clustering page.\n\nFor the algorithm it is required to chose a number of clusters beforehand. We chose 4 clusters due to the most accurate results. This way we can categorise the provinces in 4 different categories."),
            ),
          ],
        ),
      ),
    );
  }
}
