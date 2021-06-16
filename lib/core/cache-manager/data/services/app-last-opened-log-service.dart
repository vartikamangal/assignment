import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

abstract class AppLastOpenedLogLocalService {
  Future<Unit> logStartDatetime();
  Future<DateTime> retrieveLastLog();
}

class AppLastOpenedLogLocalServiceImpl implements AppLastOpenedLogLocalService {
  final Box localClient;

  AppLastOpenedLogLocalServiceImpl({
    @required this.localClient,
  });
  @override
  Future<Unit> logStartDatetime() async {
    try {
      await localClient.put(
        PersistenceConst.LAST_OPENED_APP,
        DateTime.now().toString(),
      );
      return unit;
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<DateTime> retrieveLastLog() async {
    try {
      final unParsedDateTime = await localClient.get(
        PersistenceConst.LAST_OPENED_APP,
      );
      return DateTime.parse(
        unParsedDateTime as String,
      );
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
