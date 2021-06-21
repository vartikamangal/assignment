// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';

abstract class RetrieveMostRecentActivityLocalDataSource {
  Future<CacheAcitivityModel> retrieveActivity();
}

class RetrieveMostRecentActivityLocalDataSourceImpl
    implements RetrieveMostRecentActivityLocalDataSource {
  final Box localClient;

  RetrieveMostRecentActivityLocalDataSourceImpl({
    @required this.localClient,
  });
  @override
  Future<CacheAcitivityModel> retrieveActivity() async {
    try {
      final cachedActivityRaw = await localClient.get(
        PersistenceConst.MOST_RECENT_ACITIVITY,
      ) as String;

      /// In this case use has no recently completed mood recenlty
      if (cachedActivityRaw == null) {
        return const CacheAcitivityModel(
          id: null,
          title: '',
          subtitle: '',
          icon: null,
        );
      } else {
        return CacheAcitivityModel.fromJson(
          jsonDecode(cachedActivityRaw) as Map<String, dynamic>,
        );
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
