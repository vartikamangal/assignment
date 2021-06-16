import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:tatsam_app_experimental/core/duration-tracker/data/models/app-duration-model.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/persistence-consts.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/generate-date-from-datetime.dart';

abstract class AppDurationLocalDataSource {
  Future<Unit> updateUserDurationOnApp({
    @required AppDurationModel appDuration,
    @required bool isNewUser,
  });
  Future<AppDurationModel> getLastLogin();
}

class AppDurationLocalDataSourceImpl implements AppDurationLocalDataSource {
  final Box localClient;

  AppDurationLocalDataSourceImpl({
    @required this.localClient,
  });
  @override
  Future<AppDurationModel> getLastLogin() async {
    try {
      final rawAppDuration = await localClient.get(
        PersistenceConst.USER_DURATION_ON_APP,
      );
      return AppDurationModel.frmoJson(
        jsonDecode(rawAppDuration.toString()) as Map<String, dynamic>,
      );
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<Unit> updateUserDurationOnApp({
    //! This arguement not needed anymore
    AppDurationModel appDuration,
    bool isNewUser,
  }) async {
    try {
      final dateToday = generateDateFromDateTime(DateTime.now());
      // If this function is being called for the first time {for new users}
      final initDurationSetter = jsonEncode(
        AppDurationModel(
          lastLogin: DateTime.now(),
          currentWeekday: 1,
        ).toJson(),
      );
      // If calling this for the first time
      if (isNewUser) {
        await localClient.put(
          PersistenceConst.USER_DURATION_ON_APP,
          initDurationSetter,
        );
        log('duration updated for new user');
        return unit;
      } else {
        final olderDate = await getLastLogin();
        final olderAppOpeningDate = generateDateFromDateTime(
          olderDate.lastLogin,
        );
        final weekDayToday = DateTime.now().weekday;
        // If today is weekday, and user is opening the app for the first time
        // weekDayCode : Sunday == 7
        if (weekDayToday == 2 && olderAppOpeningDate != dateToday) {
          await localClient.put(
            PersistenceConst.USER_DURATION_ON_APP,
            jsonEncode(
              olderDate
                  .copyWith(
                    lastLogin: DateTime.now(),
                    currentWeekday: olderDate.currentWeekday + 1,
                  )
                  .toJson(),
            ),
          );
          log('duration updated for old user');
          return unit;
        }
        // If not so, simply log and leave
        else {
          log('Opening for more than first time on weekend, Or its not weekend');
          return unit;
        }
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }
}
