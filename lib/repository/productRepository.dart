import 'package:najikkopasal/api/productapi.dart';
import 'package:najikkopasal/response/product_response.dart';

class ProductRepository {
  Future<ProductResponse?> getproducts({String? categories}) async {
    return ProductAPI().getproduct(categories: categories);
  }
  
   Future<bool> givereview(String productId, String comment, int rating) {
    return ProductAPI().giveproductreview(productId, comment, rating);
  }

}
 