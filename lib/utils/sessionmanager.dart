import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String auth_token = "security";

//set data into shared preferences like this
  Future<void> setAuthToken(String? authToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(this.auth_token, authToken!);
  }

//get value from shared preferences
  Future<String> getAuthToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String auth_token1;
    
    auth_token1 = pref.getString(auth_token).toString();
    return auth_token1;
  }

  

}

//  SessionManager().setAuthToken(token!);
//         Future<String> data1 = SessionManager().getAuthToken();
       

//         print(
//             "yo chai sdfgfgession bata aayooooooofgfdgfdgfdgfdgdfgooooooooooooo");
//         data1.then((value) {
//           print(value);
//         });
