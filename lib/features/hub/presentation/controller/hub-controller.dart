// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-login.dart';

// Project imports:
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../data/models/hub-status-model.dart';
import '../../domain/entities/hub-status.dart';
import '../../domain/usecases/create-travller.dart';
import '../../domain/usecases/get-hub-status.dart';
import 'hub-screen-state-object.dart';

enum HubAnswerStatus {
  nothingAnswered,
  wheelOfLifeAnswered,
  targetAnswered,
  allAnswered,
}

class HubController extends GetxController {
  // Usecases
  final GetHubStatus getHubStatus;
  final CreateTraveller createTraveller;
  final RequestLogin requestLogin;
  final CheckIfAlreadyLoggedIn checkIfAlreadyLoggedIn;

  HubController({
    @required this.getHubStatus,
    @required this.createTraveller,
    @required this.checkIfAlreadyLoggedIn,
    @required this.requestLogin,
  });

  //////////////// Dynamic Data Container ////////////////
  Rx<HubStatus> hubStatus = Rx<HubStatusModel>();
  // Just a temporary repetition for checking wheather hub-refresh flaw goes
  Rx<HubStatus> hubStatusFinal = Rx<HubStatusModel>();

  /////////////// Usecase Helpers /////////////////
  Future<void> fetchHubStatus() async {
    final hubStatusOrFailure = await getHubStatus(NoParams());
    hubStatusOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
      (fetchedHubStatus) {
        hubStatus.value = fetchedHubStatus;
        log(
          hubStatus.value.attemptedQuestions.toString(),
        );
        log('fetched hub status');
        // Refreshes the state of hubScreen as per the answers ansered
        _updateHubScreenState(
          hubStatus: hubStatus,
        );
      },
    );
  }

  // Assistor of above commented dynamic container
  Future<void> fetchHubStatusFinal() async {
    final hubStatusOrFailure = await getHubStatus(NoParams());
    hubStatusOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
      (fetchedHubStatus) {
        hubStatusFinal.value = fetchedHubStatus;
        log(
          hubStatusFinal.value.attemptedQuestions.toString(),
        );
        log('fetched hub status');
        // Refreshes the state of hubScreen as per the answers ansered
        _updateHubScreenState(
          hubStatus: hubStatusFinal,
        );
      },
    );
  }

  Future<void> createNewTravellerAndMoveAhead() async {
    toggleProcessor();
    final travellerCreatedOrFailure = await createTraveller(NoParams());
    toggleProcessor();
    travellerCreatedOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
      (travellerCreatedStatus) {
        log(travellerCreatedStatus.message);
        Navigator.of(Get.context).pushNamed(RouteName.whatPathChooseScreen);
      },
    );
  }

  Future<void> login() async {
    toggleLogger();
    final loggedInOrFailure = await requestLogin(
      const RequestLoginParams(
        isNewLogin: true,
      ),
    );
    toggleLogger();
    loggedInOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Error in logging in',
        );
      },
      (loginStatus) async {
        log('user logged in');
      },
    );
  }

  Future<bool> isAlreadyLoggedInUser() async {
    final alreadyLoggedInStatusOrFailure = await checkIfAlreadyLoggedIn(
      NoParams(),
    );
    return alreadyLoggedInStatusOrFailure.fold(
      (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Error in logging in',
        );
        return false;
      },
      (loginStatus) {
        return loginStatus;
      },
    );
  }

  Future<void> checkForLoginAndProceed() async {
    final isLoggedIn = await isAlreadyLoggedInUser();
    if (isLoggedIn) {
      await createNewTravellerAndMoveAhead();
    } else {
      try {
        await login().then(
          (value) async => createNewTravellerAndMoveAhead(),
        );
      } catch (e) {
        log(
          e.toString(),
        );
      }
    }
  }

  /////////////// UI helper vairables ///////////////
  RxBool isProcessing = RxBool(false);
  RxBool isLoggingIn = RxBool(false);

  RxBool isLoading = RxBool(false);
  Rx<HubAnswerStatus> userHubStatus = Rx<HubAnswerStatus>(
    HubAnswerStatus.nothingAnswered,
  );
  // Hub screen initial data when user hasn't answered anything
  Rx<HubScreenStateObject> activeHubStateObject = Rx<HubScreenStateObject>();

  /////////////// UI Managers ///////////////
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLogger() {
    isLoggingIn.value = !isLoggingIn.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  // Conditions for dynamicaly updating hub
  void _updateHubScreenState({@required Rx<HubStatus> hubStatus}) {
    if (hubStatus.value.lifePriorities != null &&
        hubStatus.value.lifeSatisfactionRatings != null) {
      userHubStatus.value = HubAnswerStatus.wheelOfLifeAnswered;
      if (hubStatus.value.targetFocus != null) {
        userHubStatus.value = HubAnswerStatus.targetAnswered;
        log('upto target answered');
        if (hubStatus.value.attemptedQuestions == true) {
          userHubStatus.value = HubAnswerStatus.allAnswered;
        } else {
          log('upto target-part answered');
        }
      } else {
        log('only wheel of life answered');
      }
    } else {
      userHubStatus.value = HubAnswerStatus.nothingAnswered;
      log('nothing answered');
    }
    _updateStateObject();
  }

  void _updateStateObject() {
    switch (userHubStatus.value) {
      case HubAnswerStatus.nothingAnswered:
        activeHubStateObject.value =
            kHubScreenStateObjectMap[HubAnswerStatus.nothingAnswered];
        break;
      case HubAnswerStatus.wheelOfLifeAnswered:
        activeHubStateObject.value =
            kHubScreenStateObjectMap[HubAnswerStatus.wheelOfLifeAnswered];
        break;
      case HubAnswerStatus.targetAnswered:
        activeHubStateObject.value =
            kHubScreenStateObjectMap[HubAnswerStatus.targetAnswered];
        break;
      case HubAnswerStatus.allAnswered:
        activeHubStateObject.value =
            kHubScreenStateObjectMap[HubAnswerStatus.allAnswered];
        break;
    }
  }

  Future<void> setup() async {
    toggleLoader();
    await fetchHubStatus();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
