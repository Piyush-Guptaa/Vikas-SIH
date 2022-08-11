import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/pages/edit_user.dart';
import 'package:vikas/server/api.dart';

class VikasDetailPage extends StatefulWidget {
  final int vikasId;

  const VikasDetailPage({
    Key? key,
    required this.vikasId,
  }) : super(key: key);

  @override
  _VikasDetailPageState createState() => _VikasDetailPageState();
}

class _VikasDetailPageState extends State<VikasDetailPage> {
  late Vikas vikas;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshVikas();
  }

  Future refreshVikas() async {
    setState(() => isLoading = true);

    this.vikas = await VikassDatabase.instance.readVikas(widget.vikasId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), uploadButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      'NAME: ' + vikas.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(vikas.createdTime),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'AGE: ' + vikas.age.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'SHG NAME: ' + vikas.shgname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'AADHAR NUMBER: ' + vikas.aadharnumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'MONTHLY INCOME: ' + vikas.monthlyincome,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'BANK NAME: ' + vikas.bankname,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'BANK ACCOUNT NUMBER: ' + vikas.bankaccountnumber,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'SHG ID: ' + vikas.shgid,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditVikasPage(vikas: vikas),
        ));

        refreshVikas();
      });

  Widget uploadButton() => IconButton(
        icon: Icon(Icons.upload),
        onPressed: () async {
          await checkInternetConnection().then((value) {
            if (value == true) {
              uploadUserData(vikas.toJson());
              VikassDatabase.instance.delete(widget.vikasId);
              SnackBar snackBar =
                  SnackBar(content: Text('Data Uploaded Successfully'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              SnackBar snackBar =
                  SnackBar(content: Text('No Internet Connection'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          });

          Navigator.of(context).pop();
        },
      );
}
