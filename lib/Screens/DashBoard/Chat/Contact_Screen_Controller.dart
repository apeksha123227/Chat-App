import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';

import '../../../Sign In/AuthController.dart';
import '../../../Utils/Utils.dart';
import 'Model/Contact_Model.dart';

class Contact_Screen_Controller extends GetxController {
  RxBool isLoading = false.obs;

  List<String> firebasePhones = [];
  RxList<Contact_Model> matchedContacts = <Contact_Model>[].obs;

  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    matchContacts();
  }

  // Get Firebase users from both phone and Google collections
  Future<void> getPhoneUsers() async {
    firebasePhones.clear();

    // Get phone sign-in users
    final phoneSnapshot = await authController.usersRef
        .collection(Utils.Phone_Sign_In)
        .get();
    print("Total Firebase phones: ${phoneSnapshot.docs.length}");
    for (var doc in phoneSnapshot.docs) {
      String phone = (doc['phone'] ?? "").toString();
      if (phone.isNotEmpty) {
        firebasePhones.add(phone);
      }
    }
    /*

    // Get Google sign-in users (if they have phone numbers)
    final googleSnapshot = await authController.usersRef
        .collection(Utils.Google_Sign_In)
        .get();
    print("Google sign-in users count: ${googleSnapshot.docs.length}");
    for (var doc in googleSnapshot.docs) {
      String phone = (doc['phone'] ?? "").toString();
      if (phone.isNotEmpty) {
        firebasePhones.add(phone);
        print("Google user phone: $phone");
      }
    }
*/

    // print("Total Firebase phones: ${firebasePhones.length}");
  }

  // Format phone
  String formatPhone(String phone) {
    phone = phone.replaceAll(RegExp(r'[^0-9+]'), '');

    if (phone.length == 10 && !phone.startsWith('+')) {
      phone = "+91$phone";
    }

    return phone;
  }

  // Match contacts
  Future<void> matchContacts() async {
    isLoading.value = true;

    try {
      await getPhoneUsers();

      List<Contact_Model> allContacts = await getMobileContacts();
      print("Total mobile contacts: ${allContacts.length}");

      List<Contact_Model> tempList = [];

      for (var contact in allContacts) {
        String formatted = formatPhone(contact.phone);
        /* print(
          "Checking contact: ${contact.name} - ${contact.phone} -> $formatted",
        );*/

        if (firebasePhones.contains(formatted)) {
          tempList.add(contact);
          print("MATCH FOUND: ${contact.name}");
        }
      }

      matchedContacts.value = tempList;
      print("Matched contacts count: ${matchedContacts.length}");
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Contact_Model>> getMobileContacts() async {
    List<Contact_Model> contactsList = [];

    bool permission = await FlutterContacts.requestPermission();

    print(" Permission  ${await FlutterContacts.requestPermission()}");

    if (!await FlutterContacts.requestPermission(readonly: true)) {
      if (await FlutterContacts.openExternalPick() != null) {
        Get.snackbar("Permission", "Please allow contacts permission");
      }

      return [];
    }

    final contacts = await FlutterContacts.getContacts(withProperties: true);

    print("Total mobile contacts: ${contacts.length}");

    for (var contact in contacts) {
      if (contact.phones.isNotEmpty) {
        contactsList.add(
          Contact_Model(
            name: contact.displayName,
            phone: contact.phones.first.number,
          ),
        );
      }
    }

    return contactsList;
  }

  String getFirstLatter(String? name) {
    if (name == null || name.trim().isEmpty) return "?";

    try {
      final cleaned = safeString(name.trim());

      if (cleaned.isEmpty) return "?";

      final firstChar = String.fromCharCodes(cleaned.runes.take(1));

      return firstChar.toUpperCase();
    } catch (e) {
      return "?";
    }
  }

  String safeString(String? input) {
    if (input == null || input.isEmpty) return "";

    try {
      return String.fromCharCodes(
        input.runes.where((r) => r <= 0xD7FF || (r >= 0xE000 && r <= 0x10FFFF)),
      );
    } catch (e) {
      return "";
    }
  }
}
