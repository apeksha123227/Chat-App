import 'package:chat_app/Screens/DashBoard/DashBoard_Screen.dart';
import 'package:chat_app/Sign%20In/Login_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../Storage/SecureStorage.dart';
import '../Utils/Utils.dart';
import 'GoogleAuthService.dart';
import 'Model/UserModel.dart';
import 'OtpScreen.dart';

class AuthController extends GetxController {
  final GoogleAuthService googleAuthService = GoogleAuthService();
  final SecureStorage secureStorage = SecureStorage();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final usersRef = FirebaseFirestore.instance
      .collection(Utils.appName)
      .doc(Utils.Users);

  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  RxBool isLoading = false.obs;

  String verificationId = "";
  int? resendToken;

  @override
  void onInit() {
    super.onInit();
    Utils.checkLogin();
  }

  //Google SIgn In

  Future<void> googleLogin() async {
    try {
      final user = await googleAuthService.login();
      if (user == null) return;

      UserModel model = UserModel(
        uid: user.uid,
        name: user.displayName,
        email: user.email,
        image: user.photoURL,
        phone: user.phoneNumber,
      );

      currentUser.value = model;

      //Save User in FirBase

      await usersRef
          //.doc(Utils.Users)
          .collection(Utils.Google_Sign_In)
          .doc(user.uid)
          .set({
            'uid': user.uid,
            'name': user.displayName,
            'email': user.email,
            'phone': user.phoneNumber,
            'image': user.photoURL,
          });

      //Save User in Storage

      await secureStorage.saveUser(model.encode());

      Get.snackbar("Success", "Login Successful");

      Get.offAll(() => DashBoard_Screen());
    } catch (e) {
      Get.snackbar("Error", "Login failed: $e");
    }
  }

  // LogOut

  Future<void> logout() async {
    try {
      await googleAuthService.logout();
      await secureStorage.clearUser();

      Get.snackbar("Success", "Logout Successful");

      Get.offAll(() => Login_Screen());
    } catch (e) {
      print("Google logout error: $e");
    }
  }

  //Send Otp

  Future<void> sendOTP(String phone) async {
    try {
      isLoading.value = true;

      await auth.verifyPhoneNumber(
        phoneNumber: phone,

        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
          Get.offAll(() => DashBoard_Screen());
        },

        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar("Error", e.message ?? "OTP Failed");
        },

        codeSent: (String verId, int? token) {
          verificationId = verId;
          resendToken = token;

          Get.to(() => OtpScreen(phone: phone));
        },

        codeAutoRetrievalTimeout: (String verId) {
          verificationId = verId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //Verify Otp

  Future<void> verifyOTP(String otp, String phone) async {
    try {
      isLoading.value = true;

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      UserCredential userCred = await auth.signInWithCredential(credential);

      final user = userCred.user;

      if (user != null) {
        UserModel model = UserModel(
          uid: user.uid,
          name: user.displayName ?? "",
          email: user.email ?? "",
          image: user.photoURL ?? "",
          phone: phone,
        );

        currentUser.value = model;

        //Save User in FirBase

        await usersRef
            //.doc(Utils.Users)
            .collection(Utils.Phone_Sign_In)
            .doc(user.uid)
            .set({
              'uid': user.uid,
              'name': user.displayName,
              'email': user.email,
              'phone': user.phoneNumber,
              'image': user.photoURL,
            });

        //Save User in Storage

        await secureStorage.saveUser(model.encode());

        Get.snackbar("Success", "Login Successful");

        Get.offAll(() => DashBoard_Screen());
      }
    } catch (e) {
      Get.snackbar("Error", "Invalid OTP");
    } finally {
      isLoading.value = false;
    }
  }

  //Get  Single  User

  Future<void> getSingleUser(String uid) async {
    final doc = await usersRef.collection(Utils.Phone_Sign_In).doc(uid).get();

    if (doc.exists) {
      print(doc['name']);
    }
  }
}
