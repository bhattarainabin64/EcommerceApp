import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/components/form_error.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/screens/forget_password/forget_password_screen.dart';

import 'package:najikkopasal/screens/login_success/login_success_screen.dart';

import '../../../components/custom_suffix-icon.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../home/components/botton-nav.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  _navigateToScreen(bool isLogin) {
    if (isLogin) {
      Navigator.pushNamed(context, BottomNavBar.routeName);
    } else {
      MotionToast.error(
        description: const Text("Either username or password is not correct"),
      ).show(context); // MotionToast.error

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
      MotionToast.error(
        description: Text("Error:${e.toString()}"),
      ).show(context); // MotionToast.error

    }
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;

  final List<String> erros = [];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          Row(
            children: [
              Checkbox(
                  activeColor: kPrimaryColor,
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgetPasswordScreen.routeName),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(erros: erros),
          SizedBox(
            height: getProportionateScreenHeight(26),
          ),
          DefaultButton(
            text: "Login",
            press: () {
              _login();
              // if (_formKey.currentState!.validate()) {
              //   _formKey.currentState!.save();

              // }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && erros.contains(kPassNullError)) {
          setState(() {
            erros.remove(kPassNullError);
          });
        } else if (value.length >= 8 && erros.contains(kShortPassError)) {
          setState(() {
            erros.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !erros.contains(kPassNullError)) {
          setState(() {
            erros.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !erros.contains(kShortPassError)) {
          setState(() {
            erros.add(kShortPassError);
          });
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
        labelText: "Password",
        hintText: "Enter Your Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty && erros.contains(kEmailNullError)) {
          setState(() {
            erros.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            erros.contains(kInvalidEmailError)) {
          setState(() {
            erros.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !erros.contains(kEmailNullError)) {
          setState(() {
            erros.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !erros.contains(kInvalidEmailError)) {
          setState(() {
            erros.add(kInvalidEmailError);
          });
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Email",
        hintText: "Enter Your Email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
