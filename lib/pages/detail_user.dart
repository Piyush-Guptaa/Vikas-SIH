import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/pages/edit_user.dart';
import 'package:vikas/server/api.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

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

  // Future<void> initializeService() async {
  //   final service = FlutterBackgroundService();
  //   await service.configure(
  //     androidConfiguration: AndroidConfiguration(
  //       // this will be executed when app is in foreground or background in separated isolate
  //       onStart: onStart,

  //       // auto start service
  //       autoStart: true,
  //       isForegroundMode: true,
  //     ),
  //     iosConfiguration: IosConfiguration(
  //       // auto start service
  //       autoStart: true,

  //       // this will be executed when app is in foreground in separated isolate
  //       onForeground: onStart,

  //       // you have to enable background fetch capability on xcode project
  //       onBackground: onIosBackground,
  //     ),
  //   );
  //   service.startService();
  // }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton(), uploadButton()],
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
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      DateFormat.yMMMd().format(vikas.createdTime),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'AGE: ' + vikas.age.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'SHG NAME: ' + vikas.shgname,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'AADHAR NUMBER: ' + vikas.aadharnumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'MONTHLY INCOME: ' + vikas.monthlyincome,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'BANK NAME: ' + vikas.bankname,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'BANK ACCOUNT NUMBER: ' + vikas.bankaccountnumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'SHG ID: ' + vikas.shgid,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
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
  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await VikassDatabase.instance.delete(widget.vikasId);

          Navigator.of(context).pop();
        },
      );
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
              // initializeService();
            }
          });

          Navigator.of(context).pop();
        },
      );
}
