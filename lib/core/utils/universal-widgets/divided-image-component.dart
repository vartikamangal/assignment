// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../color-pallete.dart';

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
