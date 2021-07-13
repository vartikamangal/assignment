// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class FocusCard extends StatelessWidget {
  const FocusCard({
    Key? key,
    required this.imageAddress,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String? imageAddress;
  final String? title;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: ScaleManager.spaceScale(
              spaceing: 125,
            ).value
          ),
          child: GestureDetector(
            onTap: onTap,
            child: SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 100,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 106,
              ).value,
              child: Hero(
                tag: imageAddress!,
                child: CachedNetworkImage(
                  imageUrl: imageAddress!,
                  height: 100,
                 // scale: imageScaleFactor,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 8,
          ).value,
        ),
        Text(
          title!,
          style: AppTextStyle.greysmall,
          textScaleFactor: textScaleFactor,
        ),
      ],
    );
  }
}
