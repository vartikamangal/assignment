import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/activity-management/data/models/recommendation-activity-model.dart';
import '../../../../core/activity-management/data/models/recommendation-model.dart';
import '../../../../core/activity-management/presentation/controller/path-controller.dart';
import '../../../../core/activity-management/presentation/widget/plan-container.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/instant-relief-controller.dart';

class InstantRecommendationsScreen extends StatelessWidget {
  InstantRecommendationsScreen({Key key}) : super(key: key);
  final DurationTrackerController _durationController = Get.find();
  final PathController _pathController = Get.find();
  final InstantReliefController _instantReliefController = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blueDarkShade,
              size: ScaleManager.spaceScale(
                spaceing: 26,
              ).value,
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
                      _instantReliefController.selectedArea.value.title,
                      style: AppTextStyle.Askfeeling,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 42).value),
                    child: Text(
                      _instantReliefController.selectedArea.value.subtitle,
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
                  //TODO this mess can be cleaned by simply syncing the self and guided api respose key names
                  for (int i = 0;
                      i <
                          _instantReliefController
                              .instantRecommendations.length;
                      i++)
                    Container(
                      margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 29).value,
                        right: ScaleManager.spaceScale(spaceing: 29).value,
                      ),
                      child: PlanContainer(
                        title: _instantReliefController
                            .instantRecommendations[i].title,
                        requireBottomSpacing: true,
                        description: "",
                        isFaded: false,
                        image: '${ImagePath.selfDrivenOption}physical.png',
                        onPressed: _pathController.userSelectedPath.value ==
                                'BIG_GOALS'
                            ? () async {
                                await _pathController
                                    .startActivityTrigger(
                                  activityId: _instantReliefController
                                      .instantRecommendations[i].id,
                                  isInstantActivity: false,
                                )
                                    .then(
                                  (value) {
                                    _pathController.setGuidedActivityFlow(
                                      recommendation: _instantReliefController
                                          .instantRecommendations[i],
                                      selectedActivityIndex: i,
                                    );
                                    _durationController.start();
                                    Get.toNamed(
                                      RouteName.selfPathInfoSection1,
                                    );
                                  },
                                );
                              }
                            // If user selected path is [null] or Small_wins
                            : () async {
                                _pathController.setRecommendation(
                                  recommendation: RecommendationModel(
                                    activity: _instantReliefController
                                            .instantRecommendations[i]
                                        as ActivityRecommendationModel,
                                    weight: 0.5,
                                  ),
                                );
                                await _pathController.startActivityTrigger(
                                  activityId: _instantReliefController
                                      .instantRecommendations[i].id,
                                  isInstantActivity: true,
                                );
                                _durationController.start();
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
      ),
    );
  }
}
