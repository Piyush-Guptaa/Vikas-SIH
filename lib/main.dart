import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vikas/pages/home.dart';
import 'pages/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool _logout = prefs.containsKey('id');
  print(_logout);

  runApp(MyApp(logout: _logout));
}

class MyApp extends StatelessWidget {
  final bool logout;
  const MyApp({Key? key, required this.logout}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'VIKAS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
          ),
          drawerTheme: DrawerThemeData(
            backgroundColor: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: logout ? VikassPage() : const Login());
  }
}
