// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/image/image.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

import '../../../../core/responsive/scale-manager.dart';

Widget emotionSelector(
  String? emotionUrl,
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
        tag: emotionUrl ?? fallbackIconUrl,
        child: SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: height,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: width,
          ).value,
          child: CachedNetworkImage(
            imageUrl: emotionUrl ?? fallbackIconUrl,
            placeholder: (context, url) => Padding(
              padding: EdgeInsets.all(ScaleManager.spaceScale(
                spaceing: 12,
              ).value),
              child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 2,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 20,
                ).value,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    blueDarkShade,
                  ),
                  strokeWidth: 2,
                ),
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            //scale: ScaleManager.imageScale.value,
          ),
        ),
      ),
    ),
  );
}
