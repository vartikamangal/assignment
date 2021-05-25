import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

Widget reorderableListItem(String item) {
  final textScale = ScaleManager.textScale.value;
  return Container(
      height: ScaleManager.spaceScale(
        spaceing: 55,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 328,
      ).value,
      margin: const EdgeInsets.only(bottom: 9),
      padding: EdgeInsets.only(
        top: ScaleManager.spaceScale(
          spaceing: 2,
        ).value,
        bottom: ScaleManager.spaceScale(
          spaceing: 2,
        ).value,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: greyLightShade,
        ),
      ),
      key: ValueKey(item),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
                  spaceing: 15,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 17.7,
                ).value),
            child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 13,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 5.3,
                ).value,
                child: SvgPicture.asset(ImagePath.grid)),
          ),
          Text(
            item,
            style: AppTextStyle.darkerBlueMedium.copyWith(fontWeight: FontWeight.w600),
            textScaleFactor: textScale,
          ),
        ],
      ));
}
