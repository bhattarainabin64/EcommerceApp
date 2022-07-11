import 'package:flutter_test/flutter_test.dart';
import 'package:najikkopasal/repository/productRepository.dart';

void main() {
  test("user product review test", () async {
    bool expectedResult = true;

    String productId = "62617c0a932610c87b50fe60";
    String comment = "baba@gmail.com";
    int rating = 2;

    bool actial = await ProductRepository().givereview(productId, comment, rating);

    expect(actial, expectedResult);
  });
}
