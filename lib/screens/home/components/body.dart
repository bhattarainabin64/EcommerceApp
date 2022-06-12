import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/data/productData.dart';

import 'package:najikkopasal/widget/productCard';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  int selectId = 0;
  int activePage = 0;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://www.eppi-online.com/wp-content/uploads/2018/10/eppi125_Slider_965x355-1200x441.jpg',
    'https://www.opalwebdesign.com/wp-content/uploads/2014/03/ecommerce-SLIDER.jpg',
    'https://www.eppi-online.com/wp-content/uploads/2018/10/eppi125_Slider_965x355-1200x441.jpg',
    'https://www.opalwebdesign.com/wp-content/uploads/2014/03/ecommerce-SLIDER.jpg',
  ];
  // List<Widget> content = [
  //   Container(
  //     height: 200,
  //     width: double.infinity,
  //     color: Colors.black,
  //     child: Text("1"),
  //   ),
  //   Container(
  //     color: Colors.black,
  //     child: Text("2"),
  //   ),
  //   Container(
  //     color: Colors.white,
  //     child: Text("3"),
  //   ),
  //   Container(
  //     color: Colors.white,
  //     child: Text("4"),
  //   ),
  //   Container(
  //     color: Colors.white,
  //   ),
  // ];
  static const List<Tab> _tabs = [
    Tab(child: Text('All')),
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
    return Scaffold(
      // appBar: AppBar(
      //     leading: TextButton(
      //         onPressed: () {}, child: Image.asset("assets/images/menu.png")),
      //     actions: [
      //       Container(
      //         height: 40.0,
      //         width: 40.0,
      //         margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
      //         decoration: BoxDecoration(
      //           color: kPrimaryColor,
      //           boxShadow: [
      //             BoxShadow(
      //               color: kPrimaryColor.withOpacity(0.5),
      //               blurRadius: 10,
      //               offset: const Offset(0, 0),
      //             ),
      //           ],
      //           borderRadius: BorderRadius.circular(10.0),
      //           image: const DecorationImage(
      //             image: AssetImage('assets/images/menu.png'),
      //           ),
      //         ),
      //       ),
      //     ],
      //     ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kPrimaryColor),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 60,
                        width: 250,
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Search',
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/search.png',
                        height: 27,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
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
                  indicatorColor: Color(0xffF15C22),
                  controller: _tabController,
                  labelColor: kPrimaryColor,
                  labelPadding: const EdgeInsets.only(left: 4, right: 4),
                  unselectedLabelColor: Colors.black,
                  tabs: _tabs),
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: sigleProductData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    var data = sigleProductData[index];
                    return SingleProductWidget(
                      onPressed: () {},
                      productImage: data.productImage,
                      productModel: data.productModel,
                      productName: data.productName,
                      productOldPrice: data.productOldPrice,
                      productPrice: data.productPrice,
                    );
                  }),
              Center(
                child: const Text(
                  "Welcome to the second Page",
                  textAlign: TextAlign.center,
                ),
              ),
              const Text(
                "Welcome to Third Page",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
                child: Text(
                  "I am four",
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          )
          // Column(
          //   children: [
          //     SizedBox(
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           for (int i = 0; i < categories.length; i++)
          //             GestureDetector(
          //               onTap: () {
          //                 setState(() => selectId = categories[i].id);
          //               },
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   Text(
          //                     categories[i].name,
          //                     style: TextStyle(
          //                       color: selectId == i
          //                           ? kPrimaryColor
          //                           : Colors.black.withOpacity(0.7),
          //                       fontSize: 16.0,
          //                     ),
          //                   ),
          //                   if (selectId == i)
          //                     const CircleAvatar(
          //                       radius: 3,
          //                       backgroundColor: kPrimaryColor,
          //                     ),
          //                 ],
          //               ),
          //             ),
          //         ],
          //       ),
          //     ),
          //     // SizedBox(
          //     //   height: 20,
          //     // ),
          //     // SizedBox(child: content[selectId])
          //   ],
          // ),
          // end of sizeboix
        ],
      ),
    );
  }

// caresoul Slider method
  Container Caresoul(BuildContext context) {
    return Container(
      child: Column(
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
                      child: Container(
                        margin: EdgeInsets.all(5.0),
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
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(197, 255, 255, 255),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
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
                      ),
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
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
      ),
    );
  }
}
