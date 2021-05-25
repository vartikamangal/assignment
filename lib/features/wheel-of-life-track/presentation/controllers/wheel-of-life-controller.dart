import 'dart:developer';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/snackbars/snackbars.dart';
import '../../../hub/presentation/controller/hub-controller.dart';
import '../../data/models/life-area-model-for-prioritization.dart';
import '../../data/models/life-area-model.dart';
import '../../data/models/rating-scale-model.dart';
import '../../data/models/satisfaction-rating-map-for-time-provision-model.dart';
import '../../data/models/satisfaction-ratings-model.dart';
import '../../domain/entities/life-area.dart';
import '../../domain/entities/life-areas-for-prioritization.dart';
import '../../domain/entities/rating-scale.dart';
import '../../domain/entities/satisfaction-rating-map-for-time-provision-scale.dart';
import '../../domain/usecases/get-life-areas.dart';
import '../../domain/usecases/get-rating-scale.dart';
import '../../domain/usecases/prioritize.dart';
import '../../domain/usecases/rate-satisfaction.dart';
import '../widgets/wheel-of-life-body-A.dart';
import '../widgets/wheel-of-life-body-B.dart';
import '../widgets/wheel-of-life-body-D.dart';

// Remeber to make different controllers in for screenSet and a root controller for each main screen

class WheelOfLifeController extends GetxController {
  // Dependencies
  final GetLifeAreas getLifeAreas;
  final GetRatingScale getRatingScale;
  final Prioritize prioritize;
  final RateSatisfaction rateSatisfaction;

  WheelOfLifeController({
    @required this.getLifeAreas,
    @required this.getRatingScale,
    @required this.prioritize,
    @required this.rateSatisfaction,
  });

  ///////////////////    Dyanmic Data Container   ///////////////
  ///////////////////                            ///////////////
  ///////////////////                            ///////////////
  final RxList<LifeArea> lifeAreas = RxList<LifeAreaModel>([]);
  final Rx<RatingScale> ratingScale = Rx<RatingScaleModel>();
  final Rx<LifeAreaForPrioritization> lifeAreasForPrioritization =
  Rx<LifeAreaModelForPrioritization>();
  // Will help in constructing the final Ratings to be POSTED on API
  final RxList<SatisfactionRatingMapForTimeProvision> listForTimeProvision =
  RxList<SatisfactionRatingMapForTimeProvisionModel>([]);
  //Helps in state-management and UI - utility purposes
  RxMap<LifeArea, double> uiHelperListForTimeProvision = RxMap({});

