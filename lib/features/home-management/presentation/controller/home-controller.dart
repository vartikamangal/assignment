// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/activity_rating_model.dart';
import 'package:tatsam_app_experimental/core/perform-activity/data/models/mood-feedback-model-for-activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/controller/hub-controller.dart';

import '../../../../core/activity/domain/entities/activity.dart';
import '../../../../core/activity/domain/entities/recommendation-category.dart';
import '../../../../core/activity/domain/entities/recommendation.dart';
import '../../../../core/activity/domain/usecases/get-activity-categories.dart';
import '../../../../core/activity/domain/usecases/get-all-recommendation-categories.dart';
import '../../../../core/cache-manager/data/models/cache-acitivity-model.dart';
import '../../../../core/cache-manager/domain/usecases/check-if-first-time-user.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-last-logged-app-init.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-most-recent-activity.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-user-path.dart';
import '../../../../core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import '../../../../core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';
import '../../../../core/cache-manager/domain/usecases/save-user-onboarding-status.dart';
import '../../../../core/duration-tracker/data/models/app-duration-model.dart';
import '../../../../core/duration-tracker/domain/entities/app-duration.dart';
import '../../../../core/duration-tracker/domain/usecases/get-last-login.dart';
import '../../../../core/duration-tracker/domain/usecases/update-user-duration-on-app.dart';
import '../../../../core/extensions/enum-to-string.dart';
import '../../../../core/perform-activity/domain/usecases/rate-activity.dart';
import '../../../../core/perform-activity/domain/usecases/update-activity-status.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../features/home-management/data/models/post-onboparding-action-model.dart';
import '../../../../features/home-management/domain/entities/post-onboarding-action.dart';
import '../../../../features/home-management/domain/usecases/add-weekly-activity.dart';
import '../../../../features/home-management/domain/usecases/add-weekly-category.dart';
import '../../../../features/home-management/domain/usecases/get-action-with-action-status.dart';
import '../../../../features/home-management/domain/usecases/get-mood-popup-shown-status.dart';
import '../../../../features/home-management/domain/usecases/get-recommendations-by-action-time.dart';
import '../../../../features/home-management/domain/usecases/toggle-mood-popup-shown-state.dart';
import '../../../../features/home-management/presentation/widgets/daily-mood-bottom-sheet.dart';
import '../../../../features/rapport-building/domain/usecases/get-all-moods.dart';
import '../../../../features/rapport-building/domain/usecases/set-subject-mood.dart';

enum OnboardingStatus {
  INCOMPLETE,
  COMPLETE,
}

class HomeController extends GetxController {
  //? Self -> DO_NOW activities are returned in form of List<ActivityRecommendfation>
  //! Usecases
  final RetrieveMostRecentActivity retrieveMostRecentActivity;
  final RetrieveUserPath retrieveUserPath;
  final GetRecommendationsByActionTime getRecommendationsByActionTime;
  /// usecase for saving user's onboardeing staus
  final SaveUserOnboardingStatus userOnboardingStatus;

  /// Usecase for retrieving onboarding status
  final RetrieveUserOnboardingStatus retrieveUserOnboardingStatus;
  final GetActionWithActionStatus getActionWithActionStatus;
  final SaveIsFirstTimeOnboardingStatus saveIsFirstTimeOnboardingStatus;
  final CheckIfFirstTimeUser checkIfFirstTimeUser;
  final RateActivity rateRecommendationFlow;
  final UpdateActivityStatus updateActivityStatus;
  final GetAllRecommendationCategories getAllRecommendationCategories;
  final GetCategoryActivities getCategoryActivities;
  final AddWeeklyCategory addWeeklyCategory;
  final AddWeeklyActivity addWeeklyActivity;
  final UpdateUserDurationOnApp userDurationOnApp;
  final GetAllMoods getAllMoods;
  final SetSubjectMood setSubjectMood;
  // Only applies for weekend
  final GetLastLogin getLastLogin;
  final GetIsMoodPopupShownStatus getIsMoodPopupShownStatus;
  final ToggleMoodPopupShownState toggleMoodPopupShownState;
  final RetirieveLastLoggedAppInit retirieveLastLoggedAppInit;

