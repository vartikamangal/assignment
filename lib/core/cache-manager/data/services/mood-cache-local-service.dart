import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../models/cached-mood-model.dart';
import '../../../error/exceptions.dart';
import '../../../persistence-consts.dart';

abstract class MoodCacheLocalService {
  Future<Unit> cacheMood({
    @required CachedMoodModel cachedMoodModel,
  });
  Future<CachedMoodModel> getCachedMood();
}

class MoodCacheLocalServiceImpl implements MoodCacheLocalService {
  final Box localClient;

  MoodCacheLocalServiceImpl({
    @required this.localClient,
  });
  @override
  Future<Unit> cacheMood({
    CachedMoodModel cachedMoodModel,
  }) async {
    try {
      await localClient.put(
        PersistenceConst.USER_MOOD,
        jsonEncode(
          cachedMoodModel.toJson(),
        ),
      );
      return unit;
    } catch (e) {
      log(
        e.toString(),
      );
      throw CacheException();
    }
  }

  @override
  Future<CachedMoodModel> getCachedMood() async {
    try {
      final rawMood =
          await localClient.get(PersistenceConst.USER_MOOD) as String;
      return CachedMoodModel.fromJson(
        jsonDecode(rawMood) as Map<String, dynamic>,
      );
    } catch (e) {
      log(
        e.toString(),
      );
      throw CacheException();
    }
  }
}
