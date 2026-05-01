import 'package:chat_app/Sign%20In/OtpScreen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  final String phone;

  OtpScreen({required this.phone});

  final controller = Get.put(OtpScreen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify $phone")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller.otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(hintText: "Enter OTP"),
            ),

            SizedBox(height: 20),

            Obx(
              () => controller.authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () {
                        if (controller.otpController.text.isEmpty) {
                          Get.snackbar("Error", "Enter OTP");
                          return;
                        }
                        if (controller.otpController.text.length < 6) {
                          Get.snackbar("Error", "OTP must be 6 digits");
                          return;
                        }
                        controller.authController.verifyOTP(
                          controller.otpController.text.trim(),
                          phone,
                        );
                      },
                      child: Text("Verify"),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
