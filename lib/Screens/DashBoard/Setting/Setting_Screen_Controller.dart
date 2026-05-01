import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Sign In/AuthController.dart';

class Setting_Screen_Controller extends GetxController {
  AuthController authController = Get.find<AuthController>();

  final TextEditingController nameController = TextEditingController();
}
