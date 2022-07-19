import 'dart:math';

import 'package:flutter/material.dart';
import 'package:najikkopasal/model/cart_model.dart';

import 'package:najikkopasal/repository/productRepository.dart';
import 'package:najikkopasal/screens/cart/db_helper.dart';

import 'package:najikkopasal/screens/product_details/body.dart';
import 'package:provider/provider.dart';

import 'package:rating_dialog/rating_dialog.dart';

import '../cart/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = '/product_details';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  DBHelper? dbHelper = DBHelper();
  String? productId = "";
  double? rating;
  int? id2 = 0;

  //initiliaze above variables usinh getx

  String? commnet1 = "";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void showRating() {
      showDialog(
          context: context,
          barrierDismissible:
              true, // set to false if you want to force a rating
          builder: (context) {
            return RatingDialog(
                initialRating: 1.0,
                title: const Text(
                  'Give your Rating and Commnet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // encourage your user to leave a high rating?
                message: const Text(
                  'Tap a star to set your rating.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                // your app's logo?
                image: const Icon(
                  Icons.star,
                  size: 90,
                  color: Colors.yellow,
                  //
                ),
                submitButtonText: 'Submit',
                onCancelled: () => print('cancelled'),
                onSubmitted: (response) async {
                  setState(() {
                    rating = response.rating;
                  });
                  ProductRepository review = ProductRepository();

                  bool isReview = await review.givereview(
                      productId!, response.comment, rating!.toInt());
                  // product
                  print("sdaksjdhaksjdhskajdhjksadhkasdkjasdskajjkasdj");
                });
          });
    }

    final productData = ModalRoute.of(context)!.settings.arguments as Map;
    final id = productData['id'];
    // generate random int

    // BigInt bin = BigInt.parse(id, radix: 16);
    // //convrt bin to small int
    // int id3 = bin.toInt();
    final random = Random();
    int id3 = random.nextInt(1500);

    // final id2 = random.nextInt(id3);
    // print(id2);

    final name = productData['name'];
    final description = productData['description'];
    final price = productData['price'];
    final ratings = productData['ratings'];
    final image = productData['image'];
    final reviews = productData['reviews'];

    print(productId);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(179, 255, 255, 255),
          title: Row(
            children: const [
              Text(
                "Product Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(Icons.favorite)
            ],
          ),
        ),
        bottomNavigationBar: Material(
          elevation: 1,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: IconButton(
                    icon: Icon(Icons.chat, color: Colors.black),
                    onPressed: () {
                      setState(() {
                        showRating();
                        productId = id;
                      });
                    }),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 1),
                  height: 52.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: ElevatedButton(
                      child: const Text("Add to Cart",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      onPressed: () {
                        dbHelper!
                            .insert(Cart(
                                id: id3,
                                productId: id.toString(),
                                productName: name.toString(),
                                initialPrice: price,
                                productPrice: price,
                                quantity: 1,
                                unitTag: "₹",
                                image: image.toString()))
                            .then((value) {
                          cart.addTotalPrice(double.parse(price.toString()));
                          cart.addCounter();

                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Product is added to cart'),
                            duration: Duration(seconds: 1),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }).onError((error, stackTrace) {
                          print("error" + error.toString());
                          final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Product is already added in cart'),
                              duration: Duration(seconds: 1));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
        body: Body(
            id: id,
            price: price,
            ratings: ratings,
            description: description,
            name: name,
            image: image,
            reviews: reviews));
  }
}
