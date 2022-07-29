import 'package:flutter/material.dart';
import 'package:najikkopasal/screens/sign_up/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String routeName = '/signUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true),
        body: Body());
  }
}
