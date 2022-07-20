import 'package:shared_preferences/shared_preferences.dart';

class ShippingModel {
  String? address;
  String? city;
  String? pincode;
  String? phone;
  String? country;
  String? state;

  ShippingModel(
      {this.address,
      this.city,
      this.pincode,
      this.phone,
      this.country,
      this.state});
}

// make key value pair for shipping model
Map<String, dynamic> _shippingModelToJson(ShippingModel model) {
  return {
    'address': model.address,
    'city': model.city,
    'pincode': model.pincode,
    'phone': model.phone,
    'country': model.country,
    'state': model.state,
  };
}

void setAllData(ShippingModel shippingData) {
  SharedPreferences.getInstance().then((prefs) {
    prefs.setString("address", shippingData.address.toString());
    prefs.setString("city", shippingData.city.toString());
    prefs.setString("pincode", shippingData.pincode.toString());
    prefs.setString("phone", shippingData.phone.toString());
    prefs.setString("country", shippingData.country.toString());
    prefs.setString("state", shippingData.state.toString());
  });
}

// return all data from sharepreferrnces in key value pair
Future<ShippingModel> getAllData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? address = prefs.getString('address');
  String? city = prefs.getString('city');
  String? pincode = prefs.getString('pincode');
  String? phone = prefs.getString('phone');
  String? country = prefs.getString('country');
  String? state = prefs.getString('state');
  return ShippingModel(
      address: address,
      city: city,
      pincode: pincode,
      phone: phone,
      country: country,
      state: state);
}

// print getAllData function single values
