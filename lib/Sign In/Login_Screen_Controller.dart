import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AuthController.dart';

class Login_Screen_Controller extends GetxController {
  AuthController authController = Get.find<AuthController>();

  final phoneController = TextEditingController();

  Future<void> sendOtp(String phone) async {
    await authController.sendOTP(phone);
  }
}
