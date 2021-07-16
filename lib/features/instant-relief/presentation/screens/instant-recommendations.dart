import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';

import '../../../../core/activity/presentation/widget/plan-container.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controllers/instant-relief-controller.dart';

class InstantRecommendationsScreen extends StatelessWidget {
  InstantRecommendationsScreen({Key? key}) : super(key: key);
  final InstantReliefController _instantReliefController = Get.find();
  final InstantRecommendationsController _instantRecommendationsController =
      Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).canvasColor,
            leading: TopAppBar(onPressed: () {
              Navigator.of(context).pop();
            })),
        body: Obx(() {
          switch (_instantRecommendationsController.pageStatus.value) {
            case PageState.LOADING:
              return const Center(
                child: MiniLoader(),
              );
            case PageState.LOADED:
              return CustomScrollView(
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
                            //TODO To be fixed later
                            // UI shouldn't be resposible for handling null values
                            _instantReliefController
                                    .selectedArea.value!.title ??
                                'N/A',
                            style: AppTextStyle.Askfeeling,
                            textScaleFactor: textScaleFactor,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left:
                                  ScaleManager.spaceScale(spaceing: 42).value),
                          child: Text(
                            _instantReliefController
                                    .selectedArea.value!.subtitle ??
                                '',
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
                        for (int i = 0;
                            i <
                                _instantRecommendationsController
                                    .instantRecommendations.length;
                            i++)
                          Container(
                            margin: EdgeInsets.only(
                              left: ScaleManager.spaceScale(spaceing: 29).value,
                              right:
                                  ScaleManager.spaceScale(spaceing: 29).value,
                            ),
                            child: PlanContainer(
                              title: _instantRecommendationsController
                                  .instantRecommendations[i].title,
                              requireBottomSpacing: true,
                              description: "",
                              isFaded: false,
                              image: _instantRecommendationsController
                                  .instantRecommendations[i].iconVO?.url,
                              onPressed: () async {
                                Navigator.of(context).pushNamed(
                                  RouteName.activityScreen,
                                  arguments: {
                                    "activity":
                                        _instantRecommendationsController
                                            .instantRecommendations[i],
                                    "redirectRoute": RouteName.instantRelief,
                                    "isInstantActivity": true,
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            case PageState.FAILURE:
              return const Center(
                /// Shitty name, but EmptyState --> ErrorStateUI
                child: EmptyState(
                  text: "Oops! Something went wrong",
                ),
              );
            default:
              return const MiniLoader();
          }
        }),
      ),
    );
  }
}
