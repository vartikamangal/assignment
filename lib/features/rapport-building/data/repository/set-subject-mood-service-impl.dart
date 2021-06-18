// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../../../core/success/success-interface.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/repositories/set-subject-mood-service.dart';
import '../sources/set-subject-mood-remote-service.dart';

class SetSubjectMoodServiceImpl implements SetSubjectMoodService {
  final NetworkInfo networkInfo;
  final SetSubjectMoodRemoteService service;

  SetSubjectMoodServiceImpl({
    @required this.networkInfo,
    @required this.service,
  });
  @override
  Future<Either<Failure, MoodTracking>> setSubjectMood(
      {@required String moodName, @required String activityType}) async {
    if (await networkInfo.isConnected) {
      try {
        final setMoodStatus = await service.setMood(
          moodName: moodName,
          activityType: activityType,
        );
        return Right(setMoodStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
