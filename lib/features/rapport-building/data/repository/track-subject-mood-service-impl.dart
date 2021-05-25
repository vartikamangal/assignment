import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/entities/track-mood-success.dart';
import '../../domain/repositories/track-subject-mood-service.dart';
import '../sources/track-subject-mood-remote-service.dart';

class TrackSubjectMoodServiceImpl implements TrackSubjectMoodService {
  final TrackSubjectMoodRemoteService service;
  final NetworkInfo networkInfo;

  TrackSubjectMoodServiceImpl({
    @required this.service,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, TrackMoodSuccess>> trackMood({
    @required MoodTracking mood,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final trackStatus = await service.trackMood(mood: mood);
        return Right(trackStatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(DeviceOfflineFailure());
    }
  }
}
