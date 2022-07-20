import 'package:flutter/material.dart';
import 'package:najikkopasal/components/custom_suffix-icon.dart';
import 'package:najikkopasal/constants.dart';
import 'package:najikkopasal/size_config.dart';
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

  bool _isVerticalStepper = true;
  // make globel key
  final _formKey = GlobalKey<FormState>();

  // This function will be triggered when a step is tapped
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  // This function will be called when the continue button is tapped
  _continue() {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState!.validate()) {
      _currentStep < 2 ? setState(() => _currentStep += 1) : null;
    }
  }

  // This function will be called when the cancel button is tapped
  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
  // make fuction to set alldata using model to sharepreferrnces
  // void setAllData(String name, String email, String phone, String address) {
  //   SharedPreferences.getInstance().then((prefs) {
  //     prefs.setString("name", name);
  //     prefs.setString("email", email);
  //     prefs.setString("phone", phone);
  //     prefs.setString("address", address);
  //   });
  // }

  // get all sharepreferrnces data function
  // Future<String> getAllData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? name = prefs.getString('name');
  //   String? email = prefs.getString('email');
  //   String? phone = prefs.getString('phone');
  //   String? address = prefs.getString('address');
  //   return '$name $email $phone $address';
  // }

  @override
  Widget build(BuildContext context) {
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
                  // The first step: Name
                  Step(
                    // give color in stepper index

                    title: const Text('Shipping'),
                    content: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              buildNameFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildCityFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPincodeFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildPhoneFormFild(),
                              SizedBox(height: SizeConfig.screenHeight * 0.02),
                              buildNameFormFild(),
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
                    content: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'You mobile number'),
                        ),
                      ],
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

  TextFormField buildNameFormFild() {
    return TextFormField(
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
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter PhoneNumber";
        } else if (value.length <= 9) {
          return "PhoneNumber should be at least 10 characters long";
        }
      },
      decoration: const InputDecoration(
        labelText: "Pincode",
        hintText: "Enter your PhoneNumber",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.phone),
      ),
    );
  }
}
