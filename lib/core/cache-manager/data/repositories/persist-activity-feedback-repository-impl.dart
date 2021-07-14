// Flutter imports:

// Package imports:
import 'package:dartz/dartz.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/services/persist-activity-feedback-local-service.dart';
import 'package:tatsam_app_experimental/core/error/exceptions.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

import '../../domain/repositories/persist-activity-feedback-repository.dart';
import '../models/activity-feedback-model.dart';

class PersistAcitivityFeedbackRepositoryImpl
    implements PersistActivityFeedbackRepository {
  final PersistActivityFeedbackLocalService? localService;

  PersistAcitivityFeedbackRepositoryImpl({
    required this.localService,
  });
  @override
  Future<Either<Failure, Unit>> persistFeedback({
    ActivityStatus? activityStatus,
    String? textInput,
    String? voiceNoteInput,
  }) async {
    try {
      final status = await localService!.persistFeedback(
        activityStatusModel: ActivityStatusModel.fromDomain(activityStatus!),
        textInput: textInput,
        voiceNoteInput: voiceNoteInput,
      );
      return Right(status);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<ActivityFeedbackModel>>>
      getpersistedFeedbacks() async {
    try {
      final result = await localService!.getPersistedFeedbacks();
      return Right(result);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
