import 'package:flutter/material.dart';
import 'package:najikkopasal/components/custom_suffix-icon.dart';
import 'package:najikkopasal/size_config.dart';

class MultiStepForm extends StatefulWidget {
  static String routeName = '/multi_step_form';
  const MultiStepForm({Key? key}) : super(key: key);

  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  // the current step
  int _currentStep = 0;

  // Determines whether the stepper's orientation is vertical or horizontal
  // This variable can be changed by using the switch below
  bool _isVerticalStepper = true;

  // This function will be triggered when a step is tapped
  _stepTapped(int step) {
    setState(() => _currentStep = step);
  }

  // This function will be called when the continue button is tapped
  _stepContinue() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  // This function will be called when the cancel button is tapped
  _stepCancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

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
          // Controls the stepper orientation

          Expanded(
            // chnage color of index in stepper

            child: Stepper(
              // vertical or horizontial
              type: StepperType.vertical,
              physics: const ScrollPhysics(),

              currentStep: _currentStep,

              onStepTapped: (step) => _stepTapped(step),
              onStepContinue: _stepContinue,
              onStepCancel: _stepCancel,
              steps: [
                // The first step: Name
                Step(
                  // give color in stepper index

                  title: const Text('Shipping'),
                  content: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          buildNameFormFild(),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          buildCityFormFild(),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          buildNameFormFild(),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          buildNameFormFild(),
                          SizedBox(height: SizeConfig.screenHeight * 0.02),
                          buildNameFormFild(),
                        ],
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
        ],
      ),
    );
  }

  TextFormField buildNameFormFild() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter Address";
        } else if (value.length <= 5) {
          return "Address should be at least 5 characters long";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
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
        } else if (value.length <= 5) {
          return "City should be at least 5 characters long";
        } else {
          return null;
        }
      },
      decoration: const InputDecoration(
        labelText: "City",
        hintText: "Enter your City",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.location_city),
      ),
    );
  }
}
