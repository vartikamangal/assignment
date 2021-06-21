// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/save-feedback.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';

// Project imports:
import '../../../../core/activity-management/data/models/feedback-model.dart';
import '../../../../core/activity-management/data/models/feedback-mood-model.dart';
import '../../../../core/activity-management/domain/usecases/rate-recommendation-flow.dart';
import '../../../../core/cache-manager/data/models/cache-acitivity-model.dart';
import '../../../../core/cache-manager/domain/usecases/cache-most-recent-acitivity.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-user-path.dart';
import '../../../../core/extensions/enum-to-string.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../../persistence-consts.dart';
import '../../data/models/activity-scedule-guided-model.dart';
import '../../data/models/activity-status-model.dart';
import '../../data/models/guided-activity-recommendation-model.dart';
import '../../data/models/recommendation-category-model.dart';
import '../../data/models/recommendation-model.dart';
import '../../domain/entities/activity-schedule-guided.dart';
import '../../domain/entities/activity-status.dart';
import '../../domain/entities/guided-activity-recommendation.dart';
import '../../domain/entities/recommendation-activity.dart';
import '../../domain/entities/recommendation-category.dart';
import '../../domain/entities/recommendation-step.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/usecases/get-activity-categories.dart';
import '../../domain/usecases/get-activity-schedule-for-guided-plan.dart';
import '../../domain/usecases/get-all-recommendation-categories.dart';
import '../../domain/usecases/persist-recommendation-feedback.dart';
import '../../domain/usecases/start-activity.dart';
import '../../domain/usecases/update-activity-status.dart';

enum ActionStatus {
  SCHEDULED_FOR_LATER,
  IN_PROGRESS,
  INPUT_GIVEN,
  AWAITING_FEEDBACK,
  COMPLETED,
  ABANDONED,
  SCHEDULED_BUT_NOT_DONE,
}

class PathController extends GetxController {
  /////// Usecases ////////////
  final GetAllRecommendationCategories getAllRecommendationCategories;
  final GetCategoryActivities getCategoryActivities;
  final StartActivity startActivity;
  final UpdateActivityStatus updateActivityStatus;
  final GetActivityScheduleForGuidedPlan getActivityScheduleForGuidedPlan;
  final PersistRecommendationFeedback persistRecommendationFeedback;
  final RateRecommendationFlow rateRecommendationFlow;
  final CacheMostRecentAcitivity cacheMostRecentAcitivity;
  final RetrieveUserPath retrieveUserPath;
  final SaveFeedback saveFeedback;

  PathController({
    @required this.getAllRecommendationCategories,
    @required this.getCategoryActivities,
    @required this.startActivity,
    @required this.updateActivityStatus,
    @required this.getActivityScheduleForGuidedPlan,
    @required this.persistRecommendationFeedback,
    @required this.rateRecommendationFlow,
    @required this.cacheMostRecentAcitivity,
    @required this.retrieveUserPath,
    @required this.saveFeedback,
  });
  /////// Dynamic Data Containers ////////////
  RxList<RecommendationCategory> recommendationCategories =
      RxList<RecommendationCategoryModel>(
    [],
  );
  RxList<Recommendation> recommendationActivities = RxList<RecommendationModel>(
    [],
  );

  //? From here we will get journeyId, actionId & recommendationId
  Rx<ActivityStatus> currentOngoingActivity = Rx<ActivityStatusModel>();

  Rx<ActivitySceduleGuided> guidedPlan = Rx<ActivityScheduleGuidedModel>();

  // data holder for user-selected-path
  RxString userSelectedPath = RxString('');

  final _voiceNoteController = Get.find<VoiceNoteController>();

  static const String activityType = 'RECOMMENDATION';

  /////// Usecase Helpers ////////////

