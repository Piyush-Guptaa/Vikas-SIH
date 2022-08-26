import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:path_provider/path_provider.dart';

String baseUrl = "https://vikas-api.herokuapp.com";

Future<bool> uploadUserData(Map data) async {
  http.Response response = await http.post(
    Uri.parse("$baseUrl/SHGData/AddData"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  return response.statusCode == 200 ? true : false;
}

Future<bool> checkInternetConnection() async {
  if (await ConnectivityWrapper.instance.isConnected) {
    print("connected");
    return true;
  } else {
    print("not connected");
    return false;
  }
}

Future<Map?> getSHGData(String id) async {
  http.Response response = await http.get(
    Uri.parse("$baseUrl/SHGData/GetData/$id"),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  if (response.statusCode == 404 || response.body.isEmpty) {
    return null;
  } else if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    return null;
  }
}

Future<bool> deleteSHGData(String id) async {
  http.Response response = await http.delete(
    Uri.parse("$baseUrl/SHGData/DeleteData/$id"),
    headers: {
      'Content-Type': 'application/json',
    },
  );
  return response.statusCode == 200 ? true : false;
}

Future<bool> sendBimg(String baseimg, String id) async {
  Map data = {
    "photo64": baseimg,
  };
  print(data);
  http.Response response = await http.patch(
    Uri.parse("$baseUrl/SHGData/Update/$id"),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  return response.statusCode == 200 ? true : false;
}
