import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:najikkopasal/components/custom_suffix-icon.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/model/cart_model.dart';
import 'package:najikkopasal/model/shipping_model.dart';
import 'package:najikkopasal/screens/cart/cart_provider.dart';
import 'package:najikkopasal/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiStepForm extends StatefulWidget {
  static String routeName = '/multi_step_form';
  const MultiStepForm({Key? key}) : super(key: key);

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  // the current step
  int _currentStep = 0;
  String? name;

  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _countryController = TextEditingController();

  bool _isVerticalStepper = true;

  // make globel key
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? address;

  // This function will be triggered when a step is tapped
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  _continue() {
    if (_formKey.currentState!.validate()) {
      ShippingModel shipping = ShippingModel(
        address: _addressController.text,
        city: _cityController.text,
        pincode: _pincodeController.text,
        phone: _phoneController.text,
        country: _countryController.text,
        state: _stateController.text,
      );
      shipping.setAllData(shipping);
      print("shipping data saved");

      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    }
  }

  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  void getname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      print(name);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Processing',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Theme(
              data: ThemeData(
                  colorScheme: const ColorScheme.light(primary: kPrimaryColor)),
              child: Stepper(
                // vertical or horizontial
                type: StepperType.vertical,
                physics: const ScrollPhysics(),

                currentStep: _currentStep,

                onStepTapped: (step) => _stepTapped(step),
                onStepContinue: _continue,
                onStepCancel: _stepCancel,
                steps: [
                  Step(
                    title: const Text('Shipping'),
                    content: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildAddressFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildCityFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPincodeFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPhoneFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildCountryFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildStateFormFild(),

                              // buildNameFormFild(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The second step: Phone number
                  Step(
                    title: const Text('Confirm Order'),
                    content: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Row(children: const [
                              Text(
                                'Shipping Details',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ]),

                            // make shiiping details summary
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Name: $name",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Phone : ${_phoneController.text}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Address :${_addressController.text}",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(height: 20),
                          const Text("Your Cart Items",
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          FutureBuilder(
                              future: cart.getData(),
                              builder: (context,
                                  AsyncSnapshot<List<Cart>> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  CachedNetworkImage(
                                                      height: 110,
                                                      width: 110,
                                                      fit: BoxFit.cover,
                                                      imageUrl: snapshot
                                                          .data![index].image
                                                          .toString()),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              snapshot
                                                                  .data![index]
                                                                  .productName
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
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
                                                              snapshot
                                                                  .data![index]
                                                                  .productPrice
                                                                  .toString(),
                                                          style: const TextStyle(
                                                              fontSize: 17,
                                                              color:
                                                                  kPrimaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              })
                        ],
                      ),
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                  // The third step: Verify phone number
                  Step(
                    title: const Text('Payment'),
                    content: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Verification code'),
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 2
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildAddressFormFild() {
    return TextFormField(
      controller: _addressController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Address";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }

  TextFormField buildCityFormFild() {
    return TextFormField(
      controller: _cityController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter City";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "City",
        hintText: "Enter your City",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }

  TextFormField buildPincodeFormFild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _pincodeController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Pincode";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: "Pincode",
        hintText: "Enter your Pincode",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }

  TextFormField buildPhoneFormFild() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: _phoneController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter PhoneNumber";
        } else if (value.length <= 9) {
          return "PhoneNumber should be at least 10 characters long";
        }
      },
      decoration: const InputDecoration(
        labelText: "PhoneNumber",
        hintText: "Enter your PhoneNumber",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildCountryFormFild() {
    return TextFormField(
      controller: _countryController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Country";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "Country",
        hintText: "Enter your Country",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }

  TextFormField buildStateFormFild() {
    return TextFormField(
      controller: _stateController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter State";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: "State",
        hintText: "Enter your State",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }
}
