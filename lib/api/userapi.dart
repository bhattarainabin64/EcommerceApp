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
    bool isLogin = false;
    Response response;
    var url = baseUrl + registerUrl;
    if (kDebugMode) {
      print("aayo");
    }
    var dio = HttpServices().getDioInstance();
    try {
      response = await dio.post(
        url,
        data: user.toJson(),
      );
      if (response.statusCode == 201) {
        return true;
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        var response = e.response!.data.toString();
        Fluttertoast.showToast(
            msg: "${response}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_LEFT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Color.fromARGB(255, 205, 22, 22),
            fontSize: 30.0);
      }
    }
    return isLogin;
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
