// Dart imports:
import 'dart:developer';
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatsam_app_experimental/core/activity-management/data/models/recommendation-activity-model.dart';
import 'package:tatsam_app_experimental/core/activity-management/domain/entities/recommendation-activity.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-login.dart';
import 'package:tatsam_app_experimental/core/cache-manager/domain/usecases/retrieve-user-onboarding-status.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/domain/usecases/get-instant-recommendations.dart';

// Project imports:
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../domain/entities/emergency-number.dart';
import '../../domain/entities/instant-relief-area.dart';
import '../../domain/usecases/get-instant-relief-areas.dart';
import '../../domain/usecases/list-emergency-numbers.dart';

class InstantReliefController extends GetxController {
  // Dependencies
  final GetInstantReliefAreas getInstantReliefAreas;
  final ListEmergencyNumbers listEmergencyNumbers;
  final GetInstantRecommendations getInstantRecommendations;
  final RequestLogin requestLogin;
  final CheckIfAlreadyLoggedIn checkIfAlreadyLoggedIn;

  InstantReliefController({
    @required this.getInstantReliefAreas,
    @required this.listEmergencyNumbers,
    @required this.getInstantRecommendations,
    @required this.requestLogin,
    @required this.checkIfAlreadyLoggedIn,
  });

  // Data containers
  RxList<InstantReliefArea> instantLifeAreas = RxList([]);
  RxList<EmergencyNumber> emergencyResources = RxList([]);
  RxList<ActivityRecommendation> instantRecommendations =
      RxList<ActivityRecommendationModel>([]);
  RxBool isLoggingIn = RxBool(false);

  // UI management variables
  RxBool isProcessing = RxBool(false);
  Rx<InstantReliefArea> selectedArea = Rx<InstantReliefAreaModel>();

  // UI management methods
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  Future<void> setup() async {
    toggleProcessor();
    //TODO Still to be done
    //await fetchEmergencyNumbers();
    await fetchInstantActivities();
    toggleProcessor();
  }

  // ignore: avoid_setters_without_getters
  set instantReliefArea(InstantReliefAreaModel instantReliefArea) {
    selectedArea.value = instantReliefArea;
  }

  // Usecase helpers
  Future<void> fetchEmergencyNumbers() async {
    final emergencyNumbersOrFailure = await listEmergencyNumbers(
      NoParams(),
    );
    emergencyNumbersOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (numbers) {
        emergencyResources.addAll(numbers);
        stdout.write(
          'Eemrgency Numbers Gotten!',
        );
      },
    );
  }

  Future<void> fetchInstantActivities() async {
    final activitiesOrFailure = await getInstantReliefAreas(NoParams());
    activitiesOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (instantActivities) {
        instantLifeAreas.addAll(instantActivities);
        stdout.write(
          'Instant Activites Gotten!',
        );
      },
    );
  }

  /// returns [Future] true if user is logged in in this device, else false
  Future<bool> checkUserLoginStatus() async {
    final successOrFailure = await checkIfAlreadyLoggedIn(
      NoParams(),
    );
    return successOrFailure.fold(
      (f) {
        log('user not logged in');
        return false;
      },
      (r) {
        return r;
      },
    );
  }

  Future<void> fetchInstantRecommendations({
    @required InstantReliefArea instantLifeArea,
  }) async {
    if (await checkUserLoginStatus()) {
      final recommendationsOrFailure = await getInstantRecommendations(
        GetInstantRecommendationsParams(
          instantLifeArea: instantLifeArea.instantReliefName,
        ),
      );
      recommendationsOrFailure.fold(
        (failure) {
          if (failure is AuthFailure) {
            // ignore: avoid_unnecessary_containers
            Get.bottomSheet(
              Obx(
                () => BottomSheetWidget(
                  onPressed: () async {
                    await login();
                  },
                  isLoggingIn: isLoggingIn.value,
                ),
              ),
            );
          } else {
            ErrorInfo.show(failure);
          }
        },
        (fetchedRecommendations) {
          instantRecommendations.assignAll(
            fetchedRecommendations,
          );
          Get.toNamed(
            RouteName.instantRecommendations,
          );
        },
      );
    } else {
      // ignore: avoid_unnecessary_containers
      Get.bottomSheet(
        Obx(
          () => BottomSheetWidget(
            onPressed: () async {
              await login();
            },
            isLoggingIn: isLoggingIn.value,
          ),
        ),
      );
    }
  }

  Future<void> login() async {
    isLoggingIn.value = true;
    final loggedInOrFailure = await requestLogin(
      const RequestLoginParams(
        isNewLogin: true,
      ),
    );
    isLoggingIn.value = false;
    loggedInOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (status) {
        Get.back();
        log(
          'user-logged-in',
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    setup();
  }
}

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key key,
    @required this.onPressed,
    @required this.isLoggingIn,
  }) : super(key: key);

  final Callback onPressed;
  final bool isLoggingIn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ScaleManager.spaceScale(
          spaceing: 12,
        ).value,
      ),
      decoration: BoxDecoration(
          color: Get.theme.canvasColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 6,
              ).value,
            ),
          )),
      height: ScaleManager.spaceScale(
        spaceing: 200,
      ).value,
      child: Column(
        children: [
          Icon(
            Icons.warning,
            size: ScaleManager.spaceScale(
              spaceing: 65,
            ).value,
            color: Colors.redAccent,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Text(
            "This feature requires signin",
            style: GoogleFonts.poppins(
              color: Colors.red,
              fontSize: 18,
            ),
            textScaleFactor: ScaleManager.textScale.value,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 22,
            ).value,
          ),
          OutlinedButton.icon(
            icon: isLoggingIn
                ? Center(
                    child: SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                      width: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.login,
                  ),
            label: Text(
              isLoggingIn ? '' : 'Sign in',
            ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
