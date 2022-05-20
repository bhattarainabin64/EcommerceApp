import 'package:flutter/material.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/screens/splash/components/splash_content.dart';

import '../../../size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Welcome to Tokoto, Let’s shop!",
      "image": "assets/images/banner.jpg"
    },
    {
      "text":
          "We help people conect with store \naround United State of America",
      "image": "assets/images/banner.jpg"
    },
    {
      "text": "We show the easy way to shop. \nJust stay at home with us",
      "image": "assets/images/banner.jpg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) => {
                  setState(() {
                    currentPage = value;
                  })
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"] ?? '',
                  text: splashData[index]["text"] ?? '',
                ),
              ),
            ),

            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),

                      // Spacer(flex: 3),
                      const Spacer(
                        flex: 3,
                      ),
                      DefaultButton(
                        text: "Continue",
                        press: () {},
                      ),
                      const Spacer(),
                    ],
                  ),
                ))
            // Expanded(
            //   flex: 2,
            //   child: Column(
            //     children: [
            //       Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: List.generate(
            //             splashData.length,
            //             (index) => buildDot(index: index),
            //           )
            //           ),

            //     ],

            //   ),
            // )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
