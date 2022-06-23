import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wear/wear.dart';

class WareosHome extends StatefulWidget {

  WareosHome({Key? key}) : super(key: key);

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
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _firstController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          labelText: 'username',
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _secondController,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          labelText: 'password',
                        ),
                      ),
                      SizedBox(
                        width: 90,
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
                            child: const Text("add")),
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
