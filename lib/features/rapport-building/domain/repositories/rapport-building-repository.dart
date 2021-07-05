import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/success/success-interface.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling-duration.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-building-steps.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

abstract class RapportBuildingRepository {
  Future<Either<Failure, List<Mood>>?> getAllMoods();
  Future<Either<Failure, List<FeelingDuration>>?> getAvailableDurations();
  Future<Either<Failure, RapportBuildingSteps>?> getRapportBuildingSteps({
    required Mood mood,
  });
  Future<Either<Failure, MoodTracking>?> setSubjectMood({
    required String? moodName,
    required String activityType,
  });
  Future<Either<Failure, SubjectInformation>?> setSubjectName({
    required String subjectName,
  });
  Future<Either<Failure, Success>?> trackMood({
    required MoodTrackingModel mood,
  });
}
