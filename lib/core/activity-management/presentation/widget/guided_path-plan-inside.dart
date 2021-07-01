// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/duration-tracker/duration-tracker-controller.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class GuidedPathPlanInside extends StatelessWidget {
  final PathController _controller = Get.find();
  final DurationTrackerController _durationController = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final dayPlan = _controller.selectedDayPlan.value;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: TopAppBar(onPressed: (){Navigator.pop(context);}),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ScaleManager.spaceScale(spaceing: 60).value,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 42,
                      ).value,
                    ),
                    child: Text(
                      dayPlan.title,
                      style: AppTextStyle.Askfeeling,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 42).value),
                    child: Text(
                      dayPlan.subtitle,
                      style: AppTextStyle.pathdescription,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  SizedBox(height: ScaleManager.spaceScale(spaceing: 13).value),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 42).value),
                    child: Text(
                      tr('pick one'),
                      style: AppTextStyle.actiontoperform,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 25,
                    ).value,
                  ),
                ],
              ),
            ),
            if (_controller.selectedDayPlan.value.recommendationList.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScaleManager.spaceScale(spaceing: 34).value,
                      left: ScaleManager.spaceScale(spaceing: 42).value,
                      right: ScaleManager.spaceScale(spaceing: 57).value),
                  child: EmptyState(),
                ),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScaleManager.spaceScale(
                    spaceing: 28,
                  ).value,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: _buildDayPlanInsiderActivities(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<PlanContainer> _buildDayPlanInsiderActivities() {
    final List<PlanContainer> _insiderPlanActivities = [];
    for (int i = 0;
        i < _controller.selectedDayPlan.value.recommendationList.length;
        i++) {
      final activity = _controller.selectedDayPlan.value.recommendationList[i];
      _insiderPlanActivities.add(
        PlanContainer(
          isFaded: false,
          requireBottomSpacing: true,
          onPressed: () async {
            await _controller
                .startActivityTrigger(
              activityId: activity.id,
              isInstantActivity: false,
            )
                .then(
              (value) {
                _controller.setGuidedActivityFlow(
                  recommendation: activity,
                  selectedActivityIndex: i,
                );
                _durationController.start();
                Get.toNamed(
                  RouteName.selfPathInfoSection1,
                );
              },
            );
          },
          title: activity.title.toString(),
          description: '',
          image: '${ImagePath.guidedOption}day 2.png',
        ),
      );
    }
    return _insiderPlanActivities;
  }
}
