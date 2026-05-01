import 'package:chat_app/Storage/SecureStorage.dart';
import 'package:get/get.dart';

import '../Sign In/Model/UserModel.dart';

class Utils {
  // firebase

  static const String appName = "Chat App";
  static const String Users = "User";
  static const String Google_Sign_In = "Google Sign In Users";
  static const String Phone_Sign_In = "Phone Sign In Users";

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
