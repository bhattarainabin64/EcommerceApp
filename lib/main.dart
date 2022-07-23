import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:najikkopasal/routes.dart';
import 'package:najikkopasal/screens/cart/cart_provider.dart';
import 'package:najikkopasal/screens/splash/splash_screen.dart';
import 'package:najikkopasal/theme.dart';
import 'package:provider/provider.dart';

void main() async{
  await Hive.initFlutter();
  
  AwesomeNotifications().initialize('resource://drawable/luncher', [
    NotificationChannel(
      channelGroupKey: 'basic_channel_group',
      channelKey: 'basic_channel',
      channelName: 'Basic Notifications',
      importance: NotificationImportance.Max,
      ledColor: Colors.amber,
      channelShowBadge: true,
      channelDescription: 'Notification for the basic test of the app',
    ),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: theme(),
            initialRoute: SplashScreen.routeName,
            routes: routes);
      }),
    );
  }
}


// themedata function

