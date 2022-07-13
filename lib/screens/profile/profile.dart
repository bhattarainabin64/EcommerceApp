import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:najikkopasal/model/user.dart';

import 'package:najikkopasal/screens/profile/edit_profile.dart';
import 'package:najikkopasal/screens/sign_in/sign_in_screen.dart';
import 'package:najikkopasal/widget/profile_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static String routeName = '/profile';
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? name;
  String? email;
  String? image;

  Future preferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getString('profile');

    Map<String, dynamic> encodedData =
        jsonDecode(sharedPreferences.getString('profile')!);
    User user = User.fromJson(encodedData);
    setState(() {
      name = user.name;
      email = user.email;
      image = user.image;
    });
  }

  @override
  void initState() {
    super.initState();
    preferences();
  }

  @override
  Widget build(BuildContext context) {
    void logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('profile');
      Navigator.pushNamed(context, SignInScreen.routeName);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 208, 39, 39)),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          // future builder class

          child: Container(
            padding: const EdgeInsets.all(16),
            height: size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    backgroundImage: NetworkImage(
                      image.toString(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        name.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(.9),
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      const SizedBox(
                          height: 24,
                          child: Icon(
                            Icons.verified,
                            color: Colors.green,
                          )),
                    ],
                  ),
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        icon: Icons.person,
                        title: 'Edit Profile',
                        onPressed: () {
                          Navigator.pushNamed(
                              context, EditProfilePage.routeName);
                        },
                      ),
                      ProfileWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                        onPressed: () {},
                      ),
                      ProfileWidget(
                        icon: Icons.history,
                        title: 'Share',
                        onPressed: () {},
                      ),
                      ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onPressed: () {
                          logout();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
