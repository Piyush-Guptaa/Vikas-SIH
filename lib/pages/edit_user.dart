import 'package:flutter/material.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/server/api.dart';
import 'package:vikas/widgets/form_widget.dart';

class AddEditVikasPage extends StatefulWidget {
  final Vikas? vikas;

  const AddEditVikasPage({
    Key? key,
    this.vikas,
  }) : super(key: key);
  @override
  _AddEditVikasPageState createState() => _AddEditVikasPageState();
}

class _AddEditVikasPageState extends State<AddEditVikasPage> {
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String age;
  late String shgname;
  late String aadharnumber;
  late String monthlyincome;
  late String bankname;
  late String bankaccountnumber;
  late String shgid;

  @override
  void initState() {
    super.initState();
    name = widget.vikas?.name ?? '';
    age = widget.vikas?.age ?? '';

    shgname = widget.vikas?.shgname ?? '';
    aadharnumber = widget.vikas?.aadharnumber ?? '';
    monthlyincome = widget.vikas?.monthlyincome ?? '';
    bankname = widget.vikas?.bankname ?? '';
    bankaccountnumber = widget.vikas?.bankaccountnumber ?? '';
    shgid = widget.vikas?.shgid ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: VikasFormWidget(
            name: name,
            age: age,
            shgname: shgname,
            aadharnumber: aadharnumber,
            monthlyincome: monthlyincome,
            bankname: bankname,
            bankaccountnumber: bankaccountnumber,
            shgid: shgid,
            onChangedName: (name) => setState(() => this.name = name),
            onChangedAge: (age) => setState(() => this.age = age),
            onChangedShgname: (shgname) =>
                setState(() => this.shgname = shgname),
            onChangedAadharnumber: (aadharnumber) =>
                setState(() => this.aadharnumber = aadharnumber),
            onChangedMonthlyincome: (monthlyincome) =>
                setState(() => this.monthlyincome = monthlyincome),
            onChangedBankname: (bankname) =>
                setState(() => this.bankname = bankname),
            onChangedBankaccountnumber: (bankaccountnumber) =>
                setState(() => this.bankaccountnumber = bankaccountnumber),
            onChangedShgid: (shgid) => setState(() => this.shgid = shgid),
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = name.isNotEmpty &&
        age.isNotEmpty &&
        shgname.isNotEmpty &&
        aadharnumber.isNotEmpty &&
        monthlyincome.isNotEmpty &&
        bankname.isNotEmpty &&
        bankaccountnumber.isNotEmpty &&
        shgid.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? Colors.green : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateVikas,
        child: Text('Upload'),
      ),
    );
  }

  void addOrUpdateVikas() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.vikas != null;

      if (isUpdating) {
        await updateVikas();
      } else {
        await addVikas();
      }
      Navigator.of(context).pop();
    }
  }

  Future updateVikas() async {
    final vikas = widget.vikas!.copy(
      name: name,
      age: age,
      shgname: shgname,
      aadharnumber: aadharnumber,
      monthlyincome: monthlyincome,
      bankname: bankname,
      bankaccountnumber: bankaccountnumber,
      shgid: shgid,
    );
    await VikassDatabase.instance.update(vikas);
  }

  Future addVikas() async {
    final vikas = Vikas(
      name: name,
      age: age,
      shgname: shgname,
      aadharnumber: aadharnumber,
      monthlyincome: monthlyincome,
      bankname: bankname,
      bankaccountnumber: bankaccountnumber,
      shgid: shgid,
      createdTime: DateTime.now(),
    );
    print(vikas.toJson());
    await checkInternetConnection().then((value) {
      if (value == true) {
        uploadUserData(vikas.toJson());
        SnackBar snackBar =
            SnackBar(content: Text('Data Uploaded Successfully'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        VikassDatabase.instance.create(vikas);
        SnackBar snackBar = SnackBar(content: Text('No Internet Connection'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
