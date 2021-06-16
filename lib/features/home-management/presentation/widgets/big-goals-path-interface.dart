// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/activity-management/presentation/controller/path-controller.dart';
import '../../../../core/activity-management/presentation/widget/plan-container.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../features/home-management/presentation/controller/home-controller.dart';

class BigGoalsPath extends StatelessWidget {
  const BigGoalsPath({
    Key key,
    @required this.durationController,
    @required this.homeController,
    @required this.pathController,
  }) : super(key: key);

  final HomeController homeController;
  final DurationTrackerController durationController;
  final PathController pathController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildGuidedRecommendedActivites(
        context: context,
      ),
    );
  }

  List<Widget> _buildGuidedRecommendedActivites(
      {@required BuildContext context}) {
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
              ///todo Do anything which will lead to start-of-activity
              log(activity.title);
              pathController.setGuidedActivityFlow(
                recommendation: activity,
                //TODO figure out a technique for fixing it out
                selectedActivityIndex: 0,
              );
              await pathController.startActivityTrigger(
                activityId: activity.id,
                isInstantActivity: false,
              );
              durationController.start();
              Navigator.of(context).pushNamed(
                RouteName.selfPathInfoSection1,
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
