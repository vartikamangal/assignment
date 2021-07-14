import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/rate-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/base_content_widget.dart';

/// Valid for the content page's activity UI fragment
enum ContentUIStatus {
  INITIALIZING,
  LOADED,
  FAILED,
}

class ContentPageController extends GetxController {
  final RateActivity rateActivity;

  ContentPageController({required this.rateActivity});

  /// Parent controller for Activity management
  final PerformActivityController parentController = Get.find();

  /// Stores what widget to show in content block
  Rx<BaseContentWidget> contentWidget = Rx(ContentInitializing());

  /// Stores the status of activity content ui
  Rx<ContentUIStatus> contentUIStatus = Rx(ContentUIStatus.INITIALIZING);

  /// Unfocus helper in case of TextField
  final FocusNode focusNode = FocusNode();

  /// Unfocuses the view from above [FocusNode]
  void unfocusTextField() {
    focusNode.unfocus();
  }

  void initializeActivityContent({required String templateName}) {
    final contentSupported = ContentWidgetFactory.isTemplateNameSupported(
      templateName: templateName,
    );
    if (contentSupported) {
      contentUIStatus.value = ContentUIStatus.LOADED;
      _setContentWidget(templateName: templateName);
    } else {
      log("<---------- Unsupported Activity Content ----------->");
      contentUIStatus.value = ContentUIStatus.FAILED;
    }
  }

  void _setContentWidget({required String templateName}) {
    contentWidget.value =
        ContentWidgetFactory.getContentWidget(templateName: templateName);
  }

  Future<void> rateOngoingActivity({
    required String? mood,
    required String? textFeedback,
    required int elapsedTime,
    required int activityId,
  }) async {
    final ratedActivityOrFailure = await rateActivity(
      RateActivityParams(
        feedback: ActivityRatingModel(
          subjectMoodVO: MoodFeedbackModelForActivity(
            mood: mood,
            activityType: 'RECOMMENDATION',
          ),
          // Change this to a time tracker
          minutesSpent: elapsedTime,
          feedbackThoughts: textFeedback,
          recommendationId:
              parentController.onGoingActivityStatus.value?.recommendationId,
          actionId: parentController.onGoingActivityStatus.value?.id,
        ),
      ),
    );
    ratedActivityOrFailure!.fold(
      (failure) {
        log('<----------- Rating Activity Operation failed ---------->');
      },
      (status) async {
        log('<----------- Rated Activity Successfully ---------->');
        await parentController.updateActivityStatusTrigger(
          actionStatus: ActionStatus.COMPLETED,
          acitivtyId: activityId,
        );
      },
    );
  }
}
