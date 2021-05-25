import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/features/path/data/models/recommendation-model.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class PathSelfDrivenPlanInside extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(RouteName.pathSelfDrivenPlan);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueDarkShade,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 42).value,
                      top: ScaleManager.spaceScale(spaceing: 2).value),
                  child: Text(
                    _controller.selectedCategory.value.displayTitle,
                    style: AppTextStyle.Askfeeling,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 42).value),
                  child: Text(
                    _controller
                        .selectedCategory.value.categoryDetailedDescription,
                    style: AppTextStyle.pathdescription,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: ScaleManager.spaceScale(spaceing: 42).value,
                    top: ScaleManager.spaceScale(spaceing: 9).value,
                    bottom: ScaleManager.spaceScale(spaceing: 12).value,
                  ),
                  child: Text(
                    'Pick one to start',
                    style: AppTextStyle.actiontoperform,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                for (var activity in _controller.recommendationActivities)
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 29).value,
                      right: ScaleManager.spaceScale(spaceing: 29).value,
                    ),
                    child: PlanContainer(
                      title: activity.activity.title,
                      description: "",
                      isFaded: false,
                      image:
                          '${ImagePath.selfDrivenOption}${activity.activity.categoryVO.displayTitle.toLowerCase()}.png',
                      onPressed: () async {
                        _controller.setRecommendation(
                          recommendation: activity as RecommendationModel,
                        );
                        await _controller.startActivityTrigger(
                          activityId: activity.activity.id,
                        );
                        Navigator.of(context).pushNamed(
                          RouteName.selfPathInfoSection1,
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
