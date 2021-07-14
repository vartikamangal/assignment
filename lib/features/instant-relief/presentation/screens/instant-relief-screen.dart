// Dart imports:
import 'dart:io';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/grid-style-loader.dart';
import 'package:tatsam_app_experimental/features/instant-relief/data/models/instant-relief-area-model.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/middle-call-us-button.dart';
import '../../../../core/utils/buttons/toprightcallbutton.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/instant-relief-controller.dart';
import '../widgets/instant-relief-area-widget.dart';

class InstantReliefScreen extends StatelessWidget {
  final _controller = Get.find<InstantReliefController>();
  final _recommendationController =
      Get.find<InstantRecommendationsController>();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            elevation: 0,
            leading: TopAppBar(onPressed: () {
             // print(_controller.instantLifeAreas[1].icon);
              Get.back();
            })),
        body: CustomScrollView(
          physics: Platform.isIOS
              ? const BouncingScrollPhysics()
              : const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 21,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 21,
                  ).value,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 61,
                      ).value,
                    ),
                    Text(
                      tr('instant relief'),
                      style: AppTextStyle.boldText,
                      textAlign: TextAlign.center,
                      textScaleFactor: textScaleFactor.value,
                    ),
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                    ),
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 65,
                      ).value,
                      width: ScaleManager.spaceScale(
                        spaceing: 226,
                      ).value,
                      child: TopRightCallbutton(
                        onPressed: () {
                          launch(
                            "tel://+91-123123123",
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 19,
                      ).value,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(
                          spaceing: 23,
                        ).value,
                        right: ScaleManager.spaceScale(
                          spaceing: 22,
                        ).value,
                      ),
                      height: 1,
                      width: Get.width,
                      color: greyline,
                    ),
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 30,
                      ).value,
                    ),
                    Text(
                      tr('instant relief description'),
                      style: AppTextStyle.greyText,
                      textAlign: TextAlign.center,
                      textScaleFactor: textScaleFactor.value,
                    ),
                    MiddleCallUsButton(
                      title: 'Call us',
                      onPressed: () {
                        launch(
                          "tel://+91-123123123",
                        );
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(
                          spaceing: 23,
                        ).value,
                       /* bottom: ScaleManager.spaceScale(
                          spaceing: 33,
                        ).value,*/
                        top: ScaleManager.spaceScale(
                          spaceing: 33,
                        ).value,
                        right: ScaleManager.spaceScale(
                          spaceing: 22,
                        ).value,
                      ),
                      height: 1,
                      width: Get.width,
                      color: greyline,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Obx(
              () => _controller.isProcessing.value
                  ? const GridLoaderScreen()
                  : Padding(
                      padding: EdgeInsets.only(
                        left: ScaleManager.spaceScale(
                          spaceing: 46,
                        ).value,
                        top: ScaleManager.spaceScale(
                      spaceing: 33,
                      ).value,
                        right: ScaleManager.spaceScale(
                          spaceing: 58,
                        ).value,
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(
                            _controller.instantLifeAreas.length, (index) {
                          final area = _controller.instantLifeAreas[index];
                          return ReliefAreaCard(
                            imageAddress:area.icon!.url ,
                            title: area.title,
                            onTap: () async {
                              _controller.instantReliefArea =
                                  area as InstantReliefAreaModel;
                              await _recommendationController
                                  .fetchInstantRecommendations(
                                instantLifeArea: area,
                              );
                            },
                          );
                        }),
                      ),
                    ),
            )),
          ],
        ),
      ),
    );
  }

  //! Not in use currently
  // List<Widget> _buildInstantReliefAreas() {
  //   final List<Widget> _areas = [];
  //   int areaFillCount = 0;

  //   while (areaFillCount < _controller.instantLifeAreas.length) {
  //     final area = _controller.instantLifeAreas[areaFillCount];
  //     _areas.add(
  //       Padding(
  //         padding: EdgeInsets.only(
  //           bottom: ScaleManager.spaceScale(
  //             spaceing: 46,
  //           ).value,
  //         ),
  //         child: FocusCard(
  //           imageAddress: '${ImagePath.selfDrivenOption}physical.png',
  //           title: _controller.instantLifeAreas[areaFillCount].title,
  //           onTap: () {},
  //         ),
  //       ),
  //     );
  //     areaFillCount = areaFillCount + 2;
  //   }
  //   return _areas;
  // }
}
