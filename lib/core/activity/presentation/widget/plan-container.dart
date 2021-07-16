// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/widgets/circular-shimmer-loading.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
// ignore: must_be_immutable

class PlanContainer extends StatelessWidget {
  String? title;
  String? description;
  String? image;
  Callback? onPressed;
  bool? isFaded;
  bool requireBottomSpacing;
  PlanContainer({
    this.description,
    this.title,
    this.image,
    this.onPressed,
    this.isFaded,
    required this.requireBottomSpacing,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: isFaded! ? () {} : onPressed,
      // ignore: avoid_unnecessary_containers
      child: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 85,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: Get.width,
                  ).value,
                  margin: EdgeInsets.only(
                      top: ScaleManager.spaceScale(
                        spaceing: 4,
                      ).value,
                      left: ScaleManager.spaceScale(
                        spaceing: 25,
                      ).value),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: hintshade,
                      width: ScaleManager.spaceScale(
                        spaceing: 1,
                      ).value,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        ScaleManager.spaceScale(
                          spaceing: 42.5,
                        ).value,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: ScaleManager.spaceScale(spaceing: 70).value),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right:
                                  ScaleManager.spaceScale(spaceing: 30).value),
                          child: SizedBox(
                            height: description == ''
                                ? ScaleManager.spaceScale(spaceing: 65).value
                                : ScaleManager.spaceScale(spaceing: 33).value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: AutoSizeText(
                                    ///TODO Null Check refactorinig still needed
                                    title!.capitalize!,
                                    style: isFaded!
                                        ? AppTextStyle.Darkblueheader.copyWith(
                                            color: greyboxshade,
                                          )
                                        : AppTextStyle.Darkblueheader,
                                    textScaleFactor: textScaleFactor,
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        if (isFaded! || description == '')
                          EmptySpacePlaceHolder()
                        else
                          Padding(
                            padding: EdgeInsets.only(
                                top:
                                    ScaleManager.spaceScale(spaceing: 4).value),
                            child: Text(
                              description ?? '',
                              style: AppTextStyle.ligntbluedescription,
                              textAlign: TextAlign.start,
                              textScaleFactor: textScaleFactor,
                            ),
                          )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: CachedNetworkImage(
                      imageUrl: image!,
                      height: ScaleManager.spaceScale(spaceing: 91).value,
                      placeholder: (_, __) =>
                          const CircularShimmerLoader(height: 91, width: 91)
                      //scale: imageScaleFactor,
                      ),
                ),
              ],
            ),
            if (requireBottomSpacing)
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 40,
                ).value,
              )
            else
              EmptySpacePlaceHolder(),
          ],
        ),
      ),
    );
  }
}
