import 'package:flutter/material.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/home/components/category_model.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  int selectId = 0;
  int activePage = 0;
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
    Tab(icon: Icon(Icons.looks_one), child: Text('All')),
    Tab(icon: Icon(Icons.looks_two), text: 'Clothes'),
    Tab(icon: Icon(Icons.looks_3), text: 'Shoes'),
    Tab(icon: Icon(Icons.looks_4), text: 'Men'),
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: _tabs.length, vsync: this);

    return Scaffold(
      // appBar: AppBar(
      //     // leading: TextButton(
      //     //     onPressed: () {}, child: Image.asset("assets/images/menu.png")),
      //     // actions: [
      //     //   Container(
      //     //     height: 40.0,
      //     //     width: 40.0,
      //     //     margin: const EdgeInsets.only(right: 20, top: 10, bottom: 5),
      //     //     decoration: BoxDecoration(
      //     //       color: kPrimaryColor,
      //     //       boxShadow: [
      //     //         BoxShadow(
      //     //           color: kPrimaryColor.withOpacity(0.5),
      //     //           blurRadius: 10,
      //     //           offset: const Offset(0, 0),
      //     //         ),
      //     //       ],
      //     //       borderRadius: BorderRadius.circular(10.0),
      //     //       image: const DecorationImage(
      //     //         image: AssetImage('assets/images/menu.png'),
      //     //       ),
      //     //     ),
      //     //   ),
      //     // ],
      //     ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Container(
                    height: 60,
                    width: 300,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          'assets/images/menu.png',
                          height: 25,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 60,
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
                      'assets/images/menu.png',
                      color: Colors.white,
                      height: 25,
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                    controller: _tabController,
                    labelColor: kPrimaryColor,
                    labelPadding: const EdgeInsets.only(left: 4, right: 4),
                    unselectedLabelColor: Colors.black,
                    tabs: _tabs),
              ),
            ),
            SizedBox(
              height: 300,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: const [
                Text(
                  "hi",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Welcome to the second Page",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Welcome to Third Page",
                  textAlign: TextAlign.center,
                ),
                SizedBox(
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
      ),
    );
  }
}
