import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/login.dart';
import 'package:najikkopasal/utils/url.dart';

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

  Future<bool> login(String email, String password) async {
    bool isLogin = false;

    try {
      var url = baseUrl + loginUrl;

      var dio = HttpServices().getDioInstance();

      var response =
          await dio.post(url, data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);

        token = loginResponse.token;

        isLogin = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isLogin;
  }
}
