// Flutter imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/widgets/circular-shimmer-loading.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class ReliefAreaCard extends StatelessWidget {
  const ReliefAreaCard({
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
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 100,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 106,
                ).value,
                child: CachedNetworkImage(
                  imageUrl: imageAddress!,
                  height: ScaleManager.spaceScale(spaceing: 100).value,
                  placeholder: (_, __) =>
                      const CircularShimmerLoader(width: 100, height: 100),
                ),
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 8,
              ).value,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ScaleManager.spaceScale(
                  spaceing: 120,
                ).value,
              ),
              child: Text(
                title!,
                style: AppTextStyle.greysmall,
                textAlign: TextAlign.center,
                textScaleFactor: textScaleFactor,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 50,
              ).value,
            ),
          ],
        ),
      ],
    );
  }
}
