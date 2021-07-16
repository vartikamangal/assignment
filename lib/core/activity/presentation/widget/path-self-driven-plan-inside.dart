// Flutter imports:

import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/pill-loader.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';

import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class PathSelfDrivenPlanInside extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          leading: TopAppBar(
            onPressed: () {
              Navigator.of(context).pop();
            },
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
                      top: ScaleManager.spaceScale(spaceing: 2).value,
                    ),
                    child: Text(
                      _controller.selectedCategory.value!.displayTitle!,
                      style: AppTextStyle.Askfeeling,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 42).value,
                      right: ScaleManager.spaceScale(spaceing: 30).value,
                    ),
                    child: Text(
                      _controller
                          .selectedCategory.value!.categoryDetailedDescription!,
                      style: AppTextStyle.pathdescription,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 42).value,
                      top: ScaleManager.spaceScale(spaceing: 13).value,
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
            if (_controller.recommendationActivities.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScaleManager.spaceScale(spaceing: 34).value,
                      left: ScaleManager.spaceScale(spaceing: 42).value,
                      right: ScaleManager.spaceScale(spaceing: 57).value),
                  child: const EmptyState(
                    text: "Oops! No content found",
                  ),
                ),
              )
            else
              SliverToBoxAdapter(
                child: Obx(
                  () => _controller.isLoading.value
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: ScaleManager.spaceScale(spaceing: 29).value,
                            right: ScaleManager.spaceScale(spaceing: 29).value,
                          ),
                          child: PillLoader(haveDescription: false),
                        )
                      : Column(
                          children: [
                            for (var activity
                                in _controller.recommendationActivities)
                              Container(
                                margin: EdgeInsets.only(
                                  left: ScaleManager.spaceScale(spaceing: 29)
                                      .value,
                                  right: ScaleManager.spaceScale(spaceing: 29)
                                      .value,
                                ),
                                child: PlanContainer(
                                  title: activity.activity.title,
                                  requireBottomSpacing: true,
                                  description: "",
                                  isFaded: false,
                                  image: activity.activity.iconVO?.url,
                                  onPressed: () async {
                                    Navigator.of(context).pushNamed(
                                      RouteName.activityScreen,
                                      arguments: {
                                        "activity": activity.activity,
                                        "isInstantActivity": false,
                                        "redirectRoute":
                                            RouteName.onBoardingIncomplete,
                                      },
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
