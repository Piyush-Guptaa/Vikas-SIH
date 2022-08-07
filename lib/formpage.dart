import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vikas/api.dart';
import 'package:vikas/file.dart';

import 'home.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  final List<String> categoryItems = [
    'General',
    'SC',
    'ST',
    'OBC',
  ];
  String? selectedGender;
  String? selectedCategory;
  final name = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  final shgname = TextEditingController();
  final aadharnumber = TextEditingController();
  final category = TextEditingController();
  final monthlyincome = TextEditingController();
  final bankname = TextEditingController();
  final bankaccountnumber = TextEditingController();
  final shgid = TextEditingController();
  
  void validateAndSave() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      uploadUserData(
          name.text,
          age.text,
          selectedGender.toString(),
          shgname.text,
          aadharnumber.text,
          selectedCategory.toString(),
          monthlyincome.text,
          bankname.text,
          bankaccountnumber.text,
          shgid.text);
      Navigator.pop(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
        ),
        title: const Text('Enter your details'),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: name,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: age,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Age',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextFormField Button become clickable, and also the dropdown menu open under The whole TextFormField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'Select Your Gender',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: genderItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return "Gender cannot be empty";
                  }

                  return null;
                },
                onChanged: (value) {
                  selectedGender = value.toString();
                },
                onSaved: (value) {
                  selectedGender = value.toString();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: shgname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "SHG Name cannot be empty";
                  }
                  if (value.length < 3) {
                    return "SHG Name must be atleast 3 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'SHG NAME',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: aadharnumber,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Aadhar Number cannot be empty";
                  }
                  if (value.length < 12) {
                    return "Enter valid Aadhar Number 12 digits";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'AADHAR NUMBER',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButtonFormField2(
                decoration: InputDecoration(
                  //Add isDense true and zero Padding.
                  //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextFormField Button become clickable, and also the dropdown menu open under The whole TextFormField Button.
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //Add more decoration as you want here
                  //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                ),
                isExpanded: true,
                hint: const Text(
                  'CATEGORY',
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 60,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                items: categoryItems
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return "Category cannot be empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  selectedCategory = value.toString();
                },
                onSaved: (value) {
                  selectedCategory = value.toString();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: monthlyincome,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'MONTHLY INCOME',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: bankname,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bank Name cannot be empty";
                  }
                  if (value.length < 3) {
                    return "Bank Name must be atleast 3 characters";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'BANK NAME',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: bankaccountnumber,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Bank Account Number cannot be empty";
                  }
                  if (value.length < 10) {
                    return "Enter valid Bank Account Number 10 digits";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'BANK ACCOUNT NUMBER',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: shgid,
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)),
                  labelText: 'SHG ID',
                  labelStyle: TextStyle(fontSize: 14),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: validateAndSave,
            ),
          ],
        ),
      )),
    );
  }
}
