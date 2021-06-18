// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:tatsam_app_experimental/core/repository/base-repository-impl.dart';

// Project imports:
import '../../../../core/error/failures.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/entities/track-mood-success.dart';
import '../../domain/repositories/track-subject-mood-service.dart';
import '../sources/track-subject-mood-remote-service.dart';

class TrackSubjectMoodServiceImpl implements TrackSubjectMoodService {
  final TrackSubjectMoodRemoteService service;
  final BaseRepository baseRepository;

  TrackSubjectMoodServiceImpl({
    @required this.service,
    @required this.baseRepository,
  });
  @override
  Future<Either<Failure, TrackMoodSuccess>> trackMood({
    @required MoodTracking mood,
  }) async {
    return baseRepository(
      () => service.trackMood(mood: mood),
    );
  }
}
