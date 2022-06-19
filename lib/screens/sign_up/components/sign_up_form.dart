import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/size_config.dart';

import '../../../components/custom_suffix-icon.dart';
import '../../../components/form_error.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  _registerUser(User user) async {
    bool isLogin = await UserRepository().registerUser(user);
    if (isLogin) {
      _displayMessage(true);
    } else {
      _displayMessage(false);
    }
  }

  _displayMessage(msg) {
    if (msg) {
      MotionToast.success(description: const Text('success register'))
          .show(context);
    } else {
      MotionToast.warning(description: const Text('error rergister'))
          .show(context);
    }
  }

  String? fullname;
  String? email;
  String? password;
  // String? confirmpassword;

  final List<String> errors = [];

  final _formKey = GlobalKey<FormState>();
  File? img;
  String? base64;

  Future _loadImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = "data:image/png;base64," + base64Encode(bytes);

      if (base64Image != null) {
        setState(() {
          img = File(image.path);
          base64 = base64Image;
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint('Failed to pick Image $e');
    }
  }

  // void addError({String? error}) {
  //   if (error!.contains(error)) {
  //     setState(() {
  //       errors.add(error);
  //     });
  //   }
  // }

  // void removeError({String? error}) {
  //   if (error!.contains(error)) {
  //     setState(() {
  //       errors.remove(error);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Widget bottomSheet() {
      return Container(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            const Text(
              "Choose Register Account photo",
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.camera),
                label: const Text("Camera"),
                onPressed: () {
                  _loadImage(ImageSource.camera);
                },
              ),
              TextButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  _loadImage(ImageSource.gallery);
                },
                label: const Text("Gallery"),
              ),
            ])
          ],
        ),
      );
    }

    Widget imageProfile() {
      return Stack(children: [
        CircleAvatar(
          radius: 50,
          child: ClipOval(
            child: SizedBox(
              width: 100.0,
              height: 100.0,
              child: (img != null)
                  ? Image.file(
                      img!,
                      fit: BoxFit.fill,
                    )
                  : Image.asset(
                      "assets/images/profile.jpg",
                      fit: BoxFit.fill,
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 20.0,
          right: 10.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              size: 25.0,
              color: Color.fromARGB(255, 215, 22, 22),
            ),
          ),
        ),
      ]);
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          imageProfile(),

          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          buildNameFormFild(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          // buildConfirmPasswordFormFiled(),
          FormError(erros: errors),
          SizedBox(height: getProportionateScreenHeight(25)),
          DefaultButton(
            text: "Sign Up",
            press: () {
              if (_formKey.currentState!.validate()) {
                User user = User(
                    name: _nameController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    image: base64
                    );

                _registerUser(user);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      controller: _passwordController,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kPassNullError)) {
          setState(() {
            errors.remove(kPassNullError);
          });
        } else if (value.length >= 8 && errors.contains(kShortPassError)) {
          setState(() {
            errors.remove(kShortPassError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kPassNullError)) {
          setState(() {
            errors.add(kPassNullError);
          });
          return "";
        } else if (value.length < 8 && !errors.contains(kShortPassError)) {
          setState(() {
            errors.add(kShortPassError);
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

  // TextFormField buildConfirmPasswordFormFiled() {
  //   return TextFormField(
  //     obscureText: true,
  //     // onSaved: (newValue) => confirmpassword = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty && errors.contains(kConfirmPassNullError)) {
  //         setState(() {
  //           errors.remove(kConfirmPassNullError);
  //         });
  //       } else if (password == confirmpassword &&
  //           errors.contains(kMatchPassError)) {
  //         setState(() {
  //           errors.remove(kMatchPassError);
  //         });
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty && !errors.contains(kConfirmPassNullError)) {
  //         setState(() {
  //           errors.add(kConfirmPassNullError);
  //         });

  //         confirmpassword = value;
  //         print(value);

  //         return "";
  //       } else if (password != value && !errors.contains(kMatchPassError)) {
  //         setState(() {
  //           errors.add(kMatchPassError);
  //         });
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: const InputDecoration(
  //       suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
  //       labelText: " Confirm Password",
  //       hintText: "Re-Enter Your Password",
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //     ),
  //   );
  // }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: _emailController,
      onSaved: (newValue) => email = newValue,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kEmailNullError)) {
          setState(() {
            errors.remove(kEmailNullError);
          });
        } else if (emailValidatorRegExp.hasMatch(value) &&
            errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.remove(kInvalidEmailError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kEmailNullError)) {
          setState(() {
            errors.add(kEmailNullError);
          });
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value) &&
            !errors.contains(kInvalidEmailError)) {
          setState(() {
            errors.add(kInvalidEmailError);
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

  TextFormField buildNameFormFild() {
    return TextFormField(
      controller: _nameController,
      onSaved: (newValue) => fullname = newValue,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(kNameNullError)) {
          setState(() {
            errors.remove(kNameNullError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty && !errors.contains(kNameNullError)) {
          setState(() {
            errors.add(kNameNullError);
          });
          return "";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
