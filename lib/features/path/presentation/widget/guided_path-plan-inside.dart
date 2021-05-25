import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/features/path/presentation/widget/plan-container.dart';

import '../../../../core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';

// ignore: must_be_immutable
class GuidedPathPlanInside extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final dayPlan = _controller.selectedDayPlan.value;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueDarkShade,
            size: ScaleManager.spaceScale(spaceing: 26).value,
          ),
        ),
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
                      left: ScaleManager.spaceScale(spaceing: 42).value),
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
    );
  }

  List<PlanContainer> _buildDayPlanInsiderActivities() {
    final List<PlanContainer> _insiderPlanActivities = [];
    for (final activity
        in _controller.selectedDayPlan.value.recommendationList) {
      _insiderPlanActivities.add(
        PlanContainer(
          isFaded: false,
          onPressed: () async {
            await _controller
                .startActivityTrigger(
              activityId: activity.id,
            )
                .then(
              (value) {
                _controller.setGuidedActivityFlow(
                  recommendation: activity,
                );
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
