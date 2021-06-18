// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/repositories/set-subject-mood-service.dart';
import '../sources/set-subject-mood-remote-service.dart';

class SetSubjectMoodServiceImpl implements SetSubjectMoodService {
  final SetSubjectMoodRemoteService service;
  final BaseRepository baseRepository;

  SetSubjectMoodServiceImpl({
    @required this.service,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, MoodTracking>> setSubjectMood(
      {@required String moodName, @required String activityType}) async {
    return baseRepository(
      () => service.setMood(
        moodName: moodName,
        activityType: activityType,
      ),
    );
  }
}
