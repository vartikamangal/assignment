// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';

abstract class CacheMostRecentAcitivityLocalService {
  Future<Unit> cacheActivity({
    required CacheAcitivityModel acitivity,
  });
}

class CacheMostRecentAcitivityLocalServiceImpl
    implements CacheMostRecentAcitivityLocalService {
  final Box localClient;

  CacheMostRecentAcitivityLocalServiceImpl({
    required this.localClient,
  });
  @override
  Future<Unit> cacheActivity({
    required CacheAcitivityModel acitivity,
  }) async {
    try {
      await localClient.put(
        PersistenceConst.MOST_RECENT_ACITIVITY,
        jsonEncode(
          acitivity.toJson(),
        ),
      );
      return unit;
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
