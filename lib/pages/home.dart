import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/pages/cam.dart';
import 'package:vikas/pages/delete.dart';
import 'package:vikas/pages/login.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/pages/detail_user.dart';
import 'package:vikas/pages/edit_user.dart';
import 'package:vikas/pages/search.dart';
import 'package:vikas/server/api.dart';
import 'package:vikas/widgets/card_widget.dart';

class VikassPage extends StatefulWidget {
  @override
  _VikassPageState createState() => _VikassPageState();
}

class _VikassPageState extends State<VikassPage> {
  late List<Vikas> vikass;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshVikass();
  }

  @override
  void dispose() {
    VikassDatabase.instance.close();

    super.dispose();
  }

  Future refreshVikass() async {
    setState(() => isLoading = true);

    this.vikass = await VikassDatabase.instance.readAllVikass();
    // var abc = vikass.toSet().toList();
    print(jsonEncode(vikass));
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          // title: Text(
          //   'Home',
          //   style: TextStyle(fontSize: 24),
          // ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchSHGPage()),
                    );

                    refreshVikass();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.upload,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await checkInternetConnection().then((value) {
                      if (value == true) {
                        // uploadUserData(vikas.toJson());
                        VikassDatabase.instance.readAllVikass().then((value) {
                          for (var vikas in value) {
                            uploadUserData(vikas.toJson());
                            VikassDatabase.instance.delete(vikas.id!.toInt());
                            setState(() {
                              refreshVikass();
                        
                            });
                            // deleteUserData(vikas.id);
                            print(vikas.id);
                          }
                        });
                    
                        // VikassDatabase.instance.delete(widget.vikas.id!.toInt());
                        SnackBar snackBar = SnackBar(
                            content: Text('Data Uploaded Successfully'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {
                          Future.delayed(Duration(seconds: 1));

                          refreshVikass();
                        });
                      } else {
                        SnackBar snackBar =
                            SnackBar(content: Text('No Internet Connection'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() {});
                      }
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.exit_to_app),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    await deleteDatabase('vikass.db');
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                ),
              ],
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade900,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text('Add New User', style: TextStyle(fontSize: 15)),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddEditVikasPage()),
                  );

                  refreshVikass();
                },
              ),
              ListTile(
                title: Text('Search User', style: TextStyle(fontSize: 15)),
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchSHGPage()),
                  );

                  refreshVikass();
                },
              ),
              ListTile(
                  title: Text('Delete User', style: TextStyle(fontSize: 15)),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => DeleteSHGPage()),
                    );
                    refreshVikass();
                  }),
              ListTile(
                  title: Text('Upload Documents For Verification',
                      style: TextStyle(fontSize: 15)),
                  onTap: () async {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => CamPage(
                                title: " Cam",
                              )),
                    );
                    refreshVikass();
                  }),
              ListTile(
                title: Text('Logout', style: TextStyle(fontSize: 15)),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  deleteDatabase('vikass.db');
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : vikass.isEmpty
                  ? Text(
                      'No SHGs found',
                      style: TextStyle(color: Colors.black, fontSize: 24),
                    )
                  : buildVikass(),
        ),
        // Column(
        // children: [
        // SizedBox(
        //   width: double.infinity,
        //   child: ElevatedButton.icon(
        //       onPressed: () async {
        //         await Navigator.of(context).push(
        //           MaterialPageRoute(builder: (context) => SearchSHGPage()),
        //         );

        //         refreshVikass();
        //       },
        //       style: ElevatedButton.styleFrom(
        //         primary: Colors.green,
        //         onPrimary: Colors.white,
        //         shadowColor: Colors.greenAccent,
        //         elevation: 3,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(32.0)),
        //       ),
        //       icon: Icon(Icons.search),
        //       label: Text("Find SHG ")),
        // ),
        // Center(
        //   child: isLoading
        //       ? CircularProgressIndicator()
        //       : vikass.isEmpty
        //           ? Text(
        //               'No SHGs found',
        //               style: TextStyle(color: Colors.white, fontSize: 24),
        //             )
        //           : buildVikass(),
        // ),
        // ],
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditVikasPage()),
            );

            refreshVikass();
          },
        ),
      );

  Widget buildVikass() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: vikass.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 1,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final vikas = vikass[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VikasDetailPage(vikasId: vikas.id!),
              ));

              refreshVikass();
            },
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  VikasCardWidget(vikas: vikas, index: index),
                  Divider(
                    color: Colors.black,
                  ),
                ]),
          );
        },
      );
}
