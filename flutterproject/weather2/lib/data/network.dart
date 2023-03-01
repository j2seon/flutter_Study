import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Network{
  final String url;
  final String url2;

  Network(this.url,this.url2);

  Future<dynamic> getJsonData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String jsonData = response.body;
      var pasingData = jsonDecode(jsonData);
      return pasingData;
    }
  }

  Future<dynamic> getAirData() async {
    http.Response response = await http.get(Uri.parse(url2));
    if (response.statusCode == 200) {
      String JsonData = response.body;
      var pasingData = jsonDecode(JsonData);
      return pasingData;
    }
  }
}
