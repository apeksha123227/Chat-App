import 'package:chat_app/Storage/SecureStorage.dart';
import 'package:get/get.dart';

import '../Sign In/Model/UserModel.dart';

class Utils {
  // GoogleSign

  static const String serverClientId =
      "1039363994934-5kvdam1jdpbsul135hnmbj725p3q6fhl.apps.googleusercontent.com";
  static const String secureStorageKeyUser = "user";

  //checkLogin

  static Future<void> checkLogin() async {
    final SecureStorage secureStorage = SecureStorage();
    Rx<UserModel?> currentUser = Rx<UserModel?>(null);

    String? data = await secureStorage.getUser();
    if (data != null) {
      currentUser.value = UserModel.decode(data);
      print("User already logged in");
    } else {
      print("User not logged in");
    }
  }
}
