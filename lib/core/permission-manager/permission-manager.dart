// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:permission_handler/permission_handler.dart';

abstract class PermissionManager {
  Future<bool> requestPermission({
    required Permission permission,
  });
}

class PermissionManagerImpl implements PermissionManager {
  @override
  Future<bool> requestPermission({required Permission permission}) async {
    if (await permission.isGranted) {
      return true;
    } else {
      final permissionAwaitResult = await permission.request();
      if (permissionAwaitResult.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
