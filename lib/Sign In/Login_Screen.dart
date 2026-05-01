import 'package:chat_app/Sign%20In/Login_Screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});

  final controller = Get.put(Login_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                controller.authController.googleLogin();
              },
              child: Text("Login with Google"),
            ),
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Chat App will send you an SMS to verify your number",
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                prefixText: "+91",
                hintText: "XXXXXXXXXX",
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
            ),
          ),
          /* ElevatedButton(
            onPressed: () async {
              //  controller.sendOtp(phoneController.text.trim());
              if (controller.phoneController.text.isEmpty) {
                Get.snackbar("Error", "Enter phone number");
                return;
              } else if (controller.phoneController.text.length < 10) {
                Get.snackbar("Error", "Enter valid number");
              } */
          /*else {
                Get.snackbar("Success", "Otp Sent Successfully");
              //  Get.to(OtpScreen(), arguments: controller.phoneController.text);
              }*/
          /*
              //  await controller.sendOtp(controller.phoneController.text.trim());
            },
            child: Text("Send Otp"),
          ),*/
          Obx(
            () => controller.authController.isLoading.value
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      String phone =
                          "+91${controller.phoneController.text.trim()}";

                      if (phone.isEmpty) {
                        Get.snackbar("Error", "Enter phone number");
                        return;
                      } else if (controller.phoneController.text.length < 10) {
                        Get.snackbar("Error", "Enter valid number");
                      }

                      controller.sendOtp(phone);
                    },
                    child: Text("Send OTP"),
                  ),
          ),
        ],
      ),
    );
  }
}
