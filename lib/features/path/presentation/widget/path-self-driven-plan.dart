import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../data/models/recommendation-category-model.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class PathSelfDrivenPlan extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Scaffold(
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
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(Get.width, 2),
          child: Obx(
            () => _controller.isProcessing.value
                ? const LinearProgressIndicator()
                : EmptySpacePlaceHolder(),
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
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        for (var category
                            in _controller.recommendationCategories)
                          Container(
                            margin: EdgeInsets.only(
                              left: ScaleManager.spaceScale(spaceing: 29).value,
                              right:
                                  ScaleManager.spaceScale(spaceing: 29).value,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                await _controller
                                    .fetchCategoryActivitiesAndProceed(
                                  categoryModel:
                                      category as RecommendationCategoryModel,
                                );
                              },
                              child: PlanContainer(
                                title: category.displayTitle,
                                description: category.displaySubtitle,
                                isFaded: false,
                                image:
                                    '${ImagePath.selfDrivenOption}${category.categoryName.toLowerCase()}.png',
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
