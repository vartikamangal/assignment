import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/universal-widgets/pill-loader.dart';
import '../controller/home-controller.dart';
import 'big-goals-path-interface.dart';
import 'small-path-interface.dart';

class RecommendationView extends StatelessWidget {
  const RecommendationView({
    Key? key,
    required this.controller,
    required this.durationController,
  }) : super(key: key);

  final HomeController controller;
  final DurationTrackerController durationController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          bottom: ScaleManager.spaceScale(
            spaceing: 40,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
        ),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return PillLoaderComponent();
            } else {
              return controller.chosenPath.value == 'BIG_GOALS'
                  ? BigGoalsPath(
                      homeController: controller,
                      durationController: durationController,
                    )
                  : SmallWinsPath(
                      controller: controller,
                      durationController: durationController,
                    );
            }
          },
        ),
      ),
    );
  }
}
