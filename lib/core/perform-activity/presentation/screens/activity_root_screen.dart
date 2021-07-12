import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/activity/domain/entities/activity.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/perform-activity-controller.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';
import 'package:tatsam_app_experimental/features/instant-relief/presentation/controllers/instant-recommendations-controller.dart';

class ActivityRootScreen extends StatefulWidget {
  final Activity activity;
  final bool isInstantActivity;
  const ActivityRootScreen({
    Key? key,
    required this.activity,
    required this.isInstantActivity,
  }) : super(key: key);

  @override
  _ActivityRootScreenState createState() => _ActivityRootScreenState();
}

class _ActivityRootScreenState extends State<ActivityRootScreen> {
  final PerformActivityController activityController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await activityController.resetPageState();
      activityController.initializeActivityAndProceed(
        activityToStart: widget.activity,
        isInstantActivity: widget.isInstantActivity,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (activityController.activePageState.value) {
        case PageState.LOADING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case PageState.LOADED:
          return activityController.activeStepScreen.value;
        case PageState.FAILURE:
          return Center(
            /// Shitty name, but EmptyState --> ErrorStateUI
            child: EmptyState(),
          );
      }
    });
  }
}
