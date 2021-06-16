// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/utils/animations/fade-animation-y-axis.dart.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';

class SignUpScreenC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeAnimationYAxis(
          0.2,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 32, right: 120, top: 45),
              child: Text(
                tr('set profile'),
                style: AppTextStyle.titleL,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 32, right: 55, top: Get.height * 0.22),
          child: Column(
            children: [
              FadeAnimationYAxis(
                0.3,
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyLightShade)),
                      labelText: tr('name'),
                      labelStyle: AppTextStyle.hintStyle),
                  style: AppTextStyle.titlel,
                  onChanged: (String value) {
                    print(value);
                  },
                ),
              ),
              FadeAnimationYAxis(
                0.4,
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyLightShade)),
                      labelText: tr('email'),
                      labelStyle: AppTextStyle.hintStyle),
                  style: AppTextStyle.titlel,
                  onChanged: (String value) {
                    print(value);
                  },
                ),
              ),
              FadeAnimationYAxis(
                0.5,
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyLightShade)),
                      labelText: tr('password'),
                      labelStyle: AppTextStyle.hintStyle),
                  style: AppTextStyle.titlel,
                  onChanged: (String value) {
                    print(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
