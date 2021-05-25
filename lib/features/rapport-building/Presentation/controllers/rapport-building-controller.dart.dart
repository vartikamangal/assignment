import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/usecase/usecase.dart';
import 'package:tatsam_app_experimental/core/utils/snackbars/snackbars.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/rapport1.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/rapport2.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/rapport3.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/rapport4.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/feeling-duration-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-tracking-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/subject-information-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/feeling-duration.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood-tracking.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/rapport-building-steps.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-all-moods.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-available-feeling-duration.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/get-rapport-building-steps.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-feeling.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-mood.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/set-subject-name.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/usecases/track-subject-mood.dart';
// Remeber to make different controllers in for screenSet and a root controller for each main screen

class RapportBuildingController extends GetxController {
  // dependencies
  final SetSubjectName setSubjectName;
  final GetAllMoods getAllMoods;
  final SetSubjectMood setSubjectMood;
  final SetSubjectFeeling setSubjectFeeling;
  final GetRapportBuildingSteps getRapportBuildingSteps;
  final GetAvailableFeelingDuration getAvailableFeelingDuration;
  final TrackSubjectMood trackSubjectMood;
  final TextEditingController textEditingController=TextEditingController();

  RxBool isLoadComplete = false.obs;
  RxBool isProcessing = RxBool(false);
  final String activityTypeForRapportSection = "ONBOARDING";
  RxList<Mood> moods = RxList([]);
  Rx<SubjectInformation> subjectInfo = Rx<SubjectInformationModel>();
  Rx<RapportBuildingSteps> rapportBuildingSteps = Rx<RapportBuildingSteps>();
  RxList<FeelingDuration> availableDurations = RxList<FeelingDurationModel>([]);
  Rx<MoodTracking> userMoodStatus = Rx<MoodTrackingModel>();
  Rx<TextEditingController> controller = Rx<TextEditingController>();

  RapportBuildingController({
    @required this.setSubjectName,
    @required this.getAllMoods,
    @required this.setSubjectMood,
    @required this.setSubjectFeeling,
    @required this.getRapportBuildingSteps,
    @required this.getAvailableFeelingDuration,
    @required this.trackSubjectMood,
  });

  // ignore: type_annotate_public_apis
  Future<void> setup() async {
    isLoadComplete.value = false;
    await getAllAvailableMoods();
    await fetchAvailableDurations();
    isLoadComplete.value = true;
    currentSelectedPage.value = MidPageContentA(
      controller: this,
    );
  }

  /////////////////////////////////////////////////////////////////////////////////////////
  //            //? UseCase assistors
  /////////////////////////////////////////////////////////////////////////////////////////

  Future<void> changeNickNameAndMoveOnwards() async {
    toggleProcessor();
    final userNameSetOrFailure = await setSubjectName(
      SetSubjectNameParams(
        name: userName.value,
      ),
    );
    toggleProcessor();
    userNameSetOrFailure.fold(
      (failure) => ShowSnackbar.rawSnackBar(
        title: 'Oops!',
        message: 'Some error occured',
      ),
      (fetchedSubjectInfo) {
        subjectInfo.value = fetchedSubjectInfo;
        currentOnBoardPageCounter.value += 1;
        currentSelectedPage.value = MidPageContentB(
          onBoardingController: this,
        );
      },
    );
  }

  Future<void> getAllAvailableMoods() async {
    final moodsOrFailure = await getAllMoods(NoParams());
    moodsOrFailure.fold(
      (failure) => ShowSnackbar.rawSnackBar(
        title: 'Oops!',
        message: 'Error occured while fetching emojis!',
      ),
      (moodsFetched) {
        moods.assignAll(moodsFetched);
      },
    );
  }

  // Future<void> fetchRapportBuildingSteps() async {
  //   toggleProcessor();
  //   final rapportStepsOrFailure = await getRapportBuildingSteps(
  //     GetRapportBuildingStepsParams(
  //       mood: selectedMood.value,
  //     ),
  //   );
  //   toggleProcessor();
  //   rapportStepsOrFailure.fold(
  //     (failure) {
  //       ShowSnackbar.rawSnackBar(
  //         title: 'Oops!',
  //         message: 'Some error occured',
  //       );
  //     },
  //     (nextSteps) {
  //       log('got the next steps');
  //       rapportBuildingSteps.value = nextSteps;
  //       currentOnBoardPageCounter.value += 1;
  //       currentSelectedPage.value = MidPageContentC(
  //         selectedEmotion: selectedEmotion.value,
  //         controller: this,
  //       );
  //     },
  //   );
  // }

  Future<void> setSubjectMoodAndMoveOnwards() async {
    toggleProcessor();
    final setMoodOrFailure = await setSubjectMood(SetSubjectMoodParams(
      moodName: selectedEmotion.value.toUpperCase(),
      activityType: activityTypeForRapportSection,
    ));
    toggleProcessor();
    setMoodOrFailure.fold(
      (failure) {
        log(failure.toString());
        ShowSnackbar.rawSnackBar(
          title: failure.toString(),
          message: 'Some error occured',
        );
      },
      (fetchedUserMoodStatus) async {
        userMoodStatus.value = fetchedUserMoodStatus;
        // await fetchRapportBuildingSteps();
        currentOnBoardPageCounter.value += 1;
        currentSelectedPage.value = MidPageContentC(
          selectedEmotion: selectedEmotion.value,
          controller: this,
        );
      },
    );
  }

