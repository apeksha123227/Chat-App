import 'package:chat_app/Screens/Splash/Splash_Screen_Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_Screen extends StatelessWidget {
  Splash_Screen({super.key});

  final controller = Get.put(Splash_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Splash Screen")));
  }
}
