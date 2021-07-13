// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';

Widget emotionSelector(
  String emotionUrl,
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
        tag: emotionUrl,
        child: SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: height,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: width,
          ).value,
          child: CachedNetworkImage(
            imageUrl: emotionUrl,
            //placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            //scale: ScaleManager.imageScale.value,
          ),
        ),
      ),
    ),
  );
}
