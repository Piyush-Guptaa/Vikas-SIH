import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:image_picker/image_picker.dart';

class VikasFormWidget extends StatelessWidget {
  final String? name;
  final String? age;
  final String? shgname;
  final String? aadharnumber;
  final String? monthlyincome;
  final String? bankname;
  final String? bankaccountnumber;
  final String? shgid;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedAge;
  final ValueChanged<String> onChangedShgname;
  final ValueChanged<String> onChangedAadharnumber;
  final ValueChanged<String> onChangedMonthlyincome;
  final ValueChanged<String> onChangedBankname;
  final ValueChanged<String> onChangedBankaccountnumber;
  final ValueChanged<String> onChangedShgid;
  VikasFormWidget({
    Key? key,
    this.name = '',
    this.age = '',
    this.shgname = '',
    this.aadharnumber = '',
    this.monthlyincome = '',
    this.bankname = '',
    this.bankaccountnumber = '',
    this.shgid = '',
    required this.onChangedName,
    required this.onChangedAge,
    required this.onChangedShgname,
    required this.onChangedAadharnumber,
    required this.onChangedMonthlyincome,
    required this.onChangedBankname,
    required this.onChangedBankaccountnumber,
    required this.onChangedShgid,
  }) : super(key: key);
  // File? image;
  // late final imageTemp2;
  // Future pickImage() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);

  //     if (image == null) return;

  //     final imageTemp = File(image.path);

  //     final imageBytes = imageTemp.readAsBytesSync();
  //     imageTemp2 = Base64Encoder().convert(imageBytes);
  //     print(imageTemp2);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              buildAge(),
              buildShgname(),
              buildAadharnumber(),
              buildMonthlyincome(),
              buildBankname(),
              buildBankaccountnumber(),
              buildShgid(),
              // buildImage(),
            ],
          ),
        ),
      );

  Widget buildName() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: name,
          validator: (value) {
            if (value!.isEmpty) {
              return "Name cannot be empty";
            }
            if (value.length < 3) {
              return "Name must be atleast 3 characters";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedName,
        ),
      );
  Widget buildAge() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: age,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Age cannot be empty";
            }
            if (int.tryParse(value) == null) {
              return "Age must be a number";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Age',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedAge,
        ),
      );

  Widget buildShgname() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: shgname,
          validator: (value) {
            if (value!.isEmpty) {
              return "SHG Name cannot be empty";
            }
            if (value.length < 3) {
              return "SHG Name must be atleast 3 characters";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'SHG Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedShgname,
        ),
      );
  Widget buildAadharnumber() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: aadharnumber,
          maxLength: 12,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Aadhar Number cannot be empty";
            }
            if (value.length < 12 || value.length > 12) {
              return "Enter valid Aadhar Number 12 digits";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Aadhar Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedAadharnumber,
        ),
      );
  Widget buildMonthlyincome() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: monthlyincome,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Monthly Income cannot be empty";
            }
            if (int.tryParse(value) == null) {
              return "Monthly Income must be a number";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Monthly Income',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedMonthlyincome,
        ),
      );
  Widget buildBankname() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: bankname,
          validator: (value) {
            if (value!.isEmpty) {
              return "Bank Name cannot be empty";
            }
            if (value.length < 3) {
              return "Bank Name must be atleast 3 characters";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Bank Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedBankname,
        ),
      );
  Widget buildBankaccountnumber() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          maxLength: 10,
          initialValue: bankaccountnumber,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value!.isEmpty) {
              return "Bank Account Number cannot be empty";
            }
            if (value.length < 10 || value.length > 10) {
              return "Enter valid Bank Account Number 10 digits";
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'Bank Account Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedBankaccountnumber,
        ),
      );
  Widget buildShgid() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: shgid,
          keyboardType: TextInputType.number,
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
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            labelText: 'SHG ID',
            labelStyle: TextStyle(fontSize: 14, color: Colors.black),
          ),
          onChanged: onChangedShgid,
        ),
      );
  // Widget buildImage() => MaterialButton(
  //     color: Colors.blue,
  //     child: const Text("Pick Image from Gallery",
  //         style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
  //     onPressed: () {
  //       pickImage();
  //     });
}
