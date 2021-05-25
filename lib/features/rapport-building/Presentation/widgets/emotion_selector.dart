import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

Widget emotionSelector(String emotion, Function() onPressed) {
  return Container(
    margin: EdgeInsets.only(
      right: ScaleManager.spaceScale(
        spaceing: 24.5,
      ).value,
    ),
    child: InkWell(
      onTap: onPressed,
      child: Hero(
        tag: emotion,
        child: SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 48,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: 48,
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
