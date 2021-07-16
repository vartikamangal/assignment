import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cache-acitivity-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/presentation/controllers/activity_cache_controller.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/entities/activity-step.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/start-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/domain/usecases/update-activity-status.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/content_page_controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/content_screen.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/did_you_know_screen.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/instructions_screen.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/ask_cofirmation_on_back_button_push.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';

import '../../../extensions/enum-to-string.dart';

enum ActionStatus {
  SCHEDULED_FOR_LATER,
  IN_PROGRESS,
  INPUT_GIVEN,
  AWAITING_FEEDBACK,
  COMPLETED,
  ABANDONED,
  SCHEDULED_BUT_NOT_DONE,
}

/// Signifies wheather user navigates back or forth during performing activity
enum NavAction { MoveForward, MoveBackWard }

final Map<String, Widget> stepNameToRoute = {
  "DID_YOU_KNOW": DidYouKnowScreen(),
  "INSTRUCTIONS": InstructionsScreen(),
  "CONTENT": ContentScreen(),
};

class PerformActivityController extends GetxController {
  final StartActivity startActivity;
  final UpdateActivityStatus updateActivityStatus;

  PerformActivityController({
    required this.startActivity,
    required this.updateActivityStatus,
  });

  /// Made it non-nullable because there won't exist any case
  /// where user has not clicked on any activity and perform-activity
  /// screens are being shown
  Rxn<Activity> activity = Rxn<Activity>();

  /// Keeps a hold of current active page's state
  Rx<PageState> activePageState = Rx(PageState.LOADING);

  RxInt activeStepSequence = RxInt(0);

  /// Holds data for various pages
  Rxn<ActivityStep> activeStep = Rxn();

  /// Holds status of current ongoing activity
  /// Helpful in modifying the status of the activity
  Rxn<ActivityStatus> onGoingActivityStatus = Rxn();

  /// Video/Audio Helpers
  final RxnBool _isPlayableComplete = RxnBool(true);

  /// Holds the active step's screen to be displayed
  Rx<Widget> activeStepScreen = Rx(EmptySpacePlaceHolder());

  /// Holds the status wheather the activity being
  /// performed is an instant activity or not
  RxBool isInstant = RxBool(false);

  /// Holds the text being typed by user in content-screen of activity-flow
  RxnString textFeedback = RxnString();

  /// Once user completes an antivity he will
  /// be redirected to this route
  final RxString _redirectRoute = RxString('/');

  set userTextFeedback(String feedback) {
    textFeedback.value = feedback;
  }

  /// Once the Audio/Video is completed playing
  /// The bottom Done btn will become visible
  bool get footerVisibility => _isPlayableComplete.value!;

  set footerVisibility(bool visibilty) {
    _isPlayableComplete.value = visibilty;
  }

  void initializeActivityAndProceed({
    required Activity activityToStart,
    required String redirectRoute,
    required bool isInstantActivity,
  }) {
    activity.value = activityToStart;
    isInstant.value = isInstantActivity;
    _redirectRoute.value = redirectRoute;
    final allStepsSupported = activity.value!.activitySteps.every(
      (step) => stepNameToRoute.keys.toList().contains(step.stepName),
    );
    if (allStepsSupported) {
      /// Initializes the init method of [ContentPageController]
      /// so that it can be ready with proper state when needed
      observeActiveStep();

      activePageState.value = PageState.LOADED;
      startActivityTrigger(
        activityId: activityToStart.id!,
        isInstantActivity: isInstantActivity,
      );
    } else {
      log("[ROUTE FAILURE]");
      activePageState.value = PageState.FAILURE;
    }
  }

  Future<void> startActivityTrigger({
    required String activityId,
    required bool isInstantActivity,
  }) async {
    final activityStatusOrFailure = await startActivity(
      StartAcitvityParams(
        recommendationId: activityId,
        isInstantActivity: isInstantActivity,
      ),
    );
    activityStatusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (activityStatus) {
        onGoingActivityStatus.value = activityStatus;
        log('<----------- Activity Started ---------->');
      },
    );
  }

  Future<void> updateActivityStatusTrigger({
    required ActionStatus actionStatus,
    required int acitivtyId,
  }) async {
    final activityStatusOrFailure = await updateActivityStatus(
      UpdateActivityStatusParams(
        status: actionStatus.toString().enumToString(),
        actionId: acitivtyId,
      ),
    );
    activityStatusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (activityStatus) async {
        // Cache the activity, if actionStatus is not Abandoned'
        if (actionStatus == ActionStatus.COMPLETED) {
          Get.find<ActivityCacheController>().cacheActivity(
            activity: CacheAcitivityModel.generateCachableModel(
              activityStatus: activityStatus,
              activity: activity.value!,
            ),
          );
        } else {
          log('not caching due to Status == !COMPLETE');
        }
        log('<----------- Activity status changed to ${actionStatus.toString().enumToString()} ----------->');
      },
    );
  }

  void changePage({required NavAction action}) {
    switch (action) {

      /// User wants to move ahead in flow
      case NavAction.MoveForward:
        activeStepSequence++;
        break;

      /// User wants to move backwards in flow
      case NavAction.MoveBackWard:
        activeStepSequence--;
        break;
    }
  }

  void navigatePostActivityCompletion() {
    log(_redirectRoute.value.toString());
    Get.offNamedUntil(_redirectRoute.value.toString(), (route) => false);
  }

  Future<void> resetPageState() async {
    activeStepSequence.value = 0;
    log("<--------- Activity Pages States restored -------->");
  }

  void observeActiveStep() {
    /// This runs only once during initialization
    activeStep.value = activity.value?.activitySteps.first;
    _setActiveStepScreen(activeStep.value!.stepName!);

    /// Whenever activeStepSequence changes, Auto-routing will be handled here
    activeStepSequence.stream.listen((change) {
      activeStep.value = activity.value?.activitySteps[change!];
      _setActiveStepScreen(activeStep.value!.stepName!);
    });
  }

  /// Changes the active activity step screen whenever
  /// stepSequence changes
  void _setActiveStepScreen(String stepName) {
    /// If the active screen is going to be
    /// CONTENT screen then we are initialzing the
    /// [ContentController] with relevent value of active step
    if (stepName == "CONTENT") {
      Get.find<ContentPageController>().initializeActivityContent(
        templateName: activeStep.value!.templateName!,
      );
    }
    activeStepScreen.value = stepNameToRoute[stepName]!;
  }

  /// Manages what to show to user when back button is pressed
  /// during performing and activity
  Future<bool> refreshStateOnBackButtonPress() async {
    if (activeStepSequence.value == 0) {
      return askConfirmation(
          acceptLabel: 'Yes',
          denyLabel: 'No',
          title: 'Do your really wish to stop this activity?',
          onDeny: () async {
            Navigator.of(Get.context!).pop(false);
          },
          onAccept: () async {
            await updateActivityStatusTrigger(
              actionStatus: ActionStatus.ABANDONED,
              acitivtyId: onGoingActivityStatus.value!.id!,
            );
            Navigator.of(Get.context!).pop(true);
          });
    } else {
      changePage(action: NavAction.MoveBackWard);
      return false;
    }
  }
}
