// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/activity-management/data/models/recommendation-activity-model.dart';
import '../../../../core/activity-management/data/models/recommendation-model.dart';
import '../../../../core/activity-management/presentation/controller/path-controller.dart';
import '../../../../core/activity-management/presentation/widget/plan-container.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../features/home-management/presentation/controller/home-controller.dart';

class SmallWinsPath extends StatelessWidget {
  const SmallWinsPath({
    Key key,
    @required this.controller,
    @required this.pathController,
    @required this.durationController,
  }) : super(key: key);

  final HomeController controller;
  final PathController pathController;
  final DurationTrackerController durationController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          CarouselSlider(
            items: controller.recommendedActivities
                .map(
                  (excerciseName) => PlanContainer(
                    title: excerciseName.title,
                    requireBottomSpacing: false,
                    isFaded: false,
                    description: '',
                    onPressed: () async {
                      ///todo Do anything which will lead to start-of-activity
                      pathController.setRecommendation(
                        recommendation: RecommendationModel(
                          activity:
                              excerciseName as ActivityRecommendationModel,
                          weight: 0,
                        ),
                      );
                      await pathController.startActivityTrigger(
                        activityId: excerciseName.id,
                        isInstantActivity: false,
                      );
                      durationController.start();
                      Navigator.of(context).pushNamed(
                        RouteName.selfPathInfoSection1,
                      );
                    },
                    image: '${ImagePath.selfDrivenOption}physical.png',
                  ),
                )
                .toList(),
            options: CarouselOptions(
              pageViewKey: const PageStorageKey('carousel-page'),
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 33 / 9,
              onPageChanged: (index, reason) {
                controller.updateIndicator = index;
              },
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicators(
                currentIndex: controller.currentActiveIndicator.value,
                total: controller.recommendedActivities.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Generates a set of indicators
List<Widget> _buildIndicators({
  @required int currentIndex,
  @required int total,
}) {
  final List<Widget> _dots = [];
  for (int i = 0; i < total; i++) {
    if (i == currentIndex) {
      _dots.add(
        _Indicator(
          color: Colors.grey[600],
        ),
      );
    } else {
      _dots.add(
        _Indicator(
          color: Colors.grey[300],
        ),
      );
    }
  }
  return _dots;
}

/// Individual indicator dot
class _Indicator extends StatelessWidget {
  const _Indicator({
    Key key,
    @required this.color,
  }) : super(key: key);

  final Color color;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      height: ScaleManager.spaceScale(
        spaceing: 6,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 6,
      ).value,
      margin: EdgeInsets.only(
        right: ScaleManager.spaceScale(
          spaceing: 3,
        ).value,
      ),
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
