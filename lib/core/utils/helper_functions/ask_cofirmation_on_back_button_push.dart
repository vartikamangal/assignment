import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> askConfirmation({
  required String acceptLabel,
  required String denyLabel,
  required String title,
  required Future Function() onAccept,
  required Future Function() onDeny,
}) async {
  final bool? result = await Get.dialog(
    AlertDialog(
      title: Text(
        title,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => onDeny(),
          child: Text(denyLabel),
        ),
        TextButton(
          onPressed: () => onAccept(),
          child: Text(acceptLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}
