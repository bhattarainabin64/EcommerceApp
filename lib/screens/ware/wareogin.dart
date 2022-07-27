import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wear/wear.dart';

class WareosHome extends StatefulWidget {
  static String routeName = '/wareos';

  const WareosHome({Key? key}) : super(key: key);

  @override
  State<WareosHome> createState() => _WareosHomeState();
}

class _WareosHomeState extends State<WareosHome> {
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();
  int result = 0;

  _add() {
    int first = int.parse(_firstController.text);
    int second = int.parse(_secondController.text);
    setState(() {
      result = first + second;
    });
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
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _firstController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'username',
                            hintStyle: TextStyle(fontSize: 10),
                            labelText: 'Username',
                            labelStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: TextFormField(
                          controller: _secondController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Password',
                            hintStyle: TextStyle(fontSize: 10),
                            labelText: ' Password',
                            labelStyle: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () {
                              _add();
                              Fluttertoast.showToast(
                                  msg: 'Sum is $result',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.transparent,
                                  textColor: Colors.black);
                            },
                            child: const Text("login")),
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
