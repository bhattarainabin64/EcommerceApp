import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:najikkopasal/constants.dart';

class SingleProductWidget extends StatefulWidget {
  final String? productImage;
  final String? productName;
  final String? productModel;
  final String? productPrice;
  final String? productOldPrice;
  final double? productRating;

  SingleProductWidget(
      {this.productImage,
      this.productName,
      this.productModel,
      this.productPrice,
      this.productOldPrice,
      this.productRating});
  @override
  _SingleProductWidgetState createState() => _SingleProductWidgetState();
}

class _SingleProductWidgetState extends State<SingleProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 10, 17, 2),
              alignment: Alignment.topRight,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 219, 219, 219),
                borderRadius: BorderRadius.circular(7),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.productImage!,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.productName!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.productModel!,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: widget.productRating!.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 22,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${widget.productPrice}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Icon(
                        Icons.shopping_cart_checkout,
                        color: Color.fromARGB(255, 35, 90, 135),
                      )
                      // ElevatedButton(
                      //     child: const Icon(
                      //       Icons.add,
                      //       color: Colors.white,
                      //     ),
                      //     style: ButtonStyle(
                      //         backgroundColor: MaterialStateProperty.all<Color>(
                      //             Colors.black87),
                      //         shape: MaterialStateProperty.all<
                      //                 RoundedRectangleBorder>(
                      //             RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(30)))),
                      //     onPressed: () {}),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
