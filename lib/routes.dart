import 'package:flutter/material.dart';
import 'package:najikkopasal/screens/forget_password/forget_password_screen.dart';
import 'package:najikkopasal/screens/home/components/botton-nav.dart';
import 'package:najikkopasal/screens/home/components/nav.dart';

import 'package:najikkopasal/screens/login_success/login_success_screen.dart';
import 'package:najikkopasal/screens/muti_step_form/multi_step.dart';
import 'package:najikkopasal/screens/product_details/product_details.dart';
import 'package:najikkopasal/screens/profile/change_password.dart';
import 'package:najikkopasal/screens/profile/edit_profile.dart';
import 'package:najikkopasal/screens/profile/profile.dart';
import 'package:najikkopasal/screens/profile/test.dart';
import 'package:najikkopasal/screens/review/reviewfrontend.dart';
import 'package:najikkopasal/screens/sign_in/sign_in_screen.dart';
import 'package:najikkopasal/screens/sign_up/sign_up_screen.dart';
import 'package:najikkopasal/screens/splash/splash_screen.dart';
import 'package:najikkopasal/screens/ware/wareogin.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
  // LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  // HomePage.routeName: (context) => const HomePage(),
  BottomNavBar.routeName: (context) => const BottomNavBar(),
  Navbar.routeName: (context) => Navbar(),
  ProductDetails.routeName: (context) => const ProductDetails(),
  ReviewUIScreen.routeName: (context) => const ReviewUIScreen(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  EditProfilePage.routeName: (context) => EditProfilePage(),
  // TestScreen.routeName: (context) => TestScreen(),
  ChangePassword.routeName: (context) => ChangePassword(),
  MultiStepForm.routeName: (context) => const MultiStepForm(),
  WareosHome.routeName: (context) => const WareosHome(),
  
};
