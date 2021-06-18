// Flutter imports:
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class ShowSnackbar {
  static void rawSnackBar({
    @required String title,
    @required String message,
    @required VoidCallback onActionPressed,
    @required String actionLabel,
  }) =>
      ScaffoldMessenger.of(Get.context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: actionLabel,
            onPressed: onActionPressed,
          ),
          content: CustomSnackbar(
            title: title,
            message: message,
          ),
          behavior: Platform.isIOS
              ? SnackBarBehavior.floating
              : SnackBarBehavior.fixed,
        ),
      );

  ShowSnackbar._();
}

class CustomSnackbar extends StatelessWidget {
  final String title;
  final String message;
  const CustomSnackbar({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: ScaleManager.spaceScale(spaceing: 6).value,
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info,
            color: Colors.redAccent,
          ),
          SizedBox(
            width: ScaleManager.spaceScale(spaceing: 16).value,
          ),
          Text(title),
          //Text(message),
        ],
      ),
    );
  }
}
