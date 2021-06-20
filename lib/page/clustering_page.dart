import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covid_app/constant.dart';
import 'package:covid_app/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import 'mobility_detail_page.dart';

class ClusteringPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ClusteringPageState();
}

class ClusteringPageState extends State<ClusteringPage> {
  MapShapeSource _shapeSource;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text('Province Clustering'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 28, 76, 178),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text(
              "Belgian Provinces",
              style: kTitleTextstyle,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: "Clustering \n", style: kTitleTextstyle),
                      TextSpan(
                        text: "How were clusters detirmined?",
                        style: TextStyle(color: kTextLightColor),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                    child: Text(
                      "See details",
                      style: TextStyle(
                          color: kPrimaryColor, fontWeight: FontWeight.w600),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MobilityDetailPage()));
                    }),
              ],
            ),
          ),
          FutureBuilder<List<MapModel>>(
            future: fetchClusterResults(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                _shapeSource = MapShapeSource.asset('assets/geojson.json',
                    shapeDataField: 'NameDUT',
                    dataCount: snapshot.data.length,
                    primaryValueMapper: (int index) =>
                        snapshot.data[index].province,
                    shapeColorValueMapper: (int index) =>
                        snapshot.data[index].color);

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: SfMaps(
                      layers: [
                        MapShapeLayer(
                          source: _shapeSource,
                          shapeTooltipBuilder:
                              (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.all(7),
                              child: Text(
                                "Cluster: " +
                                    snapshot.data[index].cluster.toString() +
                                    "\n" +
                                    snapshot.data[index].province,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          },
                          //legend: MapLegend(MapElement.shape),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Future<List<MapModel>> fetchClusterResults() async {
    List<MapModel> list = [];
    var response =
        await http.get(Uri.parse("http://139.162.248.210:8000/kmeans"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      var jsonCluster = responseJson['PROVINCES'];
      for (int i = 0; i < jsonCluster.length; i++) {
        if (jsonCluster[i]["PROVINCE"] == "LiÃ¨ge") {
          list.add(
              new MapModel("Liège", double.parse(jsonCluster[i]["CLUSTER"])));
        }
        list.add(new MapModel(jsonCluster[i]["PROVINCE"],
            double.parse(jsonCluster[i]["CLUSTER"]) + 1));
      }
      return list;
    } else {
      throw Exception("Failed to load data.");
    }
  }
}

class MapModel {
  MapModel(this.province, this.cluster) {
    if (this.cluster == 1.0) {
      this.color = Colors.green;
    } else if (this.cluster == 2.0) {
      this.color = Colors.yellow;
    } else if (this.cluster == 3.0) {
      this.color = Colors.orange;
    } else if (this.cluster == 4.0) {
      this.color = Colors.red;
    }
  }

  String province;
  Color color;
  double cluster;
}
