// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Package imports:
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/dependency_manager/core_dependency_managers.dart';

// Project imports:
import '../persistence-consts.dart';
import '../platform/device-id.dart';

abstract class SessionManager {
  static Future<void> persistDeviceId() async {
    final box = await Hive.openBox(
      PersistenceConst.CORE_BOX,
    );
    box.put(
      PersistenceConst.CORE_DEVICE_ID,
      await getDeviceId(),
    );
  }

  static Future<void> persistUsername({
    required String name,
  }) async {
    final box = await Hive.openBox(
      PersistenceConst.CORE_BOX,
    );
    await box.put(PersistenceConst.CORE_USER_NAME, name);
  }

  static Future<String> getPersistedUsername() async {
    final box = await Hive.openBox(
      PersistenceConst.CORE_BOX,
    );
    return box.get(PersistenceConst.CORE_USER_NAME) == null
        ? 'NullUser'
        : box.get(PersistenceConst.CORE_USER_NAME).toString();
  }

  static Future<Map<String, String>> getHeader() async {
    final flutterSecureStorage = sl_core_dependencies<FlutterSecureStorage>();
    final box = await Hive.openBox(
      PersistenceConst.CORE_BOX,
    );
    final deviceID = await box.get(
      PersistenceConst.CORE_DEVICE_ID,
    ) as String?;
    final subjectInfo = await box.get(
      PersistenceConst.CORE_SUBJECT_INFO_FOR_HEADER,
    );
    final travellerInfo = await box.get(
      PersistenceConst.CORE_TRAVELLER_INFO_FOR_HEADER,
    ) as String?;
    final journey = await box.get(
      PersistenceConst.CORE_JOURNEY_FOR_HEADER,
    );
    // ignore: prefer_typing_uninitialized_variables
    // Stroes the accessToken
    final accessToken = await flutterSecureStorage.read(
          key: PersistenceConst.ACCESS_TOKEN,
        ) ??
        '';
    // If any persisted header is found return it, else return a generic header
    return deviceID == null
        ? {
            'content-type': 'application/json',
            "TATSAM_USER": '{"deviceIdentifier": "${await getDeviceId()}"}',
            'Authorization': 'Bearer $accessToken',
          }
        : {
            "content-type": 'application/json',
            "TATSAM_USER": jsonEncode(
              {
                'deviceIdentifier': deviceID,
                "subjectInformation": subjectInfo,
                "travellerInformation": travellerInfo,
                "journey": journey,
              },
            ),
            'Authorization': 'Bearer $accessToken',
          };
  }

  static Future<void> setHeader({required Map<String, dynamic> header}) async {
    final box = await Hive.openBox(PersistenceConst.CORE_BOX);
    try {
      final headerData = jsonDecode(
        header['tatsam_user'] as String,
      );
      box.put(
        PersistenceConst.CORE_DEVICE_ID,
        headerData['deviceIdentifier'] as String?,
      );
      box.put(
        PersistenceConst.CORE_JOURNEY_FOR_HEADER,
        headerData['journey'],
      );
      box.put(
        PersistenceConst.CORE_SUBJECT_INFO_FOR_HEADER,
        headerData['subjectInformation'],
      );
      box.put(
        PersistenceConst.CORE_TRAVELLER_INFO_FOR_HEADER,
        headerData['travellerInformation'],
      );
    } catch (e) {
      log('unable to refresh header');
    }
  }

  SessionManager._();
}
