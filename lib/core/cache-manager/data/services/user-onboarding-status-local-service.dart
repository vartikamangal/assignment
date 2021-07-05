// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/persistence-consts.dart';

abstract class UserOnboardingStatusLocalService {
  Future<Unit> saveStatus({
    required String status,
  });
  Future<String> fetchStatus();
  Future<Unit> saveIsFirstTimeUser({
    required String? onBoardingStatus,
  });
  Future<bool> checkIsFirstTimeUser();
}

class UserOnboardingStatusLocalServiceImpl
    implements UserOnboardingStatusLocalService {
  final Box localClient;

  UserOnboardingStatusLocalServiceImpl({
    required this.localClient,
  });
  @override
  Future<String> fetchStatus() async {
    log('entered here!!');
    try {
      final onBoardingStatus =
          await localClient.get(PersistenceConst.USER_ONBOARDING_STATUS);
      if (onBoardingStatus != null) {
        return onBoardingStatus as String;
      } else {
        return 'INCOMPLETE';
      }
    } catch (e) {
      log(
        e.toString(),
      );
      throw CacheException();
    }
  }

  @override
  Future<Unit> saveStatus({required String status}) async {
    try {
      await localClient.put(
        PersistenceConst.USER_ONBOARDING_STATUS,
        status,
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
  Future<bool> checkIsFirstTimeUser() async {
    try {
      final isFirstTimeUserCheckString = await localClient.get(
        PersistenceConst.IS_FIST_TIME_USER,
      ) as String?;
      final bool _openedAppForFirstTime = isFirstTimeUserCheckString == 'YES' ||
          isFirstTimeUserCheckString == null;
      if (_openedAppForFirstTime) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      throw CacheException();
    }
  }

  @override
  Future<Unit> saveIsFirstTimeUser({String? onBoardingStatus}) async {
    try {
      await localClient.put(
        PersistenceConst.IS_FIST_TIME_USER,
        onBoardingStatus,
      );
      return unit;
    } catch (e) {
      log(
        e.toString(),
      );
      throw CacheException();
    }
  }
}
