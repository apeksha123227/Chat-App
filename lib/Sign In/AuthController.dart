import 'package:get/get.dart';

import '../Screens/DashBoard/DashBoard_Screen.dart';
import '../Storage/SecureStorage.dart';
import '../Utils/Utils.dart';
import 'GoogleAuthService.dart';
import 'Model/UserModel.dart';

class AuthController extends GetxController {
  final GoogleAuthService googleAuthService = GoogleAuthService();
  final SecureStorage secureStorage = SecureStorage();

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();

    Utils.checkLogin();
  }

  Future<void> googleLogin() async {
    try {
      final user = await googleAuthService.login();
      if (user == null) return;

      UserModel model = UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        image: user.photoURL,
      );

      currentUser.value = model;

      //save user
      await secureStorage.saveUser(model.encode());
      Get.snackbar(
        "Success",
        "Login Successful",
        snackPosition: SnackPosition.BOTTOM,
      );
      Get.offAll(() => DashBoard_Screen());
    } catch (e) {
      print("Error Login failed: $e");
      Get.snackbar(
        "Error",
        "Login failed: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    try {
      await googleAuthService.logout();
      await secureStorage.clearUser();
      Get.snackbar(
        "Success",
        "Logout Successful",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("Google logout error: $e");
    }
  }
}
