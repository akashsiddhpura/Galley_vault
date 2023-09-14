import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void showErrorSnackBar({String? message, required String title}) {
    Get.snackbar(
      title,
      message = "",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      borderRadius: 8,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      barBlur: 10,
      colorText: Colors.white,
      isDismissible: false,
      backgroundColor: Colors.black.withOpacity(0.2),
    );
  }
}
