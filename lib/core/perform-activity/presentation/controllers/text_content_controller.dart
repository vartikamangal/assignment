import 'dart:developer';

import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/cache-manager/presentation/controllers/activity_cache_controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

class TextContentController extends GetxController {
  /// Stores textFeedback of user if case
  /// of [ActivityType] == "PLAIN_TEXT"
  RxString textFeedback = RxString('');

  /// If the [ActivityType] == "PLAIN_TEXT"
  /// then Cache the feedback
  void cacheActivityFeedback({required String activityType}) {
    if (activityType == "PLAIN_TEXT") {
      final activityCacheController = Get.find<ActivityCacheController>();
      final activityStatus =
          Get.find<PerformActivityController>().onGoingActivityStatus.value;
      if (activityStatus != null) {
        activityCacheController.persistFeedback(
          activityStatus: activityStatus,
          textFeedback: textFeedback.value,
          voicenotePath:
              Get.find<VoiceNoteController>().currentVoiceNotePath.value,
        );
      } else {
        log("<----------- [NULL] Activity Skipped caching --------->");
      }
    }
  }
}
