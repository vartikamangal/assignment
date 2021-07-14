import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/screens/base_content_widget.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';

class VideoBasedActivity extends BaseContentWidget {
  final PathController _controller = Get.find();
  final PerformActivityController _activityController = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScaleManager.spaceScale(spaceing: 8).value),
                child: TopAppBar(
                  onPressed: () => Get.find<PerformActivityController>()
                      .refreshStateOnBackButtonPress(),
                ),
              ),
              ListView(
                shrinkWrap: true,
                children: [
                  /// Video content
                  Obx(
                    () => _PlayableContent(
                      videoUrl:
                          _activityController.activeStep.value!.stepContent!,
                    ),
                  ),
                  SizedBox(height: ScaleManager.spaceScale(spaceing: 28).value),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ScaleManager.spaceScale(spaceing: 34).value,
                      right: ScaleManager.spaceScale(spaceing: 12).value,
                    ),
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _activityController.activity.value!.title!,
                            style: AppTextStyle.Askfeeling,
                            textScaleFactor: textScaleFactor,
                          ),
                          SizedBox(
                              height:
                                  ScaleManager.spaceScale(spaceing: 6).value),
                          Text(
                            _activityController.activity.value!.subtitle!,
                            style: AppTextStyle.Darkbluebold,
                            textScaleFactor: textScaleFactor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
          ),
        )
      ],
    );
  }
}

/// Actual Video Player Fragment
class _PlayableContent extends StatefulWidget {
  const _PlayableContent({
    Key? key,
    required this.videoUrl,
  }) : super(key: key);
  final String videoUrl;
  @override
  __PlayableContentState createState() => __PlayableContentState();
}

class __PlayableContentState extends State<_PlayableContent> {
  late BetterPlayerDataSource dataSource;
  late BetterPlayerController controller;
  @override
  void initState() {
    dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    controller = BetterPlayerController(
      const BetterPlayerConfiguration(autoPlay: true),
      betterPlayerDataSource: dataSource,
    );
    controller.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        Get.find<PerformActivityController>().footerVisibility = false;
      }
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        //TODO on vedio finished
        Get.find<PerformActivityController>().footerVisibility = true;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BetterPlayer(controller: controller);
  }
}
