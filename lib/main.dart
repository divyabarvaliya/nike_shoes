import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nike_shoes/core/controller/main_controller.dart';

import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBidding(),
      debugShowCheckedModeBanner: false,
      title: 'Shoes Shop',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const SplashScreen(),
    );
  }
}

class AppBidding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainController>(MainController());
  }
}