  HomeController({
    required this.retrieveMostRecentActivity,
    required this.retrieveUserPath,
    required this.retrieveUserOnboardingStatus,
    required this.userOnboardingStatus,
    required this.getRecommendationsByActionTime,
    required this.getActionWithActionStatus,
    required this.saveIsFirstTimeOnboardingStatus,
    required this.checkIfFirstTimeUser,
    required this.rateRecommendationFlow,
    required this.updateActivityStatus,
    required this.getAllRecommendationCategories,
    required this.getCategoryActivities,
    required this.addWeeklyCategory,
    required this.addWeeklyActivity,
    required this.userDurationOnApp,
    required this.getLastLogin,
    required this.getAllMoods,
    required this.setSubjectMood,
    required this.getIsMoodPopupShownStatus,
    required this.toggleMoodPopupShownState,
    required this.retirieveLastLoggedAppInit,
  });
  //! Dynamic Data Holders
  static const String activityTypeHomepage = 'APP_OPEN';
  final Rxn<CacheAcitivityModel> mostRecentAcitivity =
      Rxn<CacheAcitivityModel>();
  final RxList<Activity> recommendedActivities = RxList(
    [],
  );

  /// Optional container
  /// Will hold the actions if user has onboarded and,scheduled an activity for later
  final RxList<PostOnboardingAction> actionsIfOnboarded =
      RxList<PostOnboardingActionModel>(
    [],
  );

  final RxList<RecommendationCategory> categoriesForWeeklyFeedback = RxList(
    [],
  );

  final RxList<Recommendation> subActivitesOfCategories = RxList(
    [],
  );

  //! Usecases helper functions

  Future<void> retrieveCachedMood() async {
    // final moodOrFailure = await getCachedMood(
    //   NoParams(),
    // );
    // moodOrFailure.fold(
    //   (failure) {
    //     ErrorInfo.show(failure);
    //   },
    //   (cachedMood) {
    //     userMood.value = cachedMood;
    //     log(
    //       cachedMood.toString(),
    //     );
    //   },
    // );
    final HubController _controller = Get.find();
    await _controller.fetchHubStatus();
    userMood.value = _controller.hubStatus.value!.userMood!.toLowerCase();
  }

