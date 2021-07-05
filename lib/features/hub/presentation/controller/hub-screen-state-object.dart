// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import 'hub-controller.dart';

class HubScreenStateObject extends Equatable {
  final String heroImageUrl;
  final String title;
  final String subtitle;
  final Callback onImageTap;
  const HubScreenStateObject({
    required this.heroImageUrl,
    required this.title,
    required this.subtitle,
    required this.onImageTap,
  });
  @override
  List<Object> get props => [heroImageUrl, title, subtitle, onImageTap];

  @override
  bool get stringify => true;
}

// Data Holder for HubScreen State Object
Map<HubAnswerStatus, HubScreenStateObject> kHubScreenStateObjectMap = {
  HubAnswerStatus.nothingAnswered: HubScreenStateObject(
    heroImageUrl: ImagePath.hubLife,
    title: 'MY LIFE',
    subtitle:
        'Let’s build a picture of your current self. This will help us design your plan and provide recommendations that work best for you.',
    onImageTap: () {
      Get.toNamed(RouteName.wheelOfLifeScreen);
    },
  ),
  HubAnswerStatus.wheelOfLifeAnswered: HubScreenStateObject(
    heroImageUrl: ImagePath.hubTarget,
    title: 'My Target',
    subtitle:
        'Your path is unique and individual. Once we understand your context and environment we’ll support you through the process',
    onImageTap: () {
      Get.toNamed(RouteName.focusScreen);
    },
  ),
  HubAnswerStatus.targetAnswered: HubScreenStateObject(
    heroImageUrl: ImagePath.hubSymptoms,
    title: 'My Symptoms',
    subtitle:
        'Helping us understand you will help you understand yourself and will help us create your customised journey to positive change…',
    onImageTap: () async {
      Get.toNamed(RouteName.questionTrackScreen);
    },
  ),
  HubAnswerStatus.allAnswered: HubScreenStateObject(
    heroImageUrl: ImagePath.hubAllAnswered,
    title: '',
    subtitle:
        'Amazing! We now have a complete understanding of where you are currently in your journey. Now, lets start from here and take you to growth in all dimensions',
    onImageTap: () async {
      await Get.find<HubController>().createNewTravellerAndMoveAhead();
    },
  ),
};
