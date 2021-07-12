import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/perform-activity/presentation/controllers/content_page_controller.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-state.dart';

class ActivityContentInjector extends StatelessWidget {
  ActivityContentInjector({
    Key? key,
  }) : super(key: key);
  final ContentPageController _contentPageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (_contentPageController.contentUIStatus.value) {
        case ContentUIStatus.INITIALIZING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case ContentUIStatus.LOADED:
          return _contentPageController.contentWidget.value!;
        case ContentUIStatus.FAILED:
          return Center(
            child: EmptyState(),
          );
      }
    });
  }
}
