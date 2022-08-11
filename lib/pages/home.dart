import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:vikas/db/vikas_database.dart';
import 'package:vikas/pages/login.dart';
import 'package:vikas/model/vikas.dart';
import 'package:vikas/pages/detail_user.dart';
import 'package:vikas/pages/edit_user.dart';
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

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: TextStyle(fontSize: 24),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                deleteDatabase('vikass.db');
                await Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : vikass.isEmpty
                  ? Text(
                      'No SHGs found',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildVikass(),
        ),
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
            child: VikasCardWidget(vikas: vikas, index: index),
          );
        },
      );
}
