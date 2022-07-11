import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/login.dart';
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
        sharedPreferences.setString('userdata', userdata);

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
}
