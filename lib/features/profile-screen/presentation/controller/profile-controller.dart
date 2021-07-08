// Flutter imports:

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../../core/activity/data/models/recommendation-input-model.dart';
import '../../../../core/activity/domain/entities/recommendation-input.dart';
import '../../../../core/activity/domain/usecases/get-persisted-feedbacks.dart';
import '../../../../core/error/display-error-info.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../features/home-management/data/models/post-onboparding-action-model.dart';
import '../../../../features/home-management/domain/entities/post-onboarding-action.dart';
import '../../../../features/home-management/domain/usecases/get-action-with-action-status.dart';
import '../../../../features/hub/data/models/hub-status-model.dart';
import '../../../../features/hub/domain/entities/hub-status.dart';
import '../../../../features/profile-screen/data/models/profile-data-model.dart';
import '../../../../features/profile-screen/data/models/question-log-model.dart';
import '../../../../features/profile-screen/domain/entities/profile-data.dart';
import '../../../../features/profile-screen/domain/entities/question-log.dart';
import '../../../../features/profile-screen/domain/usecases/get-basic-profile-details.dart';
import '../../../../features/profile-screen/domain/usecases/get-mood-logs.dart';
import '../../../../features/profile-screen/domain/usecases/get-profile-questions.dart';
import '../../../../features/profile-screen/domain/usecases/get-profile-wheel-of-life-data.dart';
import '../../../../features/profile-screen/presentation/widget/linear-mood-chart.dart';
import '../../../../features/profile-screen/presentation/widget/wol-pie-chart.dart';
import '../../../../features/rapport-building/data/models/mood-tracking-model.dart';
import '../../../../features/rapport-building/domain/entities/mood-tracking.dart';

class ProfileController extends GetxController {
  // Usecases
  final GetBasicProfileDetails getBasicProfileDetails;
  final GetMoodLogs getMoodLogs;
  final GetProfileQuestions getProfileQuestions;
  final GetProfileWheelOfLifeData getProfileWheelOfLifeData;
  final GetPersistedFeedbacks getPersistedFeedbacks;
  final GetActionWithActionStatus getActionWithActionStatus;

  ProfileController({
    required this.getBasicProfileDetails,
    required this.getMoodLogs,
    required this.getProfileQuestions,
    required this.getProfileWheelOfLifeData,
    required this.getPersistedFeedbacks,
    required this.getActionWithActionStatus,
  });

  // Dynamic data holders
  Rxn<ProfileData> profileData = Rxn<ProfileDataModel>();
  Rxn<HubStatus> hubStatus = Rxn<HubStatusModel>();
  RxList<MoodTracking> moodLogs = RxList<MoodTrackingModel>([]);
  RxList<QuestionLog> questionLogs = RxList<QuestionLogModel>([]);
  RxList<RecommendationInput> diaryLogs = RxList<RecommendationInputModel>([]);
  RxList<PostOnboardingAction> actions = RxList<PostOnboardingActionModel>([]);
  // For getting status of dropdown
  RxBool isDropDownExpanded = RxBool(false);
//text editing controller
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController nicknameEditingController =
      TextEditingController();
  final TextEditingController dobEditingController = TextEditingController();

  void toggleDropDownExpansion() {
    isDropDownExpanded.value = !isDropDownExpanded.value;
  }