  Future<void> fetchAvailableDurations() async {
    final availableDurationsOrFailure =
        await getAvailableFeelingDuration(NoParams());
    availableDurationsOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: "Some error occured",
          message: '$failure',
        );
      },
      (fetchedDurationList) {
        log('available durations fetched');
        availableDurations.assignAll(fetchedDurationList);
        //TODO adding an extra duration coz. of the design thing, Will optimize in future
        availableDurations.insert(
          0,
          const FeelingDurationModel(
            durationName: '',
            durationSequence: '',
            durationDisplayName: '',
          ),
        );
      },
    );
  }

  Future<void> trackSubjectMoodAndMoveForward() async {
    toggleProcessor();
    // TODO reduce this complexity
    final newTrackDuration = userMoodStatus.value as MoodTrackingModel;
    newTrackDuration.moodDuration = selectedFeelingDuration.value.durationName;
    final moodTrackingStatusOrFailure = await trackSubjectMood(
      TrackSubjectMoodParams(
        mood: newTrackDuration,
      ),
    );
    toggleProcessor();
    moodTrackingStatusOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: "Some error occured",
          message: '$failure',
        );
      },
      (moodTrackStatus) {
        log('mood duration set successfully!');
        currentSelectedPage.value = MidPageContentsD();
      },
    );
  }

  Future<void> persistSubjectFeeing({@required String feeling}) async {
    toggleProcessor();
    final persistStatus = await setSubjectFeeling(
      SetSubjectFeelingParams(
        feeling: feeling,
      ),
    );
    toggleProcessor();
    persistStatus.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: "Some error occured",
          message: '$failure',
        );
      },
      (persistenceMessage) async {
        log('feeling persisted');
      },
    );
  }

  ////////////////////////////////////////////////////////////////////////////////
  //           //? UI RELATED CHANGES METHODS
  ////////////////////////////////////////////////////////////////////////////////

  final FocusNode focusNode = FocusNode();
  // For getting the intro-page wherever user is
  RxInt currentOnBoardPageCounter = 0.obs;
  // Maximum no. of intro pages on wol_areas_page
  int maxIntroPages = 3;
  //for getting selected emotion
  RxString selectedEmotion = RxString('');
  // for setting a nickName
  RxString userName = RxString('');
  // For making global widget changes as per the selected index
  Rx<Widget> currentSelectedPage = Rx<Widget>();
  // For setting up a global mood
  Rx<Mood> selectedMood = Rx<Mood>();
  // For getting status of dropdown
  RxBool isDropDownExpanded = RxBool(false);
  // For persisting selected feelingDuration from dropDown
  Rx<FeelingDuration> selectedFeelingDuration = Rx<FeelingDurationModel>();
  //For valid name input
  RxInt validName = 0.obs;
  // For storing rapport last step feeling
  RxString feeling = RxString('');

  // for setting a emotion
  // ignore: avoid_setters_without_getters
  Future<void> setEmotion(String emojiName, Mood mood) async {
    selectedEmotion.value = emojiName;
    selectedMood.value = mood;
    await setSubjectMoodAndMoveOnwards();
  }

  // For setting the selected feeling durationModel
  // ignore: use_setters_to_change_properties
  void setFeelingDuration({@required FeelingDuration feelingDuration}) {
    selectedFeelingDuration.value = feelingDuration;
  }

  // ignore: avoid_setters_without_getters
  set nickName(String name) {
    userName.value = name;
  }

  // for setting user feeling
  // ignore: avoid_setters_without_getters
  set userFeeling(String newFeeling) {
    feeling.value = newFeeling;
  }

  void toggleDropDownExpansion() {
    isDropDownExpanded.value = !isDropDownExpanded.value;
  }

  // For making stateless changes on the onboarding screen
  Future<void> changeScreen() async {
    currentOnBoardPageCounter.value == maxIntroPages
        ? currentOnBoardPageCounter.value
        : currentOnBoardPageCounter.value++;
    switch (currentOnBoardPageCounter.value) {
      case 0:
        currentSelectedPage.value = MidPageContentA(
          controller: this,
        );
        break;
      case 1:
        await changeNickNameAndMoveOnwards();
        break;
      case 2:
        await setSubjectMoodAndMoveOnwards();
        break;
      case 3:
        await trackSubjectMoodAndMoveForward();
        break;
    }
  }

  // Acting as a helper in navigating back
  Future<void> navigateBackHelper() async {
    switch (currentOnBoardPageCounter.value) {
      case 0:
        currentSelectedPage.value = MidPageContentA(
          controller: this,
        );
        break;
      case 1:
        currentSelectedPage.value = MidPageContentB(
          onBoardingController: this,
        );
        break;
      case 2:
        currentSelectedPage.value = MidPageContentC(
          selectedEmotion: selectedEmotion.value,
          controller: this,
        );
        break;
      case 3:
        currentSelectedPage.value = MidPageContentsD();
        break;
    }
  }

  // Custom Navigator
  void navigateBack() {
    if (currentOnBoardPageCounter.value == 0) {
    } else {
      currentOnBoardPageCounter.value--;
      navigateBackHelper();
    }
  }

  // for toggling linearProgressIndicator
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  @override
  void onInit() {
    super.onInit();
    setup();
  }
}
