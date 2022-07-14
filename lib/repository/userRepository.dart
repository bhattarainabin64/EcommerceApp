import 'package:najikkopasal/api/userapi.dart';
import 'package:najikkopasal/model/user.dart';
import 'package:najikkopasal/response/profile_response.dart';

class UserRepository {
  Future<bool> registerUser(User user) async {
    return await UserAPI().registerUser(user);
  }

  Future<bool> login(String email, String password) {
    return UserAPI().login(email, password);
  }

  Future<ProfileResponse?> getprofile() async {
    return UserAPI().getuser();
  }


  Future<bool> updateprofile(String? name, String? email, String? image) {
    return UserAPI().updateprofile(name, email, image);
  }
}
