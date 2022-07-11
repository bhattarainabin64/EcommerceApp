import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/product_response.dart';
import 'package:najikkopasal/utils/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductAPI {
  // take optional parameter for getproduct function

  Future<ProductResponse?> getproduct({String? categories}) async {
    Future.delayed(const Duration(seconds: 2), () {});
    ProductResponse? productResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + '${productUrl}/?keyword=${categories}';
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.data);
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }

// give product review
  Future<bool> giveproductreview(
      String productId, String comment, int rating) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userlogintoken = sharedPreferences.getString('token');

    bool isReview = false;

    try {
      var url = baseUrl + reviewUrl;

      var dio = HttpServices().getDioInstance();

      var response = await dio.put(url,
          data: {"productId": productId, "comment": comment, "rating": rating},
          options: Options(headers: {
            HttpHeaders.authorizationHeader: "Bearer $userlogintoken"
          }));

      if (response.statusCode == 200) {
        isReview = true;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return isReview;
  }
}
