// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

class RadialBoxForPathSelection extends StatelessWidget {
  final Callback onPressed;
  final String title;
  final String subtitle;
  final String imgUrl;
  const RadialBoxForPathSelection({
    this.onPressed,
    this.title,
    this.imgUrl,
    this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: ScaleManager.spaceScale(
                spaceing: 85,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 328,
              ).value,
              padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
                  spaceing: 80,
                ).value,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ScaleManager.spaceScale(spaceing: 85 / 2).value,
                  ),
                ),
                border: Border.all(
                  color: greyLightShade,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.choosePathOption,
                    textScaleFactor: textScaleFactor,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Get.width * 0.08,
                            top: ScaleManager.spaceScale(
                              spaceing: 3,
                            ).value,
                          ),
                          child: Text(
                            subtitle,
                            style: AppTextStyle.choosepathSubtitle,
                            textAlign: TextAlign.justify,
                            textScaleFactor: textScaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              left: ScaleManager.spaceScale(
                spaceing: -20,
              ).value,
              top: ScaleManager.spaceScale(
                spaceing: -5,
              ).value,
              child: Container(
                height: ScaleManager.spaceScale(
                  spaceing: 91,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 91,
                ).value,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  imgUrl,
                  scale: imageScaleFactor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
