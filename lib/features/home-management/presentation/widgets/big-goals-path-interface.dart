// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

import '../../../../core/activity/presentation/widget/plan-container.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../features/home-management/presentation/controller/home-controller.dart';

class BigGoalsPath extends StatelessWidget {
  const BigGoalsPath({
    Key? key,
    required this.durationController,
    required this.homeController,
  }) : super(key: key);

  final HomeController homeController;
  final DurationTrackerController durationController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildGuidedRecommendedActivites(
        context: context,
      ),
    );
  }

  List<Widget> _buildGuidedRecommendedActivites(
      {required BuildContext context}) {
    final List<Widget> plan = [];
    for (final activity in homeController.recommendedActivities) {
      plan.add(
        Padding(
          padding: EdgeInsets.only(
            bottom: ScaleManager.spaceScale(
              spaceing: 31,
            ).value,
          ),
          child: PlanContainer(
            title: activity.title,
            requireBottomSpacing: false,
            isFaded: false,
            description: '',
            onPressed: () async {
              Navigator.of(context).pushNamed(
                RouteName.activityScreen,
                arguments: {
                  "activity": activity,
                  "isInstantActivity": false,
                },
              );
            },
            image: '${ImagePath.selfDrivenOption}physical.png',
          ),
        ),
      );
    }
    return plan;
  }
}
