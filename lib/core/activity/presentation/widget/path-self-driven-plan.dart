// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/pill-loader.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class PathSelfDrivenPlan extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).canvasColor,
              elevation: 0,
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
                            left: ScaleManager.spaceScale(spaceing: 42).value),
                        child: Text(
                          tr('your plan'),
                          style: AppTextStyle.Askfeeling,
                          textScaleFactor: textScaleFactor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScaleManager.spaceScale(spaceing: 42).value),
                        child: Text(
                          tr('self driven all activities title'),
                          style: AppTextStyle.pathdescription,
                          textScaleFactor: textScaleFactor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: ScaleManager.spaceScale(spaceing: 42).value,
                          top: ScaleManager.spaceScale(spaceing: 13).value,
                          bottom: ScaleManager.spaceScale(spaceing: 13).value,
                        ),
                        child: Text(
                          tr('pick a activity'),
                          style: AppTextStyle.actiontoperform,
                          textScaleFactor: textScaleFactor,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () => _controller.isLoading.value
                        ? Padding(
                          padding:  EdgeInsets.only( left: ScaleManager.spaceScale(spaceing: 29)
                              .value,
                            right: ScaleManager.spaceScale(spaceing: 29)
                                .value,),
                          child: PillLoader(haveDescription: true),
                        )
                        : Column(
                            children: [
                              for (var category
                                  in _controller.recommendationCategories)
                                Container(
                                  margin: EdgeInsets.only(
                                    left: ScaleManager.spaceScale(spaceing: 29)
                                        .value,
                                    right: ScaleManager.spaceScale(spaceing: 29)
                                        .value,
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await _controller
                                          .fetchCategoryActivitiesAndProceed(
                                        category: category,
                                      );
                                    },
                                    child: PlanContainer(
                                      title: category.displayTitle,
                                      description: category.displaySubtitle,
                                      isFaded: false,
                                      requireBottomSpacing: true,
                                      image:category.iconVO!.url,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SafeArea(
            child: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Obx(
            () => _controller.isProcessing.value
                ? CustomizedLinearProgressIndicator()
                : EmptySpacePlaceHolder(),
          ),
        ))
      ],
    );
  }
}
