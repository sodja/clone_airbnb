import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CustomToastBar {
  static void showToastBar({
    required BuildContext? context,
    required String title,
    required String message,
    required Color backgroundColor,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0
    );


/*    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: backgroundColor,
        titleText: Text(
          title,
          style: const TextStyle(fontSize: 16, color: whiteColor),
        ),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16, color: whiteColor),
        ),
        colorText: Colors.white,
        borderRadius: 8,
        margin: const EdgeInsets.all(16));*/
  }
}