import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Screens/Splash/Splash_Screen.dart';
import 'Sign In/AuthController.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final currentApp = Firebase.app();

  print("Connected to Firebase Project:");
  print("PROJECT NAME: ${currentApp.name}");
  print("PROJECT ID:   ${currentApp.options.projectId}");
  print("APP ID:       ${currentApp.options.appId}");
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Chat App",
      debugShowCheckedModeBanner: false,
      home: Splash_Screen(),
    );
  }
}
