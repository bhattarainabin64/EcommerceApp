import 'package:najikkopasal/api/productapi.dart';
import 'package:najikkopasal/response/product_response.dart';

class ProductRepository {
  Future<ProductResponse?> getproducts() async {
    return ProductAPI().getproduct();
  }
}
