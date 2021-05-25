import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/validation/name-validation.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';

import '../../../../core/utils/animations/fade-animation-x-axis.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class MidPageContentA extends StatelessWidget {
  final RapportBuildingController controller;
  final TextEditingController textEditingController = TextEditingController();
  MidPageContentA({
    Key key,
    @required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 30,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 1,
            ).value,
          ),
          width: Get.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Get.height * 0.23,
              ),
              FadeAnimationXAxis(
                0.4,
                SizedBox(
                  width: Get.width * 0.75,
                  child: Text(
                    tr('ask name title'),
                    textScaleFactor: textScaleFactor,
                    style: AppTextStyle.titleL,
                  ),
                ),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 20,
                ).value,
              ),
              FadeAnimationXAxis(
                0.5,
                Obx(
                  () => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.85,
                    ),
                    child: Responsive(
                      mobile: _TextFormFieldComponent(
                        controller: controller,
                        fontSize: 18,
                        paddingFactor: EdgeInsets.only(
                          left: ScaleManager.spaceScale(
                            spaceing: 3,
                          ).value,
                          bottom: ScaleManager.spaceScale(
                            spaceing: -12,
                          ).value,
                        ),
                      ),
                      tablet: _TextFormFieldComponent(
                        controller: controller,
                        fontSize: 35,
                        paddingFactor: EdgeInsets.only(
                          left: ScaleManager.spaceScale(
                            spaceing: 6,
                          ).value,
                          bottom: ScaleManager.spaceScale(
                            spaceing: -1,
                          ).value,
                        ),
                      ),
                      desktop: _TextFormFieldComponent(
                        controller: controller,
                        fontSize: 18,
                        paddingFactor: EdgeInsets.only(
                          left: ScaleManager.spaceScale(
                            spaceing: 3,
                          ).value,
                          bottom: ScaleManager.spaceScale(
                            spaceing: -12,
                          ).value,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

///// Responsive Assistors ///////
class _TextFormFieldComponent extends StatelessWidget {
  const _TextFormFieldComponent({
    Key key,
    @required this.controller,
    @required this.fontSize,
    @required this.paddingFactor,
  }) : super(key: key);

  final RapportBuildingController controller;
  final double fontSize;
  final EdgeInsets paddingFactor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: controller.focusNode,
      autovalidateMode: AutovalidateMode.always,
      style: AppTextStyle.hintStyleDarkerForTextInputs.copyWith(
        //entered text style
        color: Colors.black,
        fontSize: fontSize,
      ),
      controller: controller.textEditingController,
      decoration: InputDecoration(
        contentPadding: paddingFactor,
        hintText: tr('ask name field'),
        errorStyle: AppTextStyle.hintStyle.copyWith(
          fontSize: fontSize,
          color: Colors.redAccent,
        ),
        hintStyle: AppTextStyle.hintStyle.copyWith(
          fontSize: fontSize,
        ),
      ),
      onChanged: (name) => controller.nickName = name,
      validator: (name) => nameValidation(
        value: name,
      ),
    );
  }
}
