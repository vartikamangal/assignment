import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/controller/path-controller.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/activity_type_widgets/audio-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/activity_type_widgets/text-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/activity/presentation/widget/activity_type_widgets/video-based-activity-widget.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/mini-loader.dart';

class ActivityContentInjector extends StatelessWidget {
  const ActivityContentInjector({
    Key? key,
    required this.activityType,
  }) : super(key: key);

  final ActivityType activityType;

  @override
  Widget build(BuildContext context) {
    return _buildActivity(activityType: activityType);
  }
}

Widget _buildActivity({required ActivityType activityType}) {
  switch (activityType) {
    case ActivityType.TEXT:
      // Beacsue this content-type doesn't needs
      // footer invisible logic
      Get.find<PathController>().footerVisibility = true;
      return TextBasedActivity();
    case ActivityType.AUDIO:
      return AudioBasedActivity();
    case ActivityType.VIDEO:
      return VideoBasedActivity();
    default:
      return const MiniLoader();
  }
}
