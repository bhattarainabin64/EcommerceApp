import 'package:badges/badges.dart';

import 'package:flutter/material.dart';
import 'package:najikkopasal/components/default_button.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/cart_model.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'db_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 209, 48, 48))),
        centerTitle: true,
        
        actions: [
          Center(
            child: Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(value.getCounter().toString(),
                      style: TextStyle(color: Colors.white));
                },
              ),
              animationDuration: Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              child: Icon(Icons.shopping_bag_outlined),
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cart.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: const [
                              Image(
                                image:
                                    AssetImage('assets/images/empty_cart.png'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Your cart is empty ',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 209, 48, 48))),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'Explore products and shop your\nfavourite items',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 93, 13, 173))),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: Color.fromARGB(255, 200, 182, 182)
                                          .withOpacity(0.4),
                                      width: 2,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image(
                                              height: 110,
                                              width: 110,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data![index].image
                                                  .toString()),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .productName
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            dbHelper!.delete(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!
                                                                    .toInt());
                                                            cart.removerCounter();
                                                            cart.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color:
                                                                kPrimaryColor,
                                                          ))
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    snapshot.data![index]
                                                            .unitTag
                                                            .toString() +
                                                        " " +
                                                        snapshot.data![index]
                                                            .productPrice
                                                            .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    155,
                                                                    81,
                                                                    31),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!;
                                                                    quantity--;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;

                                                                    if (quantity >
                                                                        0) {
                                                                      dbHelper!
                                                                          .updateQuantity(Cart(
                                                                              id: snapshot.data![index].id!,
                                                                              productId: snapshot.data![index].id!.toString(),
                                                                              productName: snapshot.data![index].productName!,
                                                                              initialPrice: snapshot.data![index].initialPrice!,
                                                                              productPrice: newPrice,
                                                                              quantity: quantity,
                                                                              unitTag: snapshot.data![index].unitTag.toString(),
                                                                              image: snapshot.data![index].image.toString()))
                                                                          .then((value) {
                                                                        newPrice =
                                                                            0;
                                                                        quantity =
                                                                            0;
                                                                        cart.removeTotalPrice(double.parse(snapshot
                                                                            .data![index]
                                                                            .initialPrice!
                                                                            .toString()));
                                                                      }).onError((error, stackTrace) {
                                                                        print(error
                                                                            .toString());
                                                                      });
                                                                    }
                                                                  },
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quantity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .initialPrice!;
                                                                    quantity++;
                                                                    int?
                                                                        newPrice =
                                                                        price *
                                                                            quantity;

                                                                    dbHelper!
                                                                        .updateQuantity(Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].id!.toString(),
                                                                            productName: snapshot.data![index].productName!,
                                                                            initialPrice: snapshot.data![index].initialPrice!,
                                                                            productPrice: newPrice,
                                                                            quantity: quantity,
                                                                            unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString()))
                                                                        .then((value) {
                                                                      newPrice =
                                                                          0;
                                                                      quantity =
                                                                          0;
                                                                      cart.addTotalPrice(double.parse(snapshot
                                                                          .data![
                                                                              index]
                                                                          .initialPrice!
                                                                          .toString()));
                                                                    }).onError((error, stackTrace) {
                                                                      print(error
                                                                          .toString());
                                                                    });
                                                                  },
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  }
                  return Text('');
                }),
            Consumer<CartProvider>(builder: (context, value, child) {
              return Visibility(
                visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                    ? false
                    : true,
                child: Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      ReusableWidget(
                        title: 'Sub Total',
                        value: r'₹' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      ReusableWidget(
                        title: 'Total',
                        value: r'₹' + value.getTotalPrice().toStringAsFixed(2),
                      ),
                      DefaultButton(
                        text: "Checkout",
                        press: () {},
                      )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
