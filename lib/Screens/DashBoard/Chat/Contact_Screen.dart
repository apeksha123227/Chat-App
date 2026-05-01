import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Contact_Screen_Controller.dart';

class Contact_Screen extends StatelessWidget {
  Contact_Screen({super.key});

  final controller = Get.put(Contact_Screen_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Contact",
          style: TextStyle(
            fontWeight: FontWeight.w600 /* color: Colors.white*/,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.matchedContacts.isEmpty) {
          return Center(child: Text("No Contacts Found"));
        }

        return Padding(
          padding: const EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: controller.matchedContacts.length,
            itemBuilder: (context, index) {
              final contact = controller.matchedContacts[index];

              return Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      child: Text(
                        /*contact.name.isNotEmpty
                            ? contact.name[0].toUpperCase()
                            : "?",*/
                        controller.getFirstLatter(contact.name),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contact.name),
                          SizedBox(height: 10),
                          Text(
                            contact.phone.isNotEmpty
                                ? contact.phone
                                : "No Number",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
