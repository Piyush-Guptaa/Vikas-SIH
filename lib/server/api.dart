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
