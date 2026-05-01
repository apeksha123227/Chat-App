import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AuthController.dart';

class OtpScreen_Controller extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();
}
