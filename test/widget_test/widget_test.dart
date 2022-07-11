import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:najikkopasal/screens/login_success/login_success_screen.dart';
import 'package:najikkopasal/screens/splash/components/body.dart';


void main() {
  testWidgets(" title widget testing in SigninSuccessScreen",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: LoginSuccessScreen(),
    ));
    Finder title = find.text("Login Success");
    await tester.pumpAndSettle();
    expect(title, findsOneWidget);
  });
   testWidgets("testing the widgets of button", (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Body(),
    ));
    Finder ElevatedButton = find.text("Continue");
   
  });



  



}
