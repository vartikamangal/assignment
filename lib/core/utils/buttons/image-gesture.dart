// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../responsive/scale-manager.dart';

class ImageGesture extends StatelessWidget {
  String imageAddress;
  Callback onPressed;
  double width;
  ImageGesture({this.imageAddress, this.width, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
          height: Get.height * 0.25,
          width: width,
          child: Image.asset(
            imageAddress,
            scale: imageScaleFactor,
          )),
    );
  }
}
