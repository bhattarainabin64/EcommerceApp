// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_cart/flutter_cart.dart';
// import 'package:flutter_cart/model/cart_model.dart';
// import 'package:najikkopasal/model/profile_model.dart';
// import 'package:najikkopasal/repository/userRepository.dart';
// import 'package:najikkopasal/response/profile_response.dart';

// class TestScreen extends StatefulWidget {
//   static String routeName = '/test';
//   TestScreen({Key? key}) : super(key: key);

//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }

// class _TestScreenState extends State<TestScreen> {
//   var cart = FlutterCart();
//   var item = CartItem(
    
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Test'),
//         ),
//         body: Container(
//           child: ElevatedButton(
//             onPressed: () {
//               cart.addToCart(

                
             

                
              
//               );
//             },
//             child: Text('Add Item'),
//           ),
//         ));
//   }
// }




// FutureBuilder<ProfileResponse?>(
//             future: UserRepository()
//                 .getprofile(), // a previously-obtained Future<String> or null, if the once-obtained Future is still active
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   Profile? profileResponse = snapshot.data!.user;

//                   // print(lstproducts[0].reviews![0].name);

//                   return Container(
//                       decoration: BoxDecoration(
//                         color: Color(0XFFEDECF2),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Container(
//                         child: Column(
//                           children: [
//                             Text(profileResponse!.name.toString()),
//                             Text(profileResponse.email.toString()),
//                             Text(profileResponse.image!.url!.toString()),
//                           ],
//                         ),
//                       ));
//                 }
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//               return const Center(child: CupertinoActivityIndicator());
//             }));
