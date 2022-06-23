import 'package:dio/dio.dart';
import 'package:najikkopasal/api/httpServices.dart';
import 'package:najikkopasal/response/product_response.dart';
import 'package:najikkopasal/utils/url.dart';

class ProductAPI {
  Future<ProductResponse?> getproduct() async {
    Future.delayed(const Duration(seconds: 2), () {});
    ProductResponse? productResponse;
    try {
      var dio = HttpServices().getDioInstance();
      var url = baseUrl + productUrl;
      Response response = await dio.get(url);
      // print(response);
      if (response.statusCode == 200) {
        productResponse = ProductResponse.fromJson(response.data);
        var a = 1;
      }
    } catch (e) {
      throw Exception(e);
    }
    return productResponse;
  }
}
