import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/model/profile_model.dart';

// import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/repository/userRepository.dart';
import 'package:najikkopasal/response/profile_response.dart';
import 'package:najikkopasal/screens/profile/change_password.dart';

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
  // String? name;
  // String? email;
  // String? image;
  // Profile profile = Profile();

  // Future preferences() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var data = sharedPreferences.getString('profile');

  //   Map<String, dynamic> encodedData =
  //       jsonDecode(sharedPreferences.getString('profile')!);
  //   User user = User.fromJson(encodedData);
  //   setState(() {
  //     name = user.name;
  //     email = user.email;
  //     image = user.image;
  //   });
  // }

  // @override
  // void initState()  {
  //   super.initState();
  //   UserRepository().getprofile();

  //   // get data from user
  // }

  @override
  Widget build(BuildContext context) {
    void logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');

      Navigator.pushNamed(context, SignInScreen.routeName);
    }

    void _showAlertDialog(BuildContext context) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Alert'),
          content: const Text('Are you sure you want to logout?'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () async {
                logout();
              },
              child: const Text('Yes'),
            )
          ],
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            // use future builder to get data from server

            child: FutureBuilder<ProfileResponse?>(
                future: UserRepository()
                    .getprofile(), // a previously-obtained Future<String> or null, if the once-obtained Future is still active
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      Profile? profileResponse = snapshot.data!.user;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 60,
                              backgroundImage: NetworkImage(
                                profileResponse!.image!.url.toString(),
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
                                  profileResponse.name.toString(),
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
                            profileResponse.email.toString(),
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
                                        context, EditProfilePage.routeName,
                                        arguments: {
                                          "name": profileResponse.name,
                                          "email": profileResponse.email,
                                          "image": profileResponse.image!.url
                                        });
                                  },
                                ),
                                ProfileWidget(
                                  icon: Icons.settings,
                                  title: 'change password',
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, ChangePassword.routeName);
                                  },
                                ),
                                ProfileWidget(
                                  icon: Icons.history,
                                  title: 'Order History',
                                  onPressed: () {},
                                ),
                                ProfileWidget(
                                  icon: Icons.logout,
                                  title: 'Log Out',
                                  onPressed: () {
                                    _showAlertDialog(context);
                                    // logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return const Center(
                      child: CupertinoActivityIndicator(
                    animating: true,
                  ));
                })),
      ),
    );
  }
}
