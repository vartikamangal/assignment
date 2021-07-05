import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';

abstract class MoodPopupShownLocalDataSource {
  Future<bool?> getMoodPopupShownStatus();
  Future<Unit> toogleIsMoodPopupShownState();
}

class MoodPopupShownLocalDataSourceImpl
    implements MoodPopupShownLocalDataSource {
  final Box? localClient;

  MoodPopupShownLocalDataSourceImpl({
    required this.localClient,
  });
  @override
  Future<bool?> getMoodPopupShownStatus() async {
    try {
      final bool? result =
          await localClient!.get(PersistenceConst.MOOD_POPUP_SHOWN) as bool?;
      return result;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<Unit> toogleIsMoodPopupShownState() async {
    try {
      final bool? oldStatus =
          await localClient!.get(PersistenceConst.MOOD_POPUP_SHOWN) as bool?;
      // If not a new user
      if (oldStatus != null) {
        await localClient!.put(
          PersistenceConst.MOOD_POPUP_SHOWN,
          !oldStatus,
        );
        return unit;
      } else {
        await localClient!.put(
          PersistenceConst.MOOD_POPUP_SHOWN,
          true,
        );
        return unit;
      }
    } catch (e) {
      throw CacheException();
    }
  }
}
