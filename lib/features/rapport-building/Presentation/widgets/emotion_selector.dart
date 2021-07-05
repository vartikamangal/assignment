// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';

Widget emotionSelector(
  String emotion,
  Function() onPressed, {
  required double height,
  required double width,
}) {
  return Container(
    margin: EdgeInsets.only(
      left: ScaleManager.spaceScale(spaceing: 13).value,
      right: ScaleManager.spaceScale(spaceing: 13).value,
    ),
    child: InkWell(
      onTap: onPressed,
      child: Hero(
        tag: emotion,
        child: SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: height,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: width,
          ).value,
          child: Image.asset(
            '${ImagePath.emojiList}${'/$emotion.png'}',
            scale: ScaleManager.imageScale.value,
          ),
        ),
      ),
    ),
  );
}