  // Usecase helpers
  Future<void> fetchBasicProfileData() async {
    final failureOrResult = await getBasicProfileDetails(NoParams());
    failureOrResult!.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        profileData.value = r;
      },
    );
  }

  Future<void> fetchMoodLogs() async {
    final failureOrResult = await getMoodLogs(NoParams());
    failureOrResult!.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        moodLogs.assignAll(r);
        parseQuestionLogsForLinearChart();
      },
    );
  }

  Future<void> fetchQuestionLogs() async {
    final failureOrResult = await getProfileQuestions(NoParams());
    failureOrResult!.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        questionLogs.assignAll(r);
      },
    );
  }

  Future<void> fetchWheelOfLifeData() async {
    final failureOrResult = await getProfileWheelOfLifeData(NoParams());
    failureOrResult!.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        hubStatus.value = r;
        prepareWolLogsForPieChart();
        parseWolLogsForPieChart();
        parseDisplayedChartAreas();
        //filterPieChartData();
        displayedLifeAreas.add('ROMANCE');
      },
    );
  }

  Future<void> fetchDiaryLogs() async {
    final failureOrResult = await getPersistedFeedbacks(NoParams());
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        diaryLogs.assignAll(r);
      },
    );
  }

  Future<void> fetchActionWithActionStatus() async {
    final failureOrResult = await getActionWithActionStatus(
      const GetActionWithActionStatusParams(
        actionStatus: 'COMPLETED',
      ),
    );
    failureOrResult!.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        actions.assignAll(r);
        _prepareMapperForActions();
      },
    );
  }

  /// creates a Map<[int],[PostOnboardingAction]> for making available activityName and moodName in Diary
  void _prepareMapperForActions() {
    actions.forEach(
      (action) {
        actionIdToActionMap.addIf(
          true,
          action.actionId!,
          action,
        );
      },
    );
  }

  /// UI managers
  RxBool isLoading = RxBool(false);
  RxBool isProcessing = RxBool(false);
  RxInt selectedScreenIndex = 0.obs;
  Rxn<Widget> currentSelectedPage = Rxn<Widget>();
  RxString userName = RxString('');
  RxMap<int, RecommendationInput> actionIdToDiaryLogMap =
      RxMap<int, RecommendationInputModel>();
  RxMap<int, PostOnboardingAction> actionIdToActionMap =
      RxMap<int, PostOnboardingActionModel>();

  /// will hold x&y co-ordinates in form of [ChartData]
  /// here x signifies entry number and y signifies mood-rating-value
  RxList<ChartData> linearChartData = RxList<ChartData>([]);

  /// Holds <String,int> value for mood, which assists in linear chart
  static Map<String, double> moodMap = {
    "VERY_BAD": 1,
    "BAD": 2,
    "NEUTRAL": 3,
    "GOOD": 4,
    "VERY_GOOD": 5,
  };

  /// data container for Piechart
  static Map<String, int> pieChartMap = {};

  /// holds a list of all [WOLAreaData], later populated for pie chart construction
  RxList<WOLAreaData> allPieChartData = RxList<WOLAreaData>([]);

  /// holds a list of currently shown [WOLAreaData], later populated for pie chart construction
  RxList<WOLAreaData> pieChartData = RxList<WOLAreaData>([]);

  /// displayed areas on pie chart
  RxList<String> displayedLifeAreas = RxList<String>([]);

  /// getter for test of dynamic length problem
  RxInt get displayedAreaLength => RxInt(displayedLifeAreas.length);

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  Future<void> selectScreen(int index) async {
    selectedScreenIndex.value = index;
  }

  /// creates a list of [ChartData] for constructing the linear chart
  void parseQuestionLogsForLinearChart() {
    for (int i = 0; i < moodLogs.length; i++) {
      linearChartData.add(
        ChartData(
          i.toDouble(),
          moodMap[moodLogs[i].mood!],
        ),
      );
    }
  }

  /// created a Map<String,int> for making the rating availabler at liear time
  void prepareWolLogsForPieChart() {
    hubStatus.value!.lifeSatisfactionRatings!.entries.toList().forEach(
      (element) {
        pieChartMap.addIf(
          element.value.rating.rating != null,
          element.key,
          element.value.rating.rating!,
        );
      },
    );
  }

  /// creates a list of [WOLAreaData] for constructing the pie chart
  void parseWolLogsForPieChart() {
    for (int i = 0; i < pieChartMap.keys.length; i++) {
      final String currentKey = pieChartMap.keys.elementAt(i);
      allPieChartData.add(
        WOLAreaData(
          currentKey,
          pieChartMap[currentKey]!.toDouble(),
          Colors.green[100 * i + 1],
        ),
      );
    }
  }

  void parseDisplayedChartAreas() {
    for (int i = 0; i < 3; i++) {
      displayedLifeAreas.add(
        hubStatus.value!.lifePriorities!.areasInOrderOfPriority[i],
      );
    }
  }

  /// for filtering the pie chart data whenever items change in displayedLifeAreas
  void filterPieChartData() {
    pieChartData.clear();
    for (int i = 0; i < allPieChartData.length; i++) {
      final currentLifeArea = allPieChartData[i];
      if (displayedLifeAreas.contains(currentLifeArea.x)) {
        //log(currentLifeArea.x);
        pieChartData.add(currentLifeArea);
      }
    }
  }

  /// for adding area to the pie chart
  /// filters will apply automatically as the are binded to {displayedLifeAreas}
  void addWolLifeToPieChart({required String lifeArea}) {
    if (displayedLifeAreas.contains(lifeArea)) {
      /// Remove the area if it is already present
      displayedLifeAreas.remove(lifeArea);
    } else {
      displayedLifeAreas.add(lifeArea);
    }
  }

  /// Takes user to the good old Questionnaire screen, And when user submits the questionnaire
  /// refreshes the answered questionnaires on the profile screen
  Future<void> presentQuestionnaire() async {
    toggleProcessor();
    await Navigator.of(Get.context!)
        .pushNamed(RouteName.questionTrackScreen)
        .then((value) => fetchQuestionLogs());
    toggleProcessor();
  }

  /// Sets up the initialBindings for reactive changes
  Future<void> setupListeners() async {
    displayedLifeAreas.listen((_) {
      filterPieChartData();
    });
  }

  // initial-setup helpers
  Future<void> setup() async {
    toggleLoader();
    await setupListeners();
    await fetchBasicProfileData();
    await fetchMoodLogs();
    await fetchQuestionLogs();
    await fetchWheelOfLifeData();
    await fetchDiaryLogs();
    await fetchActionWithActionStatus();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
