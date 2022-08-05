import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'formpage.dart';
import 'login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
               prefs.clear();
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FormPage())),
                child: Card(
                  elevation: 0.5,
                  color: Colors.lightBlue,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'Add New User',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}