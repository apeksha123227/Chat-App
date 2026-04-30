import 'package:chat_app/Sign%20In/Login_Screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});

  final controller = Get.put(Login_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            controller.authController.googleLogin();
          },
          child: Text("Login with Google"),
        ),
      ),
    );
  }
}
