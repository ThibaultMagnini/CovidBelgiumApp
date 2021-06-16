import 'package:covid_app/constant.dart';
import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

class ContributerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: AppBar(
          title: Text('Contributors'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 28, 76, 178),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: kActiveShadowColor,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/jonas.jpg"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Jonas De Boeck"),
                      Text(
                        "UCLL",
                        style: kTitleTextstyle,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: kActiveShadowColor,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage("assets/images/thibault.jpg"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Thibault Magnini"),
                      Text(
                        "UCLL",
                        style: kTitleTextstyle,
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: kActiveShadowColor,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/cassio.png"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Cássio M. Oishi"),
                      Text(
                        "UNESP",
                        style: kTitleTextstyle,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 180,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 20,
                        color: kActiveShadowColor,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/images/pfp.png"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Fabio Amaral"),
                      Text(
                        "UNESP",
                        style: kTitleTextstyle,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      );
}