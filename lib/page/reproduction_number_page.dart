import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ReproductionNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Reproduction Number'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 28, 76, 178),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
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
                child: Text("TODO"),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "INFO",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 310,
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
                  "This forecast was obtained using by a Neural Network.\n\nThe training of the model happens daily based on the most recent Covid-19 numbers in Belgium.\nIn the chart above you can observe the predictions made by the model.\n\nFor more details on the model please refer to our paper.",
                  style: kSubTextStyle.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
}
