// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Project imports:
import 'package:tatsam_app_experimental/core/duration-tracker/duration-tracker-controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/content_page_controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/widgets/emotion_selector.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class ActivityCompletionOutro extends StatefulWidget {
  @override
  _ActivityCompletionOutroState createState() =>
      _ActivityCompletionOutroState();
}

class _ActivityCompletionOutroState extends State<ActivityCompletionOutro> {
  //? For getting moods
  final rapportController = Get.find<RapportBuildingController>();
  final _durationController = Get.find<DurationTrackerController>();
  final PerformActivityController _activityController = Get.find();
  final ContentPageController _contentPageController = Get.find();
  //? UI helpers, for a better staggered animation
  double imgHeight = 140.0;
  double opacity = 0;
  bool toShowRatingBar = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          imgHeight = 80.0;
          toShowRatingBar = true;
          opacity = 1;
        });
      });
    } else {
      log('waiting for mounting');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Theme.of(context).canvasColor,
        //   elevation: 0,
        //   leading:Container(),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: ScaleManager.spaceScale(
                  spaceing: 34,
                ).value,
                left: ScaleManager.spaceScale(
                  spaceing: 28,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 28,
                ).value,
              ),
              child: Column(
                children: [
                  Text(
                    'Awesome!',
                    style: AppTextStyle.appreciationtext,
                    textScaleFactor: textScaleFactor,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 10,
                    ).value,
                  ),
                  Text(
                    'You just finished your first practice!',
                    style: AppTextStyle.actiontoperform,
                    textScaleFactor: textScaleFactor,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value,
                  ),
                  AnimatedContainer(
                    height: ScaleManager.spaceScale(
                      spaceing: imgHeight,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 138,
                    ).value,
                    duration: const Duration(milliseconds: 350),
                    child: NotNullImage(
                      image: _activityController.activity.value!.iconVO??'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScaleManager.spaceScale(spaceing: 40).value),
                    child: Obx(
                      () => Text(
                        _activityController.activity.value!.title!,
                        style: AppTextStyle.Askfeeling,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: ScaleManager.spaceScale(spaceing: 20).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 27,
                      ).value,
                      left: ScaleManager.spaceScale(
                        spaceing: 27,
                      ).value,
                    ),
                    child: Text(
                      tr('play section message1'),
                      style: AppTextStyle.growthtext,
                      textAlign: TextAlign.center,
                      textScaleFactor: textScaleFactor,
                    ),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 42,
                    ).value,
                  ),
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 350),
                    child: Column(
                      children: [
                        Obx(
                          () => Text(
                            'How was your experience with ${_activityController.activity.value!.title!}?',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.titleLM.copyWith(
                              color: blueDarkShade,
                              fontWeight: FontWeight.w600,
                            ),
                            textScaleFactor: textScaleFactor,
                          ),
                        ),
                        SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 30,
                          ).value,
                        ),
                        Obx(
                          () => rapportController.isLoadComplete.value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: invalid_use_of_protected_member
                                  children: rapportController.moods.value
                                      .map(
                                        (mood) => emotionSelector(
                                            mood.moodIcon!.url!,
                                          () async {
                                            await _contentPageController
                                                .rateOngoingActivity(
                                                  activityId:
                                                      _activityController
                                                          .onGoingActivityStatus
                                                          .value!
                                                          .id!,
                                                  textFeedback:
                                                      _activityController
                                                          .textFeedback.value,
                                                  mood: mood.moodName,
                                                  elapsedTime:
                                                      _durationController
                                                          .durationInMinutes,
                                                )
                                                .then((value) =>
                                                    _durationController.reset())
                                                .then((value) => _activityController
                                                    .navigatePostActivityCompletion());
                                          },
                                          height: 42,
                                          width: 42,
                                        ),
                                      )
                                      .toList(),
                                )
                              : EmptySpacePlaceHolder(),
                        ),
                        SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 35,
                          ).value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotNullImage extends StatelessWidget {
  String? image;
  NotNullImage({required this.image});
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return  Hero(
      tag: image!,
      child: CachedNetworkImage(
        imageUrl :image!,
        // scale: imageScaleFactor,
      ),
    );
  }
}
