import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:vikas/file.dart';

String baseUrl = "https://vikas-api.herokuapp.com";

Future<bool> uploadUserData(
    String name,
    String age,
    String gender,
    String shgname,
    String aadharnumber,
    String category,
    String monthlyincome,
    String bankname,
    String bankaccountnumber,
    String shgid) async {
  Map data = {
    "name": name,
    "age": age,
    "gender": gender,
    "shgname": shgname,
    "aadharnumber": aadharnumber,
    "category": category,
    "monthlyincome": monthlyincome,
    "bankname": bankname,
    "bankaccountnumber": bankaccountnumber,
    "shgid": shgid
  };
  print(data);

  await FileUtils.saveToFile(data);
  Map fileContents = await FileUtils.readFromFile().then((value) {
    return value;
  });
  print(fileContents);



  http.Response response = await http.post(
    Uri.parse(baseUrl + "/SHGData/AddData"),
    headers: {
      // "Authorization": "JWT $token",
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  return response.statusCode == 200 ? true : false;
}
