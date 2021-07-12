import 'dart:developer';

import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-most-recent-acitivity.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/persist-activity-feedbacks.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';

class ActivityCacheController extends GetxController {
  final CacheMostRecentAcitivity cacheMostRecentAcitivity;
  final PersistActivityFeedback persistActivityFeedback;

  ActivityCacheController({
    required this.cacheMostRecentAcitivity,
    required this.persistActivityFeedback,
  });

  /// Caches the most recent completed activity for Future use
  Future<void> cacheActivity({required CacheAcitivityModel activity}) async {
    final failureOrResult = await cacheMostRecentAcitivity(
      CacheMostRecentAcitivityParams(acitivity: activity),
    );
    failureOrResult!.fold(
      (f) {
        log("<--------- Error in caching this activity -------->");
      },
      (r) {
        log("<--------- Activity cached successfully -------->");
      },
    );
  }

  /// Caches the feedbacks given by user in PerformActivity flow
  Future<void> persistFeedback({
    required String textFeedback,
    required String? voicenotePath,
    required ActivityStatus activityStatus,
  }) async {
    final failureOrResult = await persistActivityFeedback(
      PersistActivityFeedbackParams(
        activityStatusModel: activityStatus as ActivityStatusModel,
        textInput: textFeedback,
        voiceNoteInput: voicenotePath,
      ),
    );
    failureOrResult.fold(
      (f) {
        log("<--------- Error in caching this Feedback -------->");
      },
      (r) {
        log("<--------- Feedback cached successfully -------->");
      },
    );
  }
}
