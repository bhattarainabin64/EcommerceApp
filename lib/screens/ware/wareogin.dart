import 'package:flutter/material.dart';

import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/ware/adminproduct.dart';
import 'package:najikkopasal/screens/ware/dashbaord.dart';
import 'package:wear/wear.dart';

class WareosHome extends StatefulWidget {
  static String routeName = '/wareos';

  const WareosHome({Key? key}) : super(key: key);

  @override
  State<WareosHome> createState() => _WareosHomeState();
}

class _WareosHomeState extends State<WareosHome> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushNamed(context, WareDashboard.routeName);
    }
  }

  _login() async {
    try {
      UserRepository userRepository = UserRepository();

      bool isLogin = await userRepository.login(
        _emailController.text,
        _passwordController.text,
      );

      if (isLogin) {
        _navigateToScreen(true);
      } else {
        _navigateToScreen(false);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
      return AmbientMode(
        builder: (context, mode, child) {
          return Scaffold(
              body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // add text  with name najikkopasal
                      Text(
                        'Najikkopasal',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      SizedBox(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 10),
                            ),
                            style: TextStyle(fontSize: 10),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              // validate email
                              if (!RegExp(
                                      r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 10),
                            ),
                            style: const TextStyle(fontSize: 10),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: ElevatedButton(
                              // add color in button
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                primary: kPrimaryColor,
                              ),
                              onPressed: () {
                                _login();
                                // add code to login
                              },
                              child: const Text("Login")),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      );
    });
  }
}
