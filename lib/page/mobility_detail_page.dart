import 'package:flutter/material.dart';

import '../constant.dart';

class MobilityDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Mobility Data Details"),
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
              "What do these numbers mean?",
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
                  "We are able to provide insights thanks to the mobility reports provide by google on a daily basis.\n\nThe numbers you find on our Mobility Data page are the change in mobility behavior during the pandamic compared to the mean of 5 weeks before the Covid-19 outbreak.\nThe mean of this 5 week period before the pandemic is considered the Baseline. Meaning the data we provide on our platform is the difference in mobility from that baseline in percentages. \n\nFor example if the Park card says 100%, this means there have been 100% more park visits during that day compared to the Baseline which is set at the period of Jan 3 - Feb 5, 2020."),
            ),
          ],
        ),
      ),
    );
  }
}
