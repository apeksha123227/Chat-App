import 'package:chat_app/Screens/DashBoard/Chat/Chats_Screen_Controller.dart';
import 'package:chat_app/Screens/DashBoard/Chat/Contact_Screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chats_Screen extends StatelessWidget {
  Chats_Screen({super.key});

  final controller = Get.put(Chats_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(Contact_Screen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
