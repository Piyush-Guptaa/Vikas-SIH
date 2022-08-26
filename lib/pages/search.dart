import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vikas/server/api.dart';

class SearchSHGPage extends StatefulWidget {
  const SearchSHGPage({Key? key}) : super(key: key);

  @override
  State<SearchSHGPage> createState() => _SearchSHGPageState();
}

class _SearchSHGPageState extends State<SearchSHGPage> {
  TextEditingController shgID = TextEditingController();
  Map? data = {};
  bool isLoading = true;
  searchshg(String shgid) async {
    checkInternetConnection().then((value) async {
      if (value == true) {
        data = await getSHGData(shgid);

        print(data);
        if (data == null) {
          SnackBar snackBar =
              SnackBar(content: Text('No SHG found with this ID'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          isLoading = true;
          setState(() {});
        } else {
          isLoading = false;
          setState(() {});
        }
      } else {
        SnackBar snackBar = SnackBar(content: Text('No Internet Connection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search SHG',
            style: TextStyle(fontSize: 24),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.arrow_back),
          //     onPressed: () async {
          //       Navigator.pop(context);
          //     },
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    margin: EdgeInsets.all(10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: shgID,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "SHG ID cannot be empty";
                        }
                        if (int.tryParse(value) == null) {
                          return "SHG ID must be a number";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'SHG ID',
                        labelStyle:
                            TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => searchshg(shgID.text.toString()),
                    icon: Icon(Icons.search),
                    color: Colors.black,
                  ),
                ],
              ),
              Container(
                child: isLoading
                    ? Center(
                        child: Text("Enter SHG ID to search",
                            style:
                                TextStyle(color: Colors.black, fontSize: 24)),
                      )
                    : Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15),
                          Container(
                            height: 400,
                            // width: 150,
                            child: Image.memory(base64Decode(data!['photo64'])),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'SHG ID: ' + data!['shgid'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'NAME: ' + data!['name'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'AGE: ' + data!['age'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'SHG NAME: ' + data!['shgname'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'AADHAR NUMBER: ' +
                                data!['aadharnumber'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'MONTHLY INCOME: ' +
                                data!['monthlyincome'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'BANK NAME: ' + data!['bankname'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'BANK ACCOUNT NUMBER: ' +
                                data!['bankaccountnumber'].toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
              )
              // Text(
              //   'Name: ' + data['name'].toString(),
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 18,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
            ],
          ),
        ));
  }
}
