import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchLatestInfection() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    print(responseJson[responseJson.length - 1]["NEW_CASES"]);
    return responseJson[responseJson.length - 3]["NEW_CASES"];
  } else {
    return "NA";
  }
}

Future<String> fetchLatestDeaths() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    return responseJson[responseJson.length - 3]["NEW_DEATHS"];
  } else {
    return "NA";
  }
}

Future<String> fetchLatestRecovered() async {
  var response =
      await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
  if (response.statusCode == 200) {
    final responseJson = jsonDecode(response.body);
    return responseJson[responseJson.length - 3]["NEW_RECOVERED"];
  } else {
    return "NA";
  }
}

Future<Map<DateTime, double>> fetchCovidData(int chartIndex) async {
  Map<DateTime, double> data = {};
  var response;
  if (chartIndex == 3) {
    response = await http
        .get(Uri.parse("http://139.162.248.210:8000/hospitalisations/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["TOTAL_IN_ICU"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else if (chartIndex == 2) {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["NEW_RECOVERED"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else if (chartIndex == 4) {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["NEW_DEATHS"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  } else {
    response =
        await http.get(Uri.parse("http://139.162.248.210:8000/cases/belgium"));
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      for (int i = responseJson.length - 3; i > responseJson.length - 33; i--) {
        data[DateTime.parse(responseJson[i]["DATE"])] =
            double.parse(responseJson[i]["ACTIVE_CASES"]);
      }
    } else {
      throw Exception("Failed to load data.");
    }
    return data;
  }
}
