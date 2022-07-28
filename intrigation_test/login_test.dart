import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';
import 'package:najikkopasal/screens/profile/profile.dart';
import 'package:najikkopasal/screens/sign_in/sign_in_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("testing the widgets", (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      routes: {
        '/profile': (context) => const ProfilePage(),
      },
      home: SignInScreen(),
    ));
    Finder first_number = find.byKey(const ValueKey("email"));
    await tester.enterText(first_number, "baba@gmail.com");
    Finder second_number = find.byKey(const ValueKey("password"));
    await tester.enterText(second_number, "baba1412914@");
    Finder btnAdd = find.byKey(const ValueKey("Login"));
    await tester.tap(btnAdd);
    await tester.pumpAndSettle();
    // find singleChildScrollView
    Finder scrollView = find.byType(SingleChildScrollView);
    expect(scrollView, findsOneWidget);
  });
}
