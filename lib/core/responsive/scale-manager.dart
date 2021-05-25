import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

// Figma design mockup width
const kMockupWidth = 411.0;

class ScaleManager extends GetxController {
  static RxDouble textScale = RxDouble(Get.size.width / kMockupWidth);
  static RxDouble imageScale = RxDouble(kMockupWidth / Get.size.width);
  static RxDouble spaceScale({@required double spaceing}) => RxDouble(
        spaceing / kMockupWidth * Get.width,
      );

  ScaleManager._();
}
