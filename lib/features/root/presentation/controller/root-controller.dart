import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-page-status/data/repository/app-page-status-repository-impl.dart';
import 'package:tatsam_app_experimental/core/app-page-status/domain/usecases/get-last-abandoned-page.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/clear-dirty-cache-on-first-run.dart';
import 'package:tatsam_app_experimental/features/hub/data/models/hub-status-model.dart';
import 'package:tatsam_app_experimental/features/hub/domain/entities/hub-status.dart';
import 'package:tatsam_app_experimental/features/hub/domain/usecases/get-hub-status.dart';

import '../../../../core/cache-manager/domain/usecases/log-app-start-time.dart';
import '../../../../core/cache-manager/domain/usecases/retireve-last-logged-app-init.dart';
import '../../../../core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import '../../../../core/cache-manager/domain/usecases/save-is-first-time-onboarding-status.dart';
import '../../../../core/error/display-error-info.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/helper_functions/add-delay.dart';
import '../../../../core/utils/helper_functions/generate-date-from-datetime.dart';
import '../../../../features/home-management/domain/usecases/get-mood-popup-shown-status.dart';
import '../../../../features/home-management/domain/usecases/toggle-mood-popup-shown-state.dart';

class RootController extends GetxController {
  // UseCases
  final RetrieveUserOnboardingStatus retrieveUserOnboardingStatus;
  final SaveIsFirstTimeOnboardingStatus saveIsFirstTimeOnboardingStatus;
  final CheckIfAuthenticated checkIfAuthenticated;
  final LogAppStartTime logAppStartTime;
  final GetIsMoodPopupShownStatus getIsMoodPopupShownStatus;
  final RetirieveLastLoggedAppInit retirieveLastLoggedAppInit;
  final ToggleMoodPopupShownState toggleMoodPopupShownState;
  final ClearDirtyCacheOnFirstRun clearDirtyCacheOnFirstRun;
  final GetLastAbandonedPage getLastAbandonedPage;
  final GetHubStatus getHubStatus;

  RootController({
    @required this.retrieveUserOnboardingStatus,
    @required this.saveIsFirstTimeOnboardingStatus,
    @required this.checkIfAuthenticated,
    @required this.logAppStartTime,
    @required this.getIsMoodPopupShownStatus,
    @required this.retirieveLastLoggedAppInit,
    @required this.toggleMoodPopupShownState,
    @required this.clearDirtyCacheOnFirstRun,
    @required this.getLastAbandonedPage,
    @required this.getHubStatus,
  });

  // Dynamic data holders
  RxBool hasOnboardedPreviously = RxBool(false);
  Rx<HubStatus> hubStatus = Rx<HubStatusModel>();

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

          // On reinstall (uninstall then install), the access/refresh tokens
          // are still persisted in secure storage
          // So, clearing for the auth system to work
          // await clearCache.clearCache();
          await updateIsFirstTimeIfOnBoarded(
            yesOrNo: 'YES',
          );
          hasOnboardedPreviously.value = false;
        }
      },
    );
  }

  Future<void> clearInitialDirtyCache() async {
    final failureOrResult = await clearDirtyCacheOnFirstRun(NoParams());
    failureOrResult.fold(
      (f) => ErrorInfo.show(f),
      (r) => log('[PASSED]'),
    );
  }

  /// for checking if the user is already authenticated or not
  Future<void> isAlreadyLoggedIn() async {
    final isLoggedInStatusOrFailure = await checkIfAuthenticated(
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
          gotoRecentlyLeftPage();
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

  /// Temp name for getHubStatus
  /// To be renamed later
  Future<void> getUserDetails() async {
    final failureOrResult = await getHubStatus(NoParams());
    failureOrResult.fold(
      (f) => log("couln't hub details for navigating post-login", error: f),
      (usrDetails) => hubStatus.value = usrDetails,
    );
  }

  Future<void> gotoRecentlyLeftPage() async {
    final failureOrResult = await getLastAbandonedPage(
      GetLastAbandonedPageParams(
        hubStatusModel: hubStatus.value as HubStatusModel,
      ),
    );
    failureOrResult.fold(
      (f) => log(
        "couldn't get last abndoned page, Going to ${appFallbackRoute.name}",
        error: f,
      ),
      (r) => Navigator.of(Get.context).pushNamedAndRemoveUntil(
        //TODO change to r.name once api{/rapport/subject} gets fully stable
        RouteName.rapportPages,
        (route) => false,
      ),
    );
  }

  // UI managers
  Rx<Widget> screenToStartWith = Rx<Widget>();
  Rx<String> appLastLoggedTime = Rx<String>();
  // initial setup
  Future<void> setup() async {
    await clearInitialDirtyCache();
    await logAppInit();
    await getAppLastLoggedTime();
    await getUserDetails();
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
