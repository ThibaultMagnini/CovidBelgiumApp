import 'dart:io';

import 'package:covid_app/page/pdf_viewer_page.dart';
import 'package:covid_app/utils/pdf_loader.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class PapersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Papers"),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 28, 76, 178),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Our research",
                style: kTitleTextstyle.copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 160,
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
                    "To obtain the results and forecasts found in this app, several methodologies were researched and tested. For in depth information please refer to the papers below. "),
              ),
              SizedBox(
                height: 30,
              ),
              ButtonWidget(
                text: "General Report Belgium",
                onClicked: () async {
                  final path = 'assets/papers/AssessingCovid19CasesBelgium.pdf';
                  final file = await PDFLoader.loadPdf(path);
                  openPDF(context, file);
                },
              ),
              SizedBox(
                height: 30,
              ),
              ButtonWidget(
                text: "Neural Network & Forecasts",
                onClicked: () async {
                  final path = 'assets/papers/sensorDataDrivenPredictions.pdf';
                  final file = await PDFLoader.loadPdf(path);
                  openPDF(context, file);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key key,
    @required this.text,
    @required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(text, style: TextStyle(fontSize: 20)),
        onPressed: onClicked,
      );
}
