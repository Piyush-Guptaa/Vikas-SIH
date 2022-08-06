import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String baseUrl = "https://api.github.com";

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

  http.Response response = await http.post(
    Uri.parse(baseUrl + "/users"),
    headers: {
      // "Authorization": "JWT $token",
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),
  );
  return response.statusCode == 200 ? true : false;
}
