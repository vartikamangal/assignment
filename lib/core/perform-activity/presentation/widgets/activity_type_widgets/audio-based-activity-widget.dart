import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/get-formatted-player-position-string.dart';
import 'package:tatsam_app_experimental/core/utils/helper_functions/player-position-calculator.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/linear-progress-indicator.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';

class AudioBasedActivity extends StatelessWidget {
  AudioBasedActivity({
    Key? key,
  }) : super(key: key);
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopAppBar(
                onPressed: () => Get.find<PerformActivityController>()
                    .refreshStateOnBackButtonPress(),
              ),
              ListView(
                shrinkWrap: true,
                children: const [
                  /// Audio-visual content
                  _PlayableContent(videoUrl: testPlayable),
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
        ),
      ],
    );
  }
}

const String testPlayable =
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3";
const String testLoopingAnimation =
    "https://cdn.dribbble.com/users/405145/screenshots/4191607/yogabreathing_1_4x3.gif";

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
  final BetterPlayerDataSource dataSource =
      BetterPlayerDataSource(BetterPlayerDataSourceType.network, testPlayable);
  late BetterPlayerController controller;

  /// for linear progress indicator
  double playerPosition = 0.0;

  /// For elapsedTime below FAB
  Duration elapsedTime = const Duration();
  @override
  void initState() {
    controller = BetterPlayerController(
      const BetterPlayerConfiguration(autoPlay: true),
      betterPlayerDataSource: dataSource,
    );
    controller.addEventsListener((event) {
      /// This is just to be safe, Whenever player is
      /// initialized make the footer invisible
      if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
        Get.find<PerformActivityController>().footerVisibility = false;
      }

      /// Once the playable content is finished
      /// Make the footer visible
      if (event.betterPlayerEventType == BetterPlayerEventType.finished) {
        Get.find<PerformActivityController>().footerVisibility = true;
      }

      /// Each time progress event is triggered in player
      /// new position for PIndicator is calculated
      /// And elapsedTime variable is refreshed
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        playerPosition = calculatePosition(
          controller.videoPlayerController!.value.position,
          controller.videoPlayerController!.value.duration!,
        );
        elapsedTime = controller.videoPlayerController!.value.position;
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _toggleControllerState() {
    if (controller.isPlaying()!) {
      controller.pause();
    } else {
      controller.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.61,
          child: Stack(
            fit: StackFit.expand,
            children: [
              IgnorePointer(
                child: Opacity(
                  opacity: 0,
                  child: BetterPlayer(controller: controller),
                ),
              ),

              /// Looping animation thing will go here
              Image.network(testLoopingAnimation),
            ],
          ),
        ),
        LinearProgressIndicator(
          backgroundColor: greyLightShade,
          value: playerPosition,
        ),
        SizedBox(
          height: ScaleManager.spaceScale(spaceing: 24).value,
        ),
        if (!controller.isVideoInitialized()!)
          Container(
            height: ScaleManager.spaceScale(spaceing: 78).value,
            width: ScaleManager.spaceScale(spaceing: 78).value,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: blueDarkShade,
            ),
            child: const Center(
              child: MiniLoader(),
            ),
          )
        else
          GestureDetector(
            onTap: () {
              _toggleControllerState();
            },
            child: Container(
              height: ScaleManager.spaceScale(spaceing: 78).value,
              width: ScaleManager.spaceScale(spaceing: 78).value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: blueDarkShade,
              ),
              child: Center(
                child: Icon(
                  controller.isPlaying()! ? Icons.pause : Icons.play_arrow,
                  size: ScaleManager.spaceScale(spaceing: 55).value,
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ),
        SizedBox(height: ScaleManager.spaceScale(spaceing: 6).value),
        Text(
          getFormattedPlayerPosition(elapsedTime),
          style: AppTextStyle.verySmallGreyText.copyWith(
            fontSize: 23,
            color: blueDarkShade,
          ),
          textScaleFactor: ScaleManager.textScale.value,
        ),
      ],
    );
  }
}
