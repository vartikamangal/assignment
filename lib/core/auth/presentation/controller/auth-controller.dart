import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';

import '../../../cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import '../../../routes/app-routes/app-routes.dart';
import '../../../usecase/usecase.dart';
import '../../../utils/snackbars/snackbars.dart';
import '../../domain/usecases/check-if-already-logged-in.dart';
import '../../domain/usecases/request-login.dart';
import '../../domain/usecases/request-logout.dart';
import '../../domain/usecases/request-new-token.dart';

class AuthController extends GetxController {
  // Usecases
  final CheckIfAlreadyLoggedIn checkIfAlreadyLoggedIn;
  final RequestLogin requestLogin;
  final RequestLogout requestLogout;
  final RequestNewToken requestNewToken;
  final RetrieveUserOnboardingStatus retrieveUserOnboardingStatus;

  AuthController({
    @required this.checkIfAlreadyLoggedIn,
    @required this.requestLogin,
    @required this.requestLogout,
    @required this.requestNewToken,
    @required this.retrieveUserOnboardingStatus,
  });
  // Dynamic data containers

  // Usecase helpers
  Future<void> login() async {
    toggleProcessor();
    final loggedInOrFailure = await requestLogin(
      const RequestLoginParams(
        isNewLogin: false,
      ),
    );
    toggleProcessor();
    loggedInOrFailure.fold(
      (failure) {
        final fNew = failure as AuthFailure;
        ShowSnackbar.rawSnackBar(
          title: fNew.title,
          message: fNew.details,
        );
      },
      (loginStatus) async {
        await checkUserOnboardingStatus().then(
          (value) {
            navigateBasedOnOnboardingStatus(
              isPreviouslyOnboarded: userPreviouslyOnboarded.value,
            );
          },
        );
      },
    );
  }

  Future<void> checkUserOnboardingStatus() async {
    final statusOrFailure = await retrieveUserOnboardingStatus(
      NoParams(),
    );
    statusOrFailure.fold(
      (failure) {},
      (status) {
        if (status == 'COMPLETE') {
          userPreviouslyOnboarded.value = true;
        } else {
          userPreviouslyOnboarded.value = false;
        }
      },
    );
  }

  // UI managers
  RxBool isProcessing = RxBool(false);
  RxBool userPreviouslyOnboarded = RxBool(false);

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void navigateBasedOnOnboardingStatus({
    @required bool isPreviouslyOnboarded,
  }) {
    if (isPreviouslyOnboarded) {
      Get.offAllNamed(
        RouteName.onBoardingIncomplete,
      );
    } else {
      Get.offAllNamed(
        RouteName.rapportPages,
      );
    }
  }

  // Initial setup functions
  Future<void> setup() async {
    //TODO implement initial setup fuinctions {if any}
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
