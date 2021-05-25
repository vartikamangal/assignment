import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/path/data/models/activity-scedule-guided-model.dart';
import 'package:tatsam_app_experimental/features/path/data/models/activity-status-model.dart';
import 'package:tatsam_app_experimental/features/path/data/models/guided-activity-recommendation-model.dart';
import 'package:tatsam_app_experimental/features/path/data/models/recommendation-model.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-schedule-guided.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/activity-status.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/guided-activity-recommendation.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/recommendation-step.dart';
import 'package:tatsam_app_experimental/features/path/domain/entities/recommendation.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/get-activity-schedule-for-guided-plan.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/start-activity.dart';
import 'package:tatsam_app_experimental/features/path/domain/usecases/update-activity-status.dart';
import 'package:tatsam_app_experimental/features/what-path-to-choose/presentation/controller/choose-path-controller.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../data/models/recommendation-category-model.dart';
import '../../domain/entities/recommendation-category.dart';
import '../../domain/usecases/get-activity-categories.dart';
import '../../domain/usecases/get-all-recommendation-categories.dart';

//!  Helps in manipulating the status of any started activty
//? {Only for refrence}
// enum ActionStatus {
//   SCHEDULED_FOR_LATER,
//   IN_PROGRESS,
//   INPUT_GIVEN,
//   AWAITING_FEEDBACK,
//   COMPLETED,
//   ABANDONED,
// }

class PathController extends GetxController {
  /////// Usecases ////////////
  final GetAllRecommendationCategories getAllRecommendationCategories;
  final GetCategoryActivities getCategoryActivities;
  final StartActivity startActivity;
  final UpdateActivityStatus updateActivityStatus;
  final GetActivityScheduleForGuidedPlan getActivityScheduleForGuidedPlan;

  PathController({
    @required this.getAllRecommendationCategories,
    @required this.getCategoryActivities,
    @required this.startActivity,
    @required this.updateActivityStatus,
    @required this.getActivityScheduleForGuidedPlan,
  });
  /////// Dynamic Data Containers ////////////
  RxList<RecommendationCategory> recommendationCategories =
      RxList<RecommendationCategoryModel>(
    [],
  );
  RxList<Recommendation> recommendationActivities = RxList<RecommendationModel>(
    [],
  );
  Rx<ActivityStatus> currentOngoingActivity = Rx<ActivityStatusModel>();
  Rx<ActivitySceduleGuided> guidedPlan = Rx<ActivityScheduleGuidedModel>();

  /////// Usecase Helpers ////////////

  //! Gets the Self Driven Plan Data
  Future<void> fetchCategories() async {
    final fetchedCategoriesOrFailure =
        await getAllRecommendationCategories(NoParams());
    fetchedCategoriesOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
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
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
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
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
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

  Future<void> startActivityTrigger({@required String activityId}) async {
    toggleProcessor();
    final activityStatusOrFailure = await startActivity(
      StartAcitvityParams(
        recommendationId: activityId,
      ),
    );
    toggleProcessor();
    activityStatusOrFailure.fold(
      (failure) {
        log(failure.toString());
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
      },
      (activityStatus) {
        currentOngoingActivity.value = activityStatus;
        log('started activity{Server Message}');
      },
    );
  }

  //! Currently valid only for suspending activity
  Future<void> updateActivityStatusTrigger() async {
    final activityStatusOrFailure = await updateActivityStatus(
      UpdateActivityStatusParams(
        status: "ABANDONED",
        actionId: currentOngoingActivity.value.id,
      ),
    );
    activityStatusOrFailure.fold(
      (failure) {
        log(failure.toString());
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
      },
      (activityStatus) {
        currentOngoingActivity.value = activityStatus;
        log('updated activity status to ${currentOngoingActivity.value.actionStatus}');
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
  Rx<RecommendationCategoryModel> selectedCategory =
      Rx<RecommendationCategoryModel>();
  RxInt maxActivityPerformingPages = RxInt(0);
  RxInt currentActivityPerformingPages = RxInt(0);
  Rx<Recommendation> selectedActivity = Rx<RecommendationModel>();
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

  // ignore: use_setters_to_change_properties
  void setRecommendation({@required RecommendationModel recommendation}) {
    maxActivityPerformingPages.value =
        recommendation.activity.recommendationStepsVO.length;
    currentActivityPerformingPages.value = 0;
    selectedActivity.value = recommendation;
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
  }) {
    activityDuration.value = recommendation.durationInMinutes.toString();
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

  Future<void> setup() async {
    toggleLoader();
    final selectedJounrey =
        Get.find<ChoosePathController>().selectedJourney.value;
    selectedJounrey.pathName == 'SMALL_WINS'
        ? await fetchCategories()
        : await fetchGuidedPlanSchedule();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