  /// Will give the persisted value of last successfull activity completed by user
  Future<void> fetchMostRecentActivity() async {
    final mostRecentAcitivityOrFailure = await retrieveMostRecentActivity(
      NoParams(),
    );
    mostRecentAcitivityOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (cachedActivity) {
        mostRecentAcitivity.value = cachedActivity;
      },
    );
  }

  /// Will give the persisted value of path which user chose on the What-path-to-choose screen
  Future<void> getUserOptedPath() async {
    final optedPathOrFailure = await retrieveUserPath(
      NoParams(),
    );
    optedPathOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (optedPath) {
        chosenPath.value = optedPath;
      },
    );
  }

  /// Will mark user as onboarded, in the initState of the homescreen
  Future<void> markUserAsOnboarded() async {
    final cacheStausOrFailure = await userOnboardingStatus(
      SaveUserOnboardingStatusParams(
        status: OnboardingStatus.COMPLETE.toString().enumToString(),
      ),
    );
    cacheStausOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (cacheStatus) {
        log('onboarding status cached');
      },
    );
  }

  Future<void> fetchRecommendedActivities() async {
    final recommendedActivitiesOrFailure = await getRecommendationsByActionTime(
      const GetRecommendationsByActionTimeParams(
        actionTime: 'DO_NOW',
      ),
    );
    recommendedActivitiesOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedRecommendedActivities) {
        /// Change logic here if you want to tweak number of recommended activities shown
        /// If there are more than 3 activites present in response
        if (fetchedRecommendedActivities.length > 3) {
          /// Add only 3 of them to the showing list
          for (int i = 0; i < 3; i++) {
            recommendedActivities.add(fetchedRecommendedActivities[i]);
          }
        } else {
          recommendedActivities.assignAll(fetchedRecommendedActivities);
        }

        /// Uncomment the below LOC's for showing all activites irrespective of their length
        // recommendedActivities.assignAll(
        //   fetchedRecommendedActivities,
        // );
        log('recommeded activities fetched');
      },
    );
  }

  Future<void> fetchUserOnbaordingStatus() async {
    final onBoardingStatusOrFailure = await retrieveUserOnboardingStatus(
      NoParams(),
    );
    onBoardingStatusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedStatus) {
        if (fetchedStatus == 'COMPLETE') {
          isOnboarded.value = true;
        } else {
          isOnboarded.value = false;
        }
      },
    );
  }

  /// To be only called if user has onboarded and opening app for second time or later
  Future<void> retrievePostOnboardingActions() async {
    final postOnboardingActionsOrFailure = await getActionWithActionStatus(
      GetActionWithActionStatusParams(
        actionStatus:
            ActionStatus.SCHEDULED_FOR_LATER.toString().enumToString(),
      ),
    );
    postOnboardingActionsOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (recievedActions) {
        actionsIfOnboarded.assignAll(
          recievedActions,
        );
        setupPostActionFeedbacks(
          actions: actionsIfOnboarded as List<PostOnboardingActionModel>,
        );
      },
    );
  }

  /// YES-> onboarded, NO/null-> not onboarded
  Future<void> markAsFirstTimeUser() async {
    final markedOrFailure = await saveIsFirstTimeOnboardingStatus(
      const SaveIsFirstTimeOnboardingStatusParams(
        onBoardingStatus: 'YES',
      ),
    );
    markedOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (saveStatus) {
        log('saved isFirstTime status');
      },
    );
  }

  /// false -> onboarded, true -> not onboarded
  Future<void> checkIfFirstTime() async {
    final markedOrFailure = await checkIfFirstTimeUser(
      NoParams(),
    );
    markedOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (isFirstTime) {
        log('USER VISITING PAGE FOR THE FIRST TIME : $isFirstTime');
        isFirstTimeUser.value = isFirstTime;
      },
    );
  }

  Future<void> fulfillActionStatus({required String? mood}) async {
    toggleProcessor();
    final ratedActionOrFailure = await rateRecommendationFlow(
      RateActivityParams(
        feedback: ActivityRatingModel(
          actionId: currentActivePostOnboardingFeedbackAction.value!.actionId,
          //! coz. not necessary
          recommendationId: '',
          feedbackThoughts: '',
          subjectMoodVO: MoodFeedbackModelForActivity(
            activityType: 'RECOMMENDATION',
            mood: mood,
          ),
          //! Still to figure out for schedule for later items
          minutesSpent: 0,
        ),
      ),
    );
    toggleProcessor();
    ratedActionOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) async {
        log('action fulfilled successfully');
        await changeActionStatus(
          actionStatus: ActionStatus.COMPLETED,
        );
      },
    );
  }

  Future<void> changeActionStatus({required ActionStatus actionStatus}) async {
    toggleProcessor();
    final updatedActionStatusOrFailure = await updateActivityStatus(
      UpdateActivityStatusParams(
        status: actionStatus.toString().enumToString(),

        /// -1 represents no value
        actionId:
            currentActivePostOnboardingFeedbackAction.value!.actionId ?? -1,
      ),
    );
    toggleProcessor();
    updatedActionStatusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (modificationStatus) {
        log(
          "${currentActivePostOnboardingFeedbackAction.value!.actionId.toString()} modified to ${actionStatus.toString().enumToString()} successfully",
        );
        updatePostOnboardingAction();
      },
    );
  }

  /// Would be helpful in weekdays feedbacks
  /// Only runs on Weekend
  Future<void> retrieveAllRecommendationCategories() async {
    //! Replace the getActioveDay() on RHS with wekeendDayCode for production
    final bool weekdayAndUserIsNotNew =
        getActiveDay() == getActiveDay() && !isFirstTimeUser.value;
    if (weekdayAndUserIsNotNew) {
      final categoriesOrFailure = await getAllRecommendationCategories(
        NoParams(),
      );
      categoriesOrFailure!.fold(
        (failure) {
          ErrorInfo.show(failure);
        },
        (categories) {
          categoriesForWeeklyFeedback.assignAll(
            categories,
          );
          toShowCategories.value = true;
          log('recommendation categories fetched');
        },
      );
    } else {
      log('not weekend or new user, so skipping the fetch categories part');
    }
  }

  /// Should be called when user clicks on any of the above obtained category pills
  /// Adds the category passed to the category list and Then fetches the activities for that category
  Future<void> fetchAcitivitiesForCategory({
    required RecommendationCategory category,
  }) async {
    toggleProcessor();
    await addToWeeklyCategory(
      category: category,
    ).then((value) async {
      final activitiesOrFailure = await getCategoryActivities(
        GetCategoryActivitiesParams(
          category: category,
        ),
      );
      toggleProcessor();
      activitiesOrFailure!.fold(
        (failure) {
          ErrorInfo.show(failure);
        },
        (activities) {
          subActivitesOfCategories.assignAll(
            activities,
          );
          haveChosenCategory.value = true;
          log(
            'activities fetched for respective category',
          );
        },
      );
    });
  }

  Future<void> addToWeeklyCategory({
    required RecommendationCategory category,
  }) async {
    final statusOrFailure = await addWeeklyCategory(
      AddWeeklyCategoryParams(
        weekNumber: appDuration.value!.currentWeekday,
        category: category,
      ),
    );
    statusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) {
        log(
          'added category to server successfully',
        );
      },
    );
  }

  Future<void> updateWeeklyActivity({
    required String category,
    required String? recommendationId,
  }) async {
    final statusOrFailure = await addWeeklyActivity(
      AddWeeklyActivityParams(
        category: category,
        recommendationId: recommendationId,
      ),
    );
    statusOrFailure!.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) {
        log(
          'added activity to server successfully',
        );
        toShowCategories.value = false;
      },
    );
  }

  Future<void> setUserDurationOnApp() async {
    final failureOSuccess = await userDurationOnApp(
      UpdateUserDurationOnAppParams(
        userDurationOnApp: AppDurationModel(
          lastLogin: DateTime.now(),
          currentWeekday: DateTime.now().weekday,
        ),
        // ignore: avoid_bool_literals_in_conditional_expressions
        isNewUser: isFirstTimeUser.value ? true : false,
      ),
    );
    failureOSuccess.fold(
      (f) {
        log('problem in updating the app-duration-model');
      },
      (r) {
        log('duration operation done');
      },
    );
  }

  Future<void> fetchLastWeekendLogin() async {
    final failureOrSuccess = await getLastLogin(
      NoParams(),
    );
    failureOrSuccess.fold(
      (f) {
        log('unable to fetch last login date');
      },
      (r) {
        appDuration.value = r;
        log(r.currentWeekday.toString());
      },
    );
  }

  // Helper for checking whether we have shown the mood-feedback modal today
  Future<void> getIsMoodShownState() async {
    final failureOrResult = await getIsMoodPopupShownStatus(
      NoParams(),
    );
    failureOrResult.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (r) {
        log(r.toString());
        isFirstTimeUser.value ? log('skip') : showDailyPopup();
        //TODO Uncomment for production
        // r ? log("today's popup already shown") : showDailyPopup();
      },
    );
  }

  // To be called once onInit and again after the popup is dismissed or mood is rated
  Future<void> toggleIsMoodShownState() async {
    final failureOrResult = await toggleMoodPopupShownState(
      NoParams(),
    );
    failureOrResult.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (cacheStatus) {
        log('onboarding status cached');
      },
    );
  }

  void showDailyPopup() {
    Get.bottomSheet(DailyMoodBottomSheet());
  }

  Future<void> popupSetMoodAssist({required String? moodName}) async {
    // Enable loader
    isRating.value = true;
    final resultOrFailure = await setSubjectMood(
      SetSubjectMoodParams(
        moodName: moodName,
        activityType: activityTypeHomepage,
      ),
    );
    isRating.value = false;
    resultOrFailure!.fold(
      (f) {
        log(f.toString());
        log('rating failed');
      },
      (r) async {
        log('rating-successfull');
        await toggleIsMoodShownState().then(
          (value) => Get.back(),
        );
      },
    );
  }

  //! UI management variables
  RxBool isLoading = RxBool(false);
  RxBool isProcessing = RxBool(false);
  RxBool isRating = RxBool(false);
  RxBool isFirstTimeUser = RxBool(true);
  RxBool fulfilledAllPostOnboardingActions = RxBool(true);
  RxBool toShowCategories = RxBool(false);
  RxBool haveChosenCategory = RxBool(false);
  RxString userNickname = RxString('');
  RxString chosenPath = RxString('');
  RxString userMood = RxString('');
  Rxn<AppDuration> appDuration = Rxn<AppDurationModel>();

  /// Gives the length of all the remaining feedback actions
  /// obtained via SCHJEDULED_FOR_LATER flag
  RxnInt totalFeedbackActions = RxnInt();
  RxInt answeredFeedbackActions = RxInt(0);

  /// Reprsents the active indicator value
  RxInt currentActiveIndicator = RxInt(0);

  /// Reactive variable for storing cached userOnboarding status
  RxBool isOnboarded = RxBool(false);

  /// saves the current active feedback module
  Rxn<PostOnboardingAction> currentActivePostOnboardingFeedbackAction =
      Rxn<PostOnboardingActionModel>();

  // For showing in ui
  final List<String> daysToBeShownInUI = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  //! UI managements functions
  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  // ignore: avoid_setters_without_getters
  set updateIndicator(int newIndex) {
    currentActiveIndicator.value = newIndex;
  }

  Future<void> fetchNickname() async {
    userNickname.value = await SessionManager.getPersistedUsername();
  }

  String getActiveDay() {
    final dayToday = (DateTime.now().weekday) - 1;
    return daysToBeShownInUI[dayToday];
  }

  void setupPostActionFeedbacks({
    required List<PostOnboardingActionModel> actions,
  }) {
    fulfilledAllPostOnboardingActions.value = false;
    totalFeedbackActions.value = actions.length;
    if (actions.isNotEmpty) {
      currentActivePostOnboardingFeedbackAction.value =
          actions[answeredFeedbackActions.value];
    } else {
      log('NO ACTIONS TO FULFILL');
      fulfilledAllPostOnboardingActions.value = true;
    }
  }

  void updatePostOnboardingAction() {
    if (answeredFeedbackActions.value < totalFeedbackActions.value! - 1) {
      answeredFeedbackActions.value++;
      currentActivePostOnboardingFeedbackAction.value =
          actionsIfOnboarded[answeredFeedbackActions.value];
    } else {
      fulfilledAllPostOnboardingActions.value = true;
      log('no more actions remaiing to be fulfilled');
    }
  }

  //? Initial Setup manager
  Future<void> setup() async {
    toggleLoader();
    await retrieveCachedMood();
    await fetchNickname();
    await fetchMostRecentActivity();
    await getUserOptedPath();
    await markUserAsOnboarded();
    //await markAsFirstTimeUser();
    await fetchRecommendedActivities();
    await fetchUserOnbaordingStatus();
    await checkIfFirstTime();
    await setUserDurationOnApp();
    await fetchLastWeekendLogin();
    await retrievePostOnboardingActions();
    await retrieveAllRecommendationCategories();
    await getIsMoodShownState();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
