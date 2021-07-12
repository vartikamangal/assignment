import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';

import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../controller/home-controller.dart';
import 'feedback-view.dart';
import 'recommendation-view.dart';

class ViewInjector extends StatelessWidget {
  const ViewInjector({
    Key? key,
    required this.homeController,
    required this.durationController,
    required this.activityController,
    required this.rapportBuildingController,
  }) : super(key: key);

  final HomeController homeController;

  final DurationTrackerController durationController;
  final PerformActivityController activityController;
  final RapportBuildingController rapportBuildingController;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // If not first time user
        if (!homeController.isFirstTimeUser.value) {
          // and He has remaining actions to fulfill
          if (!homeController.fulfilledAllPostOnboardingActions.value) {
            return FeedbackView(
              isGuidedPlan: homeController.chosenPath.value == 'BIG_GOALS',
              activityController: activityController,
              durationController: durationController,
              rapportBuildingController: rapportBuildingController,
              homeController: homeController,
            );
          }
          //! Remove this logic from here
          // and if no actions are remaining but day is SUNDAY
          // else if (homeController.fulfilledAllPostOnboardingActions.value &&
          //     homeController.getActiveDay() == 'Sun') {
          //   return const SliverToBoxAdapter(
          //     child: Text('Show the weekend UI'),
          //   );
          // }
          else {
            return RecommendationView(
              controller: homeController,
              durationController: durationController,
            );
          }
        }
        // If first time user, then show basic intial recommendation flow
        else {
          return RecommendationView(
            controller: homeController,
            durationController: durationController,
          );
        }
      },
    );
  }
}
