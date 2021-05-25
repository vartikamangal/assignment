import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShowSnackbar {
  static void rawSnackBar({
    @required String title,
    String message,
  }) =>
      Get.rawSnackbar(
        title: title,
        message: message,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 1),
      );

  ShowSnackbar._();
}
