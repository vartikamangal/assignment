// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/wheel-of-life-controller.dart';

Widget reorderableListItem(String item) {
  final WheelOfLifeController controller = Get.find();
  final textScale = ScaleManager.textScale.value;
  return ReorderableDragStartListener(
    key: ValueKey(item),
    index: Random().nextInt(
      controller.lifeAreas.length,
    ),
    child: Column(
      children: [
        Container(
          height: ScaleManager.spaceScale(
            spaceing: 55,
          ).value,
          width: ScaleManager.spaceScale(
            spaceing: 328,
          ).value,
          padding: EdgeInsets.only(
            top: ScaleManager.spaceScale(
              spaceing: 2,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 2,
            ).value,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ScaleManager.spaceScale(
                spaceing: 30,
              ).value),
              border: Border.all(
                color: const Color.fromRGBO(171, 174, 178, 0.5),
              ),
              color: Colors.white),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 15,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 17.7,
                  ).value,
                ),
                child: SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 13,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 5.3,
                  ).value,
                  child: SvgPicture.asset(
                    ImagePath.grid,
                  ),
                ),
              ),
              Text(
                item,
                style: AppTextStyle.darkerBlueMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromRGBO(5, 1, 85, 1),
                ),
                textScaleFactor: textScale,
              ),
            ],
          ),
        ),
        Container(
          height: ScaleManager.spaceScale(
            spaceing: 9,
          ).value,
          color: Colors.transparent,
        )
      ],
    ),
  );
}
