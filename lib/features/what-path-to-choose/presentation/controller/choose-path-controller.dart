// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/activity-management/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/check-if-already-logged-in.dart';
import 'package:tatsam_app_experimental/core/auth/domain/usecases/request-login.dart';
import 'package:tatsam_app_experimental/core/error/display-error-info.dart';
import 'package:tatsam_app_experimental/core/error/failures.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../data/models/journey-model.dart';
import '../../domain/entites/journey.dart';
import '../../domain/usecases/get-journey-path-list.dart';
import '../../domain/usecases/start_journey.dart';

class ChoosePathController extends GetxController {
  // Usecases
  final GetJourneyPathList getJourneyPathList;
  final StartJourney startJourney;
  final RequestLogin requestLogin;
  final CheckIfAlreadyLoggedIn checkIfAlreadyLoggedIn;

  ChoosePathController({
    @required this.getJourneyPathList,
    @required this.startJourney,
    @required this.requestLogin,
    @required this.checkIfAlreadyLoggedIn,
  });
  //////////                                      //////////////
  ////////// Dynamic Data Holders {For Usecases} ///////////////
  /////////                                     //////////////
  RxList<Journey> availableJournies = RxList<JourneyModel>([]);
  Rx<Journey> selectedJourney = Rx<JourneyModel>();

  //////////                        //////////////
  ////////// Usecase helper methods ///////////////
  /////////                         //////////////
  Future<void> fetchJourneys() async {
    final fetchedJourneysOrFailure = await getJourneyPathList(NoParams());
    fetchedJourneysOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (fetchedJourneys) {
        availableJournies.assignAll(fetchedJourneys);
        log('journeys fetched');
      },
    );
  }

  Future<void> startJourneyAndProceed() async {
    toggleProcessor();
    final journeyStartedOrFailure = await startJourney(
      StartJourneyParams(
        journey: selectedJourney.value,
      ),
    );
    toggleProcessor();
    journeyStartedOrFailure.fold(
      (failure) {
        ErrorInfo.show(failure);
      },
      (journeyStatus) {
        log('${selectedJourney.value.title} started');

        /// If the jounrey started was Self-driven then move to SelfDrivenRecommendationScreen else
        /// move to guided plan screen
        Get.find<PathController>().setup();
        selectedJourney.value.pathName == 'SMALL_WINS'
            ? Get.toNamed(RouteName.pathSelfDrivenPlan)
            : Get.toNamed(RouteName.pathGuidedPlan);
      },
    );
  }

  //////////               //////////////
  ////////// UI MANAGEMENT //////////////
  /////////                //////////////

  RxBool isLoading = RxBool(false);
  RxBool isProcessing = RxBool(false);
  RxBool isJourneySelected = RxBool(false);

  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  // ignore: use_setters_to_change_properties
  void selectJourney({@required Journey journey}) {
    selectedJourney.value = journey;
    isJourneySelected.value = true;
  }

  void navigateBack() {
    isJourneySelected.value = false;
  }

  Future<void> setup() async {
    toggleLoader();
    await fetchJourneys();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
  }
}
