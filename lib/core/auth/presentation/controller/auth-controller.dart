import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/oauth-signup.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/features/root/presentation/controller/root-controller.dart';

import '../../../error/failures.dart';
import '../../../routes/app-routes/app-routes.dart';
import '../../../usecase/usecase.dart';
import '../../../utils/snackbars/snackbars.dart';
import '../../domain/usecases/oauth-login.dart';
import '../../domain/usecases/request-logout.dart';
import '../../domain/usecases/request-new-token.dart';

class AuthController extends GetxController {
  // Usecases
  final CheckIfAuthenticated checkIfAuthenticated;
  final OauthLogin oauthLogin;
  final OAuthSignup oAuthSignup;
  final RequestLogout requestLogout;
  final RequestNewToken requestNewToken;
  final RetrieveUserOnboardingStatus retrieveUserOnboardingStatus;

  AuthController({
    required this.checkIfAuthenticated,
    required this.oauthLogin,
    required this.requestLogout,
    required this.requestNewToken,
    required this.retrieveUserOnboardingStatus,
    required this.oAuthSignup,
  });
  // Dynamic data containers

  // Usecase helpers
  Future<void> login() async {
    toggleProcessor();
    final loggedInOrFailure = await oauthLogin(NoParams());
    toggleProcessor();
    loggedInOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
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

  // Usecase helpers
  Future<void> signup({required String redirectRoute}) async {
    toggleProcessor();
    final failureOrResult = await oAuthSignup(NoParams());
    toggleProcessor();
    failureOrResult.fold(
      (failure) {
        final fNew = failure as AuthFailure;
        ShowSnackbar.rawSnackBar(
          title: fNew.title,
          message: fNew.details,
          actionLabel: 'Dismiss',
          onActionPressed: () {},
        );
      },
      (status) async {
        Navigator.of(Get.context!).pushNamedAndRemoveUntil(
          redirectRoute,
          (_) => false,
        );
      },
    );
  }

  Future<void> checkUserOnboardingStatus() async {
    final statusOrFailure = await retrieveUserOnboardingStatus(NoParams());
    statusOrFailure!.fold(
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
    required bool isPreviouslyOnboarded,
  }) {
    if (isPreviouslyOnboarded) {
      Get.offAllNamed(
        RouteName.onBoardingIncomplete,
      );
    } else {
      //!  Cases of Abandoned page will act here
      final RootController _rootController = Get.find();
      _rootController.gotoRecentlyLeftPage();
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
