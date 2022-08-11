import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Age',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'SHG Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          ),
          onChanged: onChangedShgname,
        ),
      );
  Widget buildAadharnumber() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: aadharnumber,
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Aadhar Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Monthly Income',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Bank Name',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          ),
          onChanged: onChangedBankname,
        ),
      );
  Widget buildBankaccountnumber() => Container(
        margin: EdgeInsets.all(10),
        child: TextFormField(
          initialValue: bankaccountnumber,
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'Bank Account Number',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            labelText: 'SHG ID',
            labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          ),
          onChanged: onChangedShgid,
        ),
      );
}
