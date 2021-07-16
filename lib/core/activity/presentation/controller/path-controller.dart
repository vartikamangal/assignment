// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';

// Project imports:
import '../../../../core/cache-manager/domain/usecases/retireve-user-path.dart';
import '../../../../core/error/display-error-info.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../perform-activity/domain/entities/activity-status.dart';
import '../../domain/entities/activity-schedule-guided.dart';
import '../../domain/entities/guided-activity-recommendation.dart';
import '../../domain/entities/recommendation-category.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/usecases/get-activity-categories.dart';
import '../../domain/usecases/get-activity-schedule-for-guided-plan.dart';
import '../../domain/usecases/get-all-recommendation-categories.dart';

class PathController extends GetxController {
  /////// Usecases ////////////
  final GetAllRecommendationCategories getAllRecommendationCategories;
  final GetCategoryActivities getCategoryActivities;
  final GetActivityScheduleForGuidedPlan getActivityScheduleForGuidedPlan;
  final RetrieveUserPath retrieveUserPath;

  PathController({
    required this.getAllRecommendationCategories,
    required this.getCategoryActivities,
    required this.getActivityScheduleForGuidedPlan,
    required this.retrieveUserPath,
  });
  /////// Dynamic Data Containers ////////////
  RxList<RecommendationCategory> recommendationCategories = RxList(
    [],
  );
  RxList<Recommendation> recommendationActivities = RxList(
    [],
  );

  //? From here we will get journeyId, actionId & recommendationId
  Rxn<ActivityStatus> currentOngoingActivity = Rxn();

  Rxn<ActivitySceduleGuided> guidedPlan = Rxn();

  // Holds page state
  Rx<PageState> pageState = Rx(PageState.LOADING);

  // data holder for user-selected-path
  RxString userSelectedPath = RxString('');

  static const String activityType = 'RECOMMENDATION';

  /////// Usecase Helpers ////////////

  //! Gets the Self Driven Plan Data
  Future<void> fetchCategories() async {
    pageState.value = PageState.LOADING;
    final fetchedCategoriesOrFailure =
        await getAllRecommendationCategories(NoParams());
    fetchedCategoriesOrFailure!.fold(
      (failure) {
        pageState.value = PageState.FAILURE;
        log(
          "<----- Problems in fetching plan from server ----->",
          error: failure,
        );
      },
      (fetchedRecommendationcatgories) async {
        recommendationCategories.assignAll(
          fetchedRecommendationcatgories,
        );
        pageState.value = PageState.LOADED;
        log('self driven plan fetched');
      },
    );
  }

  //! Gets the  Guided Activity Schedule
  Future<void> fetchGuidedPlanSchedule() async {
    final fetchedActivitiesOrFailure =
        await getActivityScheduleForGuidedPlan(NoParams());
    fetchedActivitiesOrFailure!.fold(
      (failure) {
        pageState.value = PageState.FAILURE;
        log(
          "<----- Problems in fetching plan from server ----->",
          error: failure,
        );
      },
      (fetchedRecommendationcatgories) {
        guidedPlan.value = fetchedRecommendationcatgories;
        pageState.value = PageState.LOADED;
        log('guided plan activities fetched');
      },
    );
  }

  /// Fetches the Self Driven activies and then navigates to Plan details
  Future<void> fetchCategoryActivitiesAndProceed({
    required RecommendationCategory category,
  }) async {
    toggleProcessor();
    final fetchedCategoryActivitiesOrFailure = await getCategoryActivities(
      GetCategoryActivitiesParams(
        category: category,
      ),
    );
    toggleProcessor();
    fetchedCategoryActivitiesOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedActivities) {
        recommendationActivities.assignAll(fetchedActivities);
        log('activities fetched, Now moving forward');
        selectedCategory.value = category;
        Get.toNamed(
          RouteName.pathSelfDrivenPlanInside,
        );
      },
    );
  }

  Future<void> fetchUserPath() async {
    final userPathOrFailure = await retrieveUserPath(
      NoParams(),
    );
    userPathOrFailure!.fold(
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
  RxString activityDuration = RxString('');
  RxString selectedOption = RxString('');
  RxString userName = RxString('');
  RxString userTextFeedback = RxString('');
  Rxn<RecommendationCategory> selectedCategory = Rxn();
  Rxn<GuidedActivityRecommendation> selectedDayPlan = Rxn();

  ///for focus on text field
  RxBool isFocusOn = RxBool(false);

  void focusChanged() {
    isFocusOn.value = true;
  }

  void focusCancelled() {
    isFocusOn.value = false;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  //* for changing and storing the dynamically typed recommendation-text-feedback
  set textFeedback(String feedback) {
    userTextFeedback.value = feedback;
  }

  set selectDay(GuidedActivityRecommendation recommendation) =>
      selectedDayPlan.value = recommendation;

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
    //TODO Do the fetchUserPath at needed Stateful widget,
    //TODO its creating problems here
  }
}
