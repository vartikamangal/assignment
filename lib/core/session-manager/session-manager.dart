import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../persistence-consts.dart';
import '../platform/device-id.dart';

abstract class SessionManager {
  static Future<void> persistDeviceId() async {
    final box = await Hive.openBox(PersistenceConst.CORE_BOX);
    box.put(
      PersistenceConst.CORE_DEVICE_ID,
      await getDeviceId(),
    );
  }

  Future<void> persistUser() async{}

  static Future<Map<String, String>> getHeader() async {
    final box = await Hive.openBox(
      PersistenceConst.CORE_BOX,
    );
    final deviceID = await box.get(
      PersistenceConst.CORE_DEVICE_ID,
    ) as String;
    final subjectInfo = await box.get(
      PersistenceConst.CORE_SUBJECT_INFO_FOR_HEADER,
    );
    final travellerInfo = await box.get(
      PersistenceConst.CORE_TRAVELLER_INFO_FOR_HEADER,
    ) as String;
    final journey = await box.get(
      PersistenceConst.CORE_JOURNEY_FOR_HEADER,
    );
    // If any persisted header is found return it, else return a generic header
    return deviceID == null
        ? {
            'content-type': 'application/json',
            "TATSAM_USER": '{"deviceIdentifier": "${await getDeviceId()}"}',
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
          };
  }

  static Future<void> setHeader({@required Map<String, dynamic> header}) async {
    final box = await Hive.openBox(PersistenceConst.CORE_BOX);
    try {
      final headerData = jsonDecode(
        header['tatsam_user'] as String,
      );
      box.put(
        PersistenceConst.CORE_DEVICE_ID,
        headerData['deviceIdentifier'] as String,
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
