import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';

import 'package:najikkopasal/repository/productRepository.dart';
import 'package:najikkopasal/response/product_response.dart';
import 'package:najikkopasal/screens/home/components/category_model.dart';
import 'package:najikkopasal/screens/product_details/product_details.dart';
import 'package:najikkopasal/widget/productCard.dart';

import '../../../model/product_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  int selectId = 0;
  int activePage = 0;
  int _current = 0;

  String query = '';
  String? category;
  List<Product> lstproducts = [];
  List categtegories = [];

  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://www.opalwebdesign.com/wp-content/uploads/2014/03/ecommerce-SLIDER.jpg',
    'https://www.opalwebdesign.com/wp-content/uploads/2014/03/ecommerce-SLIDER.jpg',
  ];

  static const List<Tab> _tabs = [
    Tab(text: 'All'),
    Tab(text: 'Clothes'),
    Tab(text: 'Shoes'),
    Tab(text: 'Men'),
  ];

  @override
  Widget build(BuildContext context) {
    Widget caresoel() {
      return Caresoul(context);
    }

    TabController _tabController =
        TabController(length: _tabs.length, vsync: this);

    // _tabController.addListener(() {
    //   setState(() {
    //     if (_tabController.index == 1) {
    //       // switch tabs to second tab and setstate the category
    //       category = 'Man';
    //     }
    //   });
    // });

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: 10,
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: kPrimaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 250,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'Search',
                            ),
                            onChanged: (text) {
                              setState(() {
                                query = text;
                              });
                            },
                          ),
                        ),
                        Image.asset(
                          'assets/icons/search.png',
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 55,
                    width: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/icons/adjust.png',
                      color: Colors.white,
                      height: 36,
                    ),
                  )
                ],
              ),
            ),
            caresoel(),
            SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    splashBorderRadius: BorderRadius.circular(10),
                    indicatorColor: const Color(0xffF15C22),
                    controller: _tabController,
                    labelColor: kPrimaryColor,
                    labelPadding: const EdgeInsets.only(left: 4, right: 4),
                    unselectedLabelColor: Colors.black,
                    tabs: _tabs),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                // grod build method  start
                getproductfromapi(''),
                getproductfromapi("Man"),
                getproductfromapi("Nike"),
                getproductfromapi("Nike"),
                // future builder end

                // const Center(
                //   child: Text(
                //     "Welcome to the second Page",
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                // const Text(
                //   "Welcome to Third Page",
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(
                //   height: 40,
                //   child: Text(
                //     "I am four",
                //     textAlign: TextAlign.center,
                //   ),
                // )
              ]),
            )
          ],
        ),
      ),
    );
  }
  // make autorefresh for the product data from api uisng future builder
  
 


  FutureBuilder<ProductResponse?> getproductfromapi(String? paramst) {
    return FutureBuilder<ProductResponse?>(
        future:
            ProductRepository().getproducts(keyword: query, category: paramst),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.done) {
              lstproducts = snapshot.data!.data!;
              
              // print(lstproducts[0].reviews![0].name);

              return Container(
                decoration: BoxDecoration(
                  color: Color(0XFFEDECF2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: lstproducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return SingleProductWidget(
                        onPressed: () {
                          Navigator.pushNamed(context, ProductDetails.routeName,
                              arguments: {
                                "id": lstproducts[index].id,
                                "name": lstproducts[index].name,
                                "image": lstproducts[index]
                                    .images![0]
                                    .url
                                    .toString(),
                                "ratings": lstproducts[index].ratings,
                                "description": lstproducts[index].description,
                                "price": lstproducts[index].price,
                                "reviews": lstproducts[index].reviews,
                              });
                        },
                        productImage:
                            lstproducts[index].images![0].url.toString(),
                        productRating: lstproducts[index].ratings!.toDouble(),
                        productName: lstproducts[index].name.toString(),
                        productOldPrice: lstproducts[index].price!.toString(),
                        productPrice: lstproducts[index].price!.toString(),
                      );
                    }),
              );
            }
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CupertinoActivityIndicator());
        });
  }

// caresoul Slider method
  Column Caresoul(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 150,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
              viewportFraction: 1,
              onPageChanged: (index, carouseLReason) {
                setState(() {
                  _current = index;
                });
              }),
          items: imgList
              .map((item) => Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(9.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(item,
                                fit: BoxFit.fitWidth, width: 500.0),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                                child: const Text(
                                  '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ))
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 12.0,
                height: 12.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