  //! Gets the Self Driven Plan Data
  Future<void> fetchCategories() async {
    final fetchedCategoriesOrFailure =
        await getAllRecommendationCategories(NoParams());
    fetchedCategoriesOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedRecommendationcatgories) async {
        log('self driven plan fetched');
        recommendationCategories.assignAll(
          fetchedRecommendationcatgories,
        );
      },
    );
  }

  //! Gets the  Guided Activity Schedule
  Future<void> fetchGuidedPlanSchedule() async {
    final fetchedActivitiesOrFailure =
        await getActivityScheduleForGuidedPlan(NoParams());
    fetchedActivitiesOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedRecommendationcatgories) {
        log('guided plan activities fetched');
        guidedPlan.value = fetchedRecommendationcatgories;
      },
    );
  }

  Future<void> fetchCategoryActivitiesAndProceed({
    @required RecommendationCategoryModel categoryModel,
  }) async {
    toggleProcessor();
    final fetchedCategoryActivitiesOrFailure = await getCategoryActivities(
      GetCategoryActivitiesParams(
        category: categoryModel,
      ),
    );
    toggleProcessor();
    fetchedCategoryActivitiesOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedActivities) {
        recommendationActivities.assignAll(fetchedActivities);
        log('activities fetched, Now moving forward');
        selectedCategory.value = categoryModel;
        Get.toNamed(
          RouteName.pathSelfDrivenPlanInside,
        );
      },
    );
  }

  Future<void> startActivityTrigger(
      {@required String activityId, @required bool isInstantActivity}) async {
    toggleProcessor();
    final activityStatusOrFailure = await startActivity(
      StartAcitvityParams(
        recommendationId: activityId,
        isInstantActivity: isInstantActivity,
      ),
    );
    toggleProcessor();
    activityStatusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (activityStatus) {
        currentOngoingActivity.value = activityStatus;
        log('started activity{Server Message}');
      },
    );
  }

  Future<void> updateActivityStatusTrigger({
    @required ActionStatus actionStatus,
  }) async {
    toggleProcessor();
    final activityStatusOrFailure = await updateActivityStatus(
      UpdateActivityStatusParams(
        status: actionStatus.toString().enumToString(),
        actionId: currentOngoingActivity.value.id,
      ),
    );
    toggleProcessor();
    activityStatusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (activityStatus) async {
        // Cache the activity, if actionStatus is not Abandoned'
        if (actionStatus == ActionStatus.COMPLETED) {
          await cacheActivity();
        } else {
          log('not caching due to Status == !COMPLETE');
        }
        currentOngoingActivity.value = activityStatus;
        log('updated activity status to ${currentOngoingActivity.value.actionStatus}');
      },
    );
  }

  Future<void> cacheActivity() async {
    final activityCachedOrFailure = await cacheMostRecentAcitivity(
      CacheMostRecentAcitivityParams(
        acitivity: CacheAcitivityModel(
          //! Currenlty set to actionId
          id: currentOngoingActivity.value.id.toString(),
          title: selectedActivityTitle.value,
          subtitle: selectedActivitySubtitle.value,
          //TODO to be added later
          icon: '',
        ),
      ),
    );
    activityCachedOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (cacheStatus) => log(
        'recent activity cached',
      ),
    );
  }

  Future<void> persistFeedbacks() async {
    toggleProcessor();
    final persistedInputOrFailure = await persistRecommendationFeedback(
      PersistRecommendationFeedbackParams(
        activityStatusModel:
            currentOngoingActivity.value as ActivityStatusModel,
        textInput: userTextFeedback.value,
        voiceNoteInput: _voiceNoteController.currentVoiceNotePath.value,
      ),
    );
    toggleProcessor();
    persistedInputOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) async {
        _voiceNoteController.cleanVoiceFilePath();
        //! Later modify this if statement for the null voiceNOte check too
        if (userTextFeedback.value == '') {
          await updateActivityStatusTrigger(
            actionStatus: ActionStatus.AWAITING_FEEDBACK,
          );
        } else {
          await updateActivityStatusTrigger(
            actionStatus: ActionStatus.INPUT_GIVEN,
          );
        }
        Get.toNamed(
          RouteName.playSection1,
        );
        log(
          'recommendation status persisted & action status updated',
        );
      },
    );
  }

  Future<void> rateActivity({
    @required String mood,
    @required int elapsedTime,
  }) async {
    toggleProcessor();
    final ratedActivityOrFailure = await rateRecommendationFlow(
      RateRecommendationFlowParams(
        feedback: FeedbackModel(
          subjectMoodVO: FeedbackMoodModel(
            mood: mood,
            activityType: 'RECOMMENDATION',
          ),
          // Change this to a time tracker
          minutesSpent: elapsedTime,
          feedbackThoughts: userTextFeedback.value,
          recommendationId: currentOngoingActivity.value.recommendationId,
          actionId: currentOngoingActivity.value.id,
        ),
      ),
    );
    toggleProcessor();
    ratedActivityOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) async {
        log('recommendation flow response captured!');
        await updateActivityStatusTrigger(
          actionStatus: ActionStatus.COMPLETED,
        ).then(
          (value) => navigateBasedOnActivity(),
        );
      },
    );
  }

  Future<void> fetchUserPath() async {
    final userPathOrFailure = await retrieveUserPath(
      NoParams(),
    );
    userPathOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (userPath) {
        userSelectedPath.value = userPath;
      },
    );
  }

  /////// UI Management ////////////

  RxBool isLoading = RxBool(false);
  RxBool isProcessing = RxBool(false);
  RxString selectedOptionImage = RxString('');
  RxString head = RxString('');
  RxString activityDuration = RxString('');
  RxString selectedOption = RxString('');
  RxString userName = RxString('');
  RxString userTextFeedback = RxString('');
  Rx<RecommendationCategoryModel> selectedCategory =
      Rx<RecommendationCategoryModel>();
  RxInt maxActivityPerformingPages = RxInt(0);
  RxInt currentActivityPerformingPages = RxInt(0);
  Rx<Recommendation> selectedActivity = Rx<RecommendationModel>();
  // Above one was too diffenrent for GUIDED & S.D, that's why had to use this
  RxString selectedActivityTitle = RxString('');
  RxString selectedActivitySubtitle = RxString('');
  Rx<Widget> currentOngoingActivityScreen = Rx<Widget>(Container());
  RxMap<String, RecommendationStep> templateToRecommendationMapperSelf =
      RxMap({});
  RxMap<String, RecommendationStep> templateToRecommendationMapperGuided =
      RxMap({});
  Rx<GuidedActivityRecommendation> selectedDayPlan =
      Rx<GuidedActivityRecommendationModel>();

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  //* for changing and storing the dynamically typed recommendation-text-feedback
  // ignore: avoid_setters_without_getters
  set textFeedback(String feedback) {
    userTextFeedback.value = feedback;
  }

  // ignore: use_setters_to_change_properties
  //TODO Remove duplicacy for this content-mapping
  void setRecommendation({@required RecommendationModel recommendation}) {
    maxActivityPerformingPages.value =
        recommendation.activity.recommendationStepsVO.length;
    currentActivityPerformingPages.value = 0;
    selectedActivity.value = recommendation;
    selectedActivityTitle.value = recommendation.activity.title;
    selectedActivitySubtitle.value = recommendation.activity.subtitle;
    activityDuration.value =
        recommendation.activity.durationInMinutes.toString();
    // Below will add the activitySteps in a relational-mapper
    // This will avoid the problem of loops and WillPopScope on each page
    // And managing different states of index
    for (final activitySteps
        in selectedActivity.value.activity.recommendationStepsVO) {
      templateToRecommendationMapperSelf.addIf(
        activitySteps.stepName == 'CONTENT',
        'CONTENT',
        activitySteps,
      );
      templateToRecommendationMapperSelf.addIf(
        activitySteps.stepName == 'INSTRUCTIONS',
        'INSTRUCTIONS',
        activitySteps,
      );
      templateToRecommendationMapperSelf.addIf(
        activitySteps.stepName == 'DID_YOU_KNOW',
        'DID_YOU_KNOW',
        activitySteps,
      );
    }
  }

  void setGuidedActivityFlow({
    @required ActivityRecommendation recommendation,
    // helper for setting which activity is user performing currently
    @required int selectedActivityIndex,
  }) {
    activityDuration.value = recommendation.durationInMinutes.toString();
    selectedActivityTitle.value = recommendation.title;
    selectedActivitySubtitle.value = recommendation.subtitle;
    for (final activityFlowData in recommendation.recommendationStepsVO) {
      templateToRecommendationMapperGuided.addIf(
        activityFlowData.stepName == 'CONTENT',
        'CONTENT',
        activityFlowData,
      );
      templateToRecommendationMapperGuided.addIf(
        activityFlowData.stepName == 'INSTRUCTIONS',
        'INSTRUCTIONS',
        activityFlowData,
      );
      templateToRecommendationMapperGuided.addIf(
        activityFlowData.stepName == 'DID_YOU_KNOW',
        'DID_YOU_KNOW',
        activityFlowData,
      );
    }
  }

  // ignore: avoid_setters_without_getters
  set selectDay(GuidedActivityRecommendation recommendation) =>
      selectedDayPlan.value = recommendation;

  void changeCurrentActivityPage() {
    currentActivityPerformingPages.value == maxActivityPerformingPages.value
        ? currentActivityPerformingPages.value
        : currentActivityPerformingPages.value++;
  }

  void navigateBackHelper() {
    currentActivityPerformingPages.value == 0
        ? currentActivityPerformingPages.value
        : currentActivityPerformingPages.value--;
  }

  // The the activity being performed is instantActivity then you will be taken to the
  void navigateBasedOnActivity() {
    userSelectedPath.value == null
        ? Get.offNamedUntil(
            RouteName.rapportPages,
            (_) => false,
          )
        : Get.offAllNamed(
            RouteName.onBoardingIncomplete,
          );
  }

  Future<void> setup() async {
    toggleLoader();
    userName.value = await SessionManager.getPersistedUsername();
    await fetchUserPath();
    userSelectedPath.value == 'BIG_GOALS'
        ? await fetchGuidedPlanSchedule()
        : await fetchCategories();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await fetchUserPath();
  }
}
