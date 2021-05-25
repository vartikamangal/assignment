import 'package:flutter/material.dart';
import '../../../../core/utils/animations/fade-animation-y-axis.dart.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class SignUpScreenB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FadeAnimationYAxis(
          0.2,
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(left: 32, right: 90, top: 45),
              child: Text(
                tr('otp on phone'),
                style: AppTextStyle.titleL,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 32, right: 55, top: Get.height * 0.22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeAnimationYAxis(
                0.3,
                TextFormField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: greyLightShade)),
                      labelText: tr('enter otp'),
                      labelStyle: AppTextStyle.hintStyle),
                  style: AppTextStyle.titlel,
                  onChanged: (String value) {
                    print(value);
                  },
                ),
              ),
              SizedBox(
                height: 45,
              ),
              FadeAnimationYAxis(
                0.4,
                GestureDetector(
                  onTap: () {
                    //todo
                  },
                  child: Text(tr('resend'), style: AppTextStyle.underlinedhint),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
