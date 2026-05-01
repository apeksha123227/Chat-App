import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Setting_Screen_Controller.dart';

class Setting_Screen extends StatelessWidget {
  Setting_Screen({super.key});

  final controller = Get.put(Setting_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            controller.authController.logout();
          },
          child: Text("LogOut"),
        ),
      ),
    );
  }
}
