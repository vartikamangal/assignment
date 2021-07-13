import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../../../core/activity/data/models/recommendation-category-model.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/home-controller.dart';
import 'path-checker.dart';

class WeekendUiFragment extends StatelessWidget {
  WeekendUiFragment({
    Key? key,
  }) : super(key: key);

  final HomeController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScaleManager.spaceScale(
          spaceing: 13,
        ).value,
      ),
      child: Column(
        children: [
          Text(
            'You’ve had a very successful week.',
            style: AppTextStyle.greyHint,
            textAlign: TextAlign.center,
            textScaleFactor: textScaleFactor,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 4,
            ).value,
          ),
          PathChecker(
            userPath: controller.chosenPath.value,
            widgetForBigGoals: Text(
              'Here is an overview of your upcoming week',
              style: AppTextStyle.greyHint,
              textAlign: TextAlign.center,
              textScaleFactor: textScaleFactor,
            ),
            widgetForSmallWins: Obx(
              () => Text(
                controller.haveChosenCategory.value
                    ? 'Which activity would you like to continue in the coming week?'
                    : 'What area would you like to focus on next week?',
                style: AppTextStyle.greyHint,
                textAlign: TextAlign.center,
                textScaleFactor: textScaleFactor,
              ),
            ),
            isNewUser: controller.isFirstTimeUser.value,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 31,
            ).value,
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 150,
            ).value,
            width: MediaQuery.of(context).size.width,
            child: Obx(
              //! This condition decides wheather to show sub-activities or categories
              () => controller.haveChosenCategory.value
                  ? GridView.builder(
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 24 / 8,
                      ),
                      itemBuilder: (context, index) {
                        final activity =
                            controller.subActivitesOfCategories[index];
                        return SmallActivityPill(
                          title: activity.activity.title,
                          onPressed: () async {
                            await controller.updateWeeklyActivity(
                              category: activity
                                  .activity.categoryVO!.displayTitle!
                                  .toUpperCase(),
                              recommendationId: activity.activity.id,
                            );
                          },
                        );
                      },
                      itemCount: controller.subActivitesOfCategories.length,
                    )
                  : GridView.builder(
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 24 / 8,
                      ),
                      itemBuilder: (context, index) {
                        final category =
                            controller.categoriesForWeeklyFeedback[index];
                        return SmallActivityPill(
                          title: category.displayTitle,
                          onPressed: () async {
                            await controller.fetchAcitivitiesForCategory(
                              category: category as RecommendationCategoryModel,
                            );
                          },
                        );
                      },
                      itemCount: controller.categoriesForWeeklyFeedback.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

//Have to add image from server
class SmallActivityPill extends StatelessWidget {
  const SmallActivityPill({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  final String? title;
  final Callback onPressed;
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: ScaleManager.spaceScale(
                  spaceing: 2,
                ).value,
                left: ScaleManager.spaceScale(
                  spaceing: 5,
                ).value),
            child: Container(
              constraints: BoxConstraints(
                  minHeight: ScaleManager.spaceScale(
                spaceing: 45,
              ).value),
              width: ScaleManager.spaceScale(
                spaceing: 380,
              ).value,
              decoration: BoxDecoration(
                //color: Colors.red,
                border: Border.all(
                  color: greyLightShade,
                  width: ScaleManager.spaceScale(
                    spaceing: 2,
                  ).value,
                ),
                borderRadius: BorderRadius.circular(
                  ScaleManager.spaceScale(
                    spaceing: 42,
                  ).value,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScaleManager.spaceScale(
                    spaceing: 3,
                  ).value,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ScaleManager.spaceScale(
                      spaceing: 42,
                    ).value,
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          title!,
                          style: AppTextStyle.Darkbluebold.copyWith(
                            fontWeight: FontWeight.w500,
                            color: blueDarkerShade,
                          ),
                          textScaleFactor: textScaleFactor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 47,
              ).value,
              child: Image.asset(
                '${ImagePath.selfDrivenOption}physical.png',
                scale: imageScaleFactor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
