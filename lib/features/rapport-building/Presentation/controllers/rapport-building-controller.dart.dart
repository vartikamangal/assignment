// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/cache-manager/data/models/cached-mood-model.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/cache-mood.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/voicenotes/presentation/controller/voice-notes-controller.dart';
import 'package:tatsam_app_experimental/features/rapport-building/data/models/mood-model.dart';
import 'package:tatsam_app_experimental/features/rapport-building/domain/entities/subject-information.dart';

// Project imports:
import '../../../../core/cache-manager/domain/usecases/save-feedback.dart';
import '../../../../core/persistence-consts.dart';
import '../../../../core/session-manager/session-manager.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/feeling-duration-model.dart';
import '../../data/models/mood-tracking-model.dart';
import '../../data/models/subject-information-model.dart';
import '../../domain/entities/feeling-duration.dart';
import '../../domain/entities/mood-tracking.dart';
import '../../domain/entities/mood.dart';
import '../../domain/entities/rapport-building-steps.dart';
import '../../domain/usecases/get-all-moods.dart';
import '../../domain/usecases/get-available-feeling-duration.dart';
import '../../domain/usecases/get-rapport-building-steps.dart';
import '../../domain/usecases/set-subject-mood.dart';
import '../../domain/usecases/set-subject-name.dart';
import '../../domain/usecases/track-subject-mood.dart';
import '../widgets/rapport1.dart';
import '../widgets/rapport2.dart';
import '../widgets/rapport3.dart';
import '../widgets/rapport4.dart';

// Remeber to make different controllers in for screenSet and a root controller for each main screen

class RapportBuildingController extends GetxController {
  // dependencies
  final SetSubjectName setSubjectName;
  final GetAllMoods getAllMoods;
  final SetSubjectMood setSubjectMood;
  final SaveFeedback saveFeedback;
  final GetRapportBuildingSteps getRapportBuildingSteps;
  final GetAvailableFeelingDuration getAvailableFeelingDuration;
  final TrackSubjectMood trackSubjectMood;
  final CacheMood cacheMood;
  final TextEditingController textEditingController = TextEditingController();

  RxBool isLoadComplete = false.obs;
  RxBool isProcessing = RxBool(false);
  final String activityTypeForRapportSection = "ONBOARDING";
  RxList<Mood> moods = RxList([]);
  final VoiceNoteController _voiceNoteController = Get.find();

  /// This will give us basic userInfo like subjectInfo
  /// Which is to be used in common-feedback persistence
  Rx<SubjectInformation> subjectInfo = Rx<SubjectInformationModel>();
  Rx<RapportBuildingSteps> rapportBuildingSteps = Rx<RapportBuildingSteps>();
  RxList<FeelingDuration> availableDurations = RxList<FeelingDurationModel>([]);
  Rx<MoodTracking> userMoodStatus = Rx<MoodTrackingModel>();
  Rx<TextEditingController> controller = Rx<TextEditingController>();

  RapportBuildingController({
    @required this.setSubjectName,
    @required this.getAllMoods,
    @required this.setSubjectMood,
    @required this.saveFeedback,
    @required this.getRapportBuildingSteps,
    @required this.getAvailableFeelingDuration,
    @required this.trackSubjectMood,
    @required this.cacheMood,
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
    await SessionManager.persistUsername(
      name: userName.value,
    );
    final userNameSetOrFailure = await setSubjectName(
      SetSubjectNameParams(
        name: userName.value,
      ),
    );
    toggleProcessor();
    userNameSetOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
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
      (failure) {
        ErrorInfo.show(failure);
      },
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
  //    {
  // ErrorInfo.show(failure);},
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
    final setMoodOrFailure = await setSubjectMood(
      SetSubjectMoodParams(
        moodName: selectedEmotion.value.toUpperCase(),
        activityType: activityTypeForRapportSection,
      ),
    );
    toggleProcessor();
    setMoodOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedUserMoodStatus) async {
        //TODO Currently we are only caching the moodName
        //TODO Change selectedEmotion to selectedMood for enhanced caching
        await cacheUserMood(
          mood: MoodModel(
            id: 1,
            moodName: selectedEmotion.value,
            moodDescription: '',
            icon: null,
          ),
        ).then((value) {
          userMoodStatus.value = fetchedUserMoodStatus;
          // await fetchRapportBuildingSteps();
          currentOnBoardPageCounter.value += 1;
          currentSelectedPage.value = MidPageContentC(
            selectedEmotion: selectedEmotion.value,
            controller: this,
          );
        });
      },
    );
  }

  Future<void> fetchAvailableDurations() async {
    final availableDurationsOrFailure =
        await getAvailableFeelingDuration(NoParams());
    availableDurationsOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
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
        ErrorInfo.show(failure);
      },
      (moodTrackStatus) {
        log('mood duration set successfully!');
        currentSelectedPage.value = MidPageContentsD();
      },
    );
  }

  Future<void> persistSubjectFeeing({@required String feeling}) async {
    toggleProcessor();
    final persistStatus = await saveFeedback(
      SaveFeedbackParams(
        subjetcId: subjectInfo.value.subjectId.id,
        activityType: 'ONBOARDING',
        textFeedback: feeling,
        voiceNote: _voiceNoteController.currentVoiceNotePath.value,
        timeOfCreation: DateTime.now().toString(),
        boxKey: PersistenceConst.RAPPORT_FEELING_BOX,
      ),
    );
    toggleProcessor();
    persistStatus.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (persistenceMessage) async {
        log('feeling persisted');
        _voiceNoteController.cleanVoiceFilePath();
      },
    );
  }

  Future<void> cacheUserMood({
    @required MoodModel mood,
  }) async {
    //TODO Replace the Mood model and enitiy being used here in core with the CcaheMoodModel and entity
    //TODO For sake of cleaner code
    toggleProcessor();
    final statusOrFailure = await cacheMood(
      CacheMoodParams(
        mood: CachedMoodModel(
          moodId: mood.moodId,
          moodName: mood.moodName,
          moodDescription: mood.moodDescription,
          moodIcon: mood.moodIcon,
        ),
      ),
    );
    toggleProcessor();
    statusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (persistenceMessage) async {
        log('mood cached');
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
  //TO CHECK Navigation is pressed or not
  RxBool isNavigateBackPressed = RxBool(false);
  //to use in name validation feature
  RxBool isWantToMoveFromNameScreen = RxBool(false);
  RxBool switchButtonStatus = RxBool(false);

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
      isNavigateBackPressed.value = true;
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
