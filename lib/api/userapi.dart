import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/login.dart';
import 'package:najikkopasal/response/profile_response.dart';
import 'package:najikkopasal/utils/sessionmanager.dart';
// import 'package:najikkopasal/utils/sessionmanager.dart';
import 'package:najikkopasal/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserAPI {
  
  Future<bool> registerUser(User user) async {
    try {
      var url = baseUrl + registerUrl;
      var dio = HttpServices().getDioInstance();

      var formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "image": user.image
      });

      var response = await dio.post(url, data: formData);
      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      throw Exception(e);
    }

    return false;
  }

// User login Function
  Future<bool> login(String email, String password) async {
    bool isLogin = false;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var url = baseUrl + loginUrl;

      var dio = HttpServices().getDioInstance();

      var response =
          await dio.post(url, data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        String userdata = jsonEncode(response.data['user']);
        Map<String, dynamic> userdat = jsonDecode(userdata.toString());
        User user = User(
          name: userdat['name'],
          email: userdat['email'],
          image: userdat['image']['url'],
        );
        String profile = jsonEncode(user);
        sharedPreferences.setString('profile', profile);

        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        token = loginResponse.token;

        sharedPreferences.setString('token', '$token');
        isLogin = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isLogin;
  }

// get user profile
  Future<ProfileResponse?> getuser() async {
    Future.delayed(const Duration(seconds: 2), () {});
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');
    ProfileResponse? profileResponse;
    Response? response;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + getuserUrl;

      response = await dio.get(url,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        profileResponse = ProfileResponse.fromJson(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
    return profileResponse;
  }

// update profile Function
  Future<bool> updateprofile(String? name, String? email, String? image) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');

    bool isprofileUpdated = false;

    try {
      var url = baseUrl + updateprofileUrl;

      var dio = HttpServices().getDioInstance();
      var formData =
          FormData.fromMap({"name": name, "email": email, "avatar": image});

      var response = await dio.put(url,
          data: formData,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        print("Profile  update bhyaooooooooooooooooooooo");
      
        isprofileUpdated = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isprofileUpdated;
  }
}
// create the class which take user object and convert to JsonEncoder


