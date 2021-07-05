import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

abstract class CacheClearingLocalService {
  Future<Unit> clearDirtyCacheOnFirstRun();
}

class CacheClearingLocalServiceImpl implements CacheClearingLocalService {
  final Box localClient;
  final FlutterSecureStorage flutterSecureStorage;

  CacheClearingLocalServiceImpl({
    required this.localClient,
    required this.flutterSecureStorage,
  });
  @override
  Future<Unit> clearDirtyCacheOnFirstRun() async {
    try {
      /// Checks wheather first run or not
      if (await localClient.get(PersistenceConst.IS_FIRST_RUN) as bool? ??
          true) {
        /// If first run, then remove all cached data from toolchain
        await flutterSecureStorage.deleteAll();

        /// And put first run as false for that whole session
        await localClient.put(PersistenceConst.IS_FIRST_RUN, false);
        return unit;
      } else {
        log('skip dirty cache removal step');
        return unit;
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
