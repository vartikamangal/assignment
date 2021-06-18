import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:smartlook/smartlook.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/secrets.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/add-delay.dart';

import '../../../../core/auth/domain/usecases/check-if-already-logged-in.dart';
import '../../../../core/cache-manager/domain/usecases/log-app-start-time.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-last-logged-app-init.dart';
import '../../../../core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import '../../../../core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/helper_functions/generate-date-from-datetime.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../../../features/home-management/domain/usecases/get-mood-popup-shown-status.dart';
import '../../../../features/home-management/domain/usecases/toggle-mood-popup-shown-state.dart';

class RootController extends GetxController {
  // UseCases
  final RetrieveUserOnboardingStatus retrieveUserOnboardingStatus;
  final SaveIsFirstTimeOnboardingStatus saveIsFirstTimeOnboardingStatus;
  final CheckIfAlreadyLoggedIn checkIfAlreadyLoggedIn;
  final LogAppStartTime logAppStartTime;
  final GetIsMoodPopupShownStatus getIsMoodPopupShownStatus;
  final RetirieveLastLoggedAppInit retirieveLastLoggedAppInit;
  final ToggleMoodPopupShownState toggleMoodPopupShownState;

  RootController({
    @required this.retrieveUserOnboardingStatus,
    @required this.saveIsFirstTimeOnboardingStatus,
    @required this.checkIfAlreadyLoggedIn,
    @required this.logAppStartTime,
    @required this.getIsMoodPopupShownStatus,
    @required this.retirieveLastLoggedAppInit,
    @required this.toggleMoodPopupShownState,
  });

  // Dynamic data holders
  RxBool hasOnboardedPreviously = RxBool(false);

  // Usecase assistors
  Future<void> checkIfAlreadyOnboarded() async {
    final onBoardingStatusOrFailure = await retrieveUserOnboardingStatus(
      NoParams(),
    );
    onBoardingStatusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) async {
        if (status == 'COMPLETE') {
          hasOnboardedPreviously.value = true;
          await updateIsFirstTimeIfOnBoarded(
            yesOrNo: 'NO',
          );
        } else {
          log('user opened for the first time');
          await updateIsFirstTimeIfOnBoarded(
            yesOrNo: 'YES',
          );
          hasOnboardedPreviously.value = false;
        }
      },
    );
  }

  Future<void> isAlreadyLoggedIn() async {
    final isLoggedInStatusOrFailure = await checkIfAlreadyLoggedIn(
      NoParams(),
    );
    isLoggedInStatusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (loginStatus) {
        log(
          'Login status: ${loginStatus.toString()}',
        );
        navigateBasedOnLoginStatus(
          isLoggedIn: loginStatus,
        );
      },
    );
  }

  // Future<void> refreshAuthTokens() async {
  //   final tokenRefreshedOrFailure = await requestNewToken(
  //     NoParams(),
  //   );
  //   tokenRefreshedOrFailure.fold(
  //     (failure) {
  //       ShowSnackbar.rawSnackBar(
  //         title: '$failure',
  //         message: 'Error fetching login status',
  //       );
  //     },
  //     (newAuthToken) {
  //       log('got refreshed auth token successfully');
  //     },
  //   );
  // }

  Future<void> updateIsFirstTimeIfOnBoarded({@required String yesOrNo}) async {
    final onBoardingStatusOrFailure = await saveIsFirstTimeOnboardingStatus(
      SaveIsFirstTimeOnboardingStatusParams(
        onBoardingStatus: yesOrNo,
      ),
    );
    onBoardingStatusOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) {
        log('isFirstTime variable updated successfully');
      },
    );
  }

  Future<void> navigateBasedOnLoginStatus({
    @required bool isLoggedIn,
  }) async {
    addDelay(() {
      if (isLoggedIn) {
        if (hasOnboardedPreviously.value) {
          Navigator.of(Get.context).pushNamedAndRemoveUntil(
            RouteName.onBoardingIncomplete,
            (route) => false,
          );
        } else {
          Navigator.of(Get.context).pushNamedAndRemoveUntil(
            RouteName.rapportPages,
            (route) => false,
          );
        }
      } else {
        Navigator.of(Get.context).pushNamedAndRemoveUntil(
          RouteName.origin,
          (route) => false,
        );
      }
    });
  }

  Future<void> logAppInit() async {
    final failureOrResult = await logAppStartTime(
      NoParams(),
    );
    failureOrResult.fold(
      (f) {
        ErrorInfo.show(f);
      },
      (r) {
        log('sucessfully logged app start time');
      },
    );
  }

  Future<void> getAppLastLoggedTime() async {
    final failureOrResult = await retirieveLastLoggedAppInit(
      NoParams(),
    );
    failureOrResult.fold(
      (f) {
        log(f.toString());
      },
      (r) {
        appLastLoggedTime.value = generateDateFromDateTime(r);
      },
    );
  }

  Future<void> toggleMoodPopup() async {
    final failureOrResult = await toggleMoodPopupShownState(
      NoParams(),
    );
    failureOrResult.fold(
      (f) {
        log(f.toString());
      },
      (r) {
        log('moodShown toggled');
      },
    );
  }

  Future<void> checkIfMoodPopupShown() async {
    final dateToday = generateDateFromDateTime(DateTime.now());
    final failureOrResult = await getIsMoodPopupShownStatus(
      NoParams(),
    );
    failureOrResult.fold(
      (f) {
        log("couldn't get the log-duration");
      },
      (r) async {
        // If this is null means the user is entering the app for the first time
        if (r == null) {
          // toggle the switcher
          await toggleMoodPopup();
        }
        //! If user opens the app first time in a day
        if (dateToday == appLastLoggedTime.value && r == false) {
          // do nothing, as mood toggler should already be false
          log('user opens the app first time in a day');
        }
        //! If user opens the app same day and has seen the popup
        if (dateToday == appLastLoggedTime.value && r == true) {
          // do nothing, as the mood popup has already been shown
          log('user opens the app same day and has seen the popup');
        }
        //! If user opens the app one or more days later, then in any case
        if (dateToday != appLastLoggedTime.value && r == true) {
          // In case case, set the shownPopup to false here
          await toggleMoodPopup();
        }
      },
    );
  }

  // UI managers
  Rx<Widget> screenToStartWith = Rx<Widget>();
  Rx<String> appLastLoggedTime = Rx<String>();
  // initial setup
  Future<void> setup() async {
    await logAppInit();
    await getAppLastLoggedTime();
    await checkIfAlreadyOnboarded();
    await isAlreadyLoggedIn();
    await checkIfMoodPopupShown();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
