import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';

import '../controller/home-controller.dart';

class RenderingConditionChecker extends StatelessWidget {
  final HomeController homeController = Get.find();
  final Widget whatToShow;
  RenderingConditionChecker({
    Key? key,
    required this.whatToShow,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        // If not first time user
        if (!homeController.isFirstTimeUser.value) {
          // and He has remaining actions to fulfill
          if (!homeController.fulfilledAllPostOnboardingActions.value) {
            return EmptySpacePlaceHolder();
          } else {
            return whatToShow;
          }
        }
        // If first time user, then show basic intial recommendation flow
        else {
          return whatToShow;
        }
      },
    );
  }
}