  /////////////////// Dependency Related Mothods ///////////////
  ///////////////////                            ///////////////
  ///////////////////                            ///////////////
  Future<void> fetchLifeAreas() async {
    final lifeAreasOrFailure = await getLifeAreas(NoParams());
    lifeAreasOrFailure.fold(
          (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
          (fetchedLifeAreas) {
        lifeAreas.assignAll(fetchedLifeAreas);
      },
    );
  }

  Future<void> fetchRatingScale() async {
    final ratingScaleOrFailure = await getRatingScale(NoParams());
    ratingScaleOrFailure.fold(
          (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
          (fetchedRatingScale) {
        ratingScale.value = fetchedRatingScale;
        // Below condition makes sure that all the initial ratings are aligned to the possible minimum ratings
        if (ratingScale.value.min != ratingScale.value.ratingValue) {
          ratingScale.value.ratingValue = ratingScale.value.min;
        }
      },
    );
  }

  Future<void> prioritizeAndMoveAhead() async {
    toggleProcessor();
    final prioritizeSuccessOrFailure = await prioritize(
      PrioritizeParams(
        priorities: LifeAreaModelForPrioritization(
          lifeaAreas:
          lifeAreas.map((lifeArea) => lifeArea as LifeAreaModel).toList(),
        ),
      ),
    );
    toggleProcessor();
    prioritizeSuccessOrFailure.fold(
          (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
          (prioritizeSuccess) {
        currentSelectedPage.value = WheelOfLifeBodyD(controller: this);
      },
    );
  }

  Future<void> setupTimeProvisionInitialScales() async {
    // ignore: avoid_function_literals_in_foreach_calls
    lifeAreas.forEach(
          (lifeArea) {
        uiHelperListForTimeProvision.addIf(
          true,
          lifeArea,
          ratingScale.value.ratingValue.toDouble(),
        );
      },
    );
  }

  Future<void> rateSatisfactionAndMoveAhead() async {
    toggleProcessor();
    final ratedSatisfactionOrFailure = await rateSatisfaction(
      _getRatingParams(),
    );
    toggleProcessor();
    ratedSatisfactionOrFailure.fold(
          (failure) {
        ShowSnackbar.rawSnackBar(
          title: '$failure',
          message: 'Something went wrong!',
        );
      },
          (prioritizeSuccess) {
        log('Succesfully rated satisfactions');
        // For refreshing the status of HubScreen
        Get.find<HubController>().fetchHubStatus();
        Get.offAndToNamed(RouteName.hubScreen);
      },
    );
  }

  // Makes the parameters from UI state to a state where ratings are easily POSTable on API
  //TODO Refactor it into RateSatisfactionParams file
  RateSatisfactionParams _getRatingParams() {
    uiHelperListForTimeProvision.keys.toList().forEach(
          (lifeRating) {
        listForTimeProvision.add(
          SatisfactionRatingMapForTimeProvisionModel(
            lifeArea: lifeRating as LifeAreaModel,
            rating: RatingScaleModel(
              max: ratingScale.value.max,
              ratingScaleName: ratingScale.value.ratingScaleName,
              ratingValue: uiHelperListForTimeProvision[lifeRating].toInt(),
              min: ratingScale.value.min,
            ),
          ),
        );
      },
    );
    final ratings = RateSatisfactionParams(
      ratings: SatisfactionRatingsModel(
        satisfactionRatings: listForTimeProvision,
      ),
    );
    return ratings;
  }

  //////////////////                     ////////////////////////
  ///////////////// UI-RELATED METHODS ///////////////////////
  ////////////////                      ////////////////////////
  // For scollPostion relaed utitlities
  final ScrollController scrollController = ScrollController();

  // For getting the intro-page wherever user is
  RxInt currentOnBoardPageCounter = 0.obs;

  // Maximum no. of intro pages on wol_areas_page
  int maxIntroPages = 2;

  // For making global widget changes as per the selected index
  Rx<Widget> currentSelectedPage = Rx<Widget>();
  RxBool showBottomButton = RxBool(false);

  // For uninteruppted ui-flows
  RxBool isProcessing = false.obs;
  // for showing skeleton full-screen-initially
  RxBool isLoading = false.obs;
  String text1 = "success";
  RxDouble emotionvalue = 1.0.obs;
  RxBool isClickedOnInformation = false.obs;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();


  void toggleInformation(){
    cardKey.currentState.toggleCard();
  }
  void toggleProcessor() {
    isProcessing.value = !isProcessing.value;
  }

  void toggleLoader() {
    isLoading.value = !isLoading.value;
  }

  void toggleBottomButtonVisibility({double position, double maxPageLimit}) {
    if (position < maxPageLimit) {
      showBottomButton.value = false;
    } else {
      showBottomButton.value = true;
    }
  }

  // ignore: use_setters_to_change_properties
  void settSlidervalue(double newval, int index) {
    final areaToBeModified = uiHelperListForTimeProvision.keys.toList()[index];
    uiHelperListForTimeProvision[areaToBeModified] = newval;
  }

  // For making stateless changes on the onboarding screen
  Future<void> changeScreen() async {
    currentOnBoardPageCounter.value == maxIntroPages
        ? currentOnBoardPageCounter.value
        : currentOnBoardPageCounter.value++;
    switch (currentOnBoardPageCounter.value) {
    // case - not needed coz. setup does it
    // case 0:
    //   currentSelectedPage.value = WheelOfLifeBodyA(controller: this);
    //   break;
      case 1:
        currentSelectedPage.value = WheelOfLifeBodyB(controller: this);
        break;
      case 2:
        await prioritizeAndMoveAhead();
    }
  }

  // Acting as a helper in navigating back
  Future<void> navigateBackHelper() async {
    switch (currentOnBoardPageCounter.value) {
      case 0:
        currentSelectedPage.value = WheelOfLifeBodyA(
          controller: this,
        );
        break;
      case 1:
        currentSelectedPage.value = WheelOfLifeBodyB(
          controller: this,
        );
        break;
      case 2:
        currentSelectedPage.value = WheelOfLifeBodyD(
          controller: this,
        );
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

  // Helps setting up initial data on the page
  Future<void> setup() async {
    toggleLoader();
    currentSelectedPage.value = WheelOfLifeBodyA(controller: this);
    await fetchLifeAreas();
    await fetchRatingScale();
    await setupTimeProvisionInitialScales();
    toggleLoader();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await setup();
    scrollController.addListener(() {
      toggleBottomButtonVisibility(
        position: scrollController.position.pixels,
        maxPageLimit: scrollController.position.maxScrollExtent,
      );
    });
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}