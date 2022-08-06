import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String id = "";
  bool changeButton = false;
  var pswd;
  final _formKey = GlobalKey<FormState>();

  movetoHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', id);
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
          image: AssetImage("assets/images/v2.jpeg"),
          fit: BoxFit.cover,
        ))),
        Center(
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 32.0),
                      child: Column(
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Enter ID",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelText: "User ID",
                                labelStyle: TextStyle(color: Colors.white)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "User ID cannot be empty";
                              } else if (value == "123456") {
                                pswd = '0';
                                return null;
                              } else if (value == "999999") {
                                pswd = '1';
                                return null;
                              } else {
                                return "User ID is not valid";
                              }
                            },
                            onChanged: (value) {
                              id = value;
                              setState(() {});
                            },
                          ),
                          const SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Enter password",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(color: Colors.white)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password cannot be empty";
                              } else if (value != pswd.toString()) {
                                return "Password is incorrect";
                              } else if (value == pswd.toString()) {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          Material(
                            shadowColor: Colors.white,
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.circular(changeButton ? 50 : 8),
                            child: InkWell(
                              onTap: () => movetoHome(context),
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                width: changeButton ? 50 : 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: changeButton
                                    ? const Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
