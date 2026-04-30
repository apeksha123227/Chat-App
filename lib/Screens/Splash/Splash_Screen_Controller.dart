import 'package:get/get.dart';

import '../../Sign In/AuthController.dart';
import '../../Sign In/Login_Screen.dart';
import '../../Sign In/Model/UserModel.dart';
import '../../Storage/SecureStorage.dart';
import '../DashBoard/DashBoard_Screen.dart';

class Splash_Screen_Controller extends GetxController {
  AuthController authController = Get.find<AuthController>();
  final SecureStorage secureStorage = SecureStorage();

  @override
  void onInit() {
    super.onInit();
    goToNextScreen();
  }

  void goToNextScreen() async {
    await Future.delayed(Duration(seconds: 3));

    String? data = await secureStorage.getUser();

    if (data != null) {
      authController.currentUser.value = UserModel.decode(data);
      print("User already logged in");

      Get.offAll(() => DashBoard_Screen());
    } else {
      print("User not logged in");
      Get.offAll(() => Login_Screen());
    }
  }
}
