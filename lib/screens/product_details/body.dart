// ignore_for_file: sized_box_for_whitespace

import 'package:clippy_flutter/arc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:najikkopasal/constants.dart';

import 'package:najikkopasal/model/review.dart';
import 'package:najikkopasal/screens/review/reviewUI.dart';
import 'package:najikkopasal/screens/review/reviewfrontend.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class Body extends StatefulWidget {
  final String? id;
  final int? price;
  final double? ratings;
  final String? description;
  final String? image;
  final String? name;
  final String? date;
  List<Review>? reviews;

  Body(
      {Key? key,
      this.id,
      this.price,
      this.ratings,
      this.description,
      this.reviews,
      this.image,
      this.name,
      this.date})
      : super(
          key: key,
        );

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isMore = false;
  var myFormat = DateFormat('d-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // give alignmet to center

          Container(
            color: Color.fromARGB(255, 255, 255, 255),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Image.network(
                "${widget.image}",
                height: getProportionateScreenHeight(250),
              ),
            ),
          ),

          Arc(
              edge: Edge.TOP,
              arcType: ArcType.CONVEY,
              height: 30,
              child: Container(
                width: double.infinity,
                color: Color.fromARGB(255, 240, 240, 240),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              "${widget.name}",
                              style: TextStyle(
                                  fontSize: getProportionateScreenWidth(20),
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                      // Text("${widget.text}"),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmoothStarRating(
                              starCount: 5,
                              rating: double.parse(widget.ratings.toString()),
                              color: kPrimaryColor,
                              borderColor: kPrimaryColor,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 175, 172, 172)
                                                  .withOpacity(0.1),
                                          offset: Offset(0, 3),
                                          blurRadius: 10,
                                        ),
                                      ]),
                                  child: Icon(
                                    CupertinoIcons.minus,
                                    size: 15,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text("${widget.reviews!.length}"),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Color.fromARGB(255, 175, 172, 172)
                                                  .withOpacity(0.1),
                                          offset: Offset(0, 3),
                                          blurRadius: 10,
                                        ),
                                      ]),
                                  child: Icon(
                                    CupertinoIcons.plus,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹ ${widget.price}",
                              style: TextStyle(
                                fontSize: getProportionateScreenWidth(20),
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),
                            Text("In Stock: True")
                          ],
                        ),
                      ),
                      // description Section
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Description",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(20),
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: ReadMoreText(
                                '${widget.description.toString()}',
                                trimLines: 2,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                trimCollapsedText: 'ViewMore',
                                trimExpandedText: "Show Less",
                                moreStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                                lessStyle: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Review",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: kPrimaryColor,
                                    )),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ReviewUIScreen.routeName,
                                        arguments: {
                                          "reviews": widget.reviews,
                                          "ratings": widget.ratings,
                                        });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Text("View ALL",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: kPrimaryColor)),
                                  ),
                                ),
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.only(bottom: 10.0, top: 10),
                              itemCount: 1,
                              itemBuilder: ((context, index) {
                                // check review legth if theres is review then show review otherwise show no reviews
                                if (widget.reviews!.isNotEmpty) {
                                  return ReviewUI(
                                    image: 'assets/images/profile.jpg',
                                    name: widget.reviews?[index].name,
                                    date: widget.reviews?[index].time
                                        .toString()
                                        .split("T")[0],
                                    rating: widget.reviews?[index].rating!
                                        .toDouble(),
                                    comment:
                                        "${widget.reviews?[index].comment}",
                                    onTap: () {
                                      setState(() {
                                        isMore = !isMore;
                                      });
                                    },
                                    isLess: isMore,
                                  );
                                } else {
                                  return Container(
                                    height: 140,
                                    width: 100,
                                    margin: EdgeInsets.only(top: 25),
                                    child: const Text(
                                      "There is no reviews",
                                      style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                }
                              }),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Divider(
                                  thickness: 3.0,
                                  color: kPrimaryColor,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
