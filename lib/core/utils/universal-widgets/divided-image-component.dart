// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../color-pallete.dart';
import 'circular-image-loader.dart';
Widget DividedImageComponent({required String? imgUrl}) {
  final imageScaleFactor = ScaleManager.imageScale.value;
  return SizedBox(
    height: ScaleManager.spaceScale(
      spaceing: 130,
    ).value,
    child: Stack(
      children: [
        Align(
          child: Divider(
            color: greyline,
          ),
        ),
        Align(
          child: SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 92,
            ).value,
            width: ScaleManager.spaceScale(
              spaceing: 91,
            ).value,
            child: CachedNetworkImage(
              imageUrl:imgUrl!,
              placeholder: (context, url) =>CircularImageLoader(height: ScaleManager.spaceScale(
                spaceing: 92,
              ).value,),
              height: ScaleManager.spaceScale(
                spaceing: 92,
              ).value,
            ),
          ),
        ),
      ],
    ),
  );
}
