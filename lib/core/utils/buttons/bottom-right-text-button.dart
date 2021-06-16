// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../responsive/responsive-builder.dart';
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';
// ignore: must_be_immutable
class BottomRightTextButton extends StatelessWidget {
  String title;
  Callback onPressed;
  BottomRightTextButton({this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Responsive(
        mobile: _ResponsiveBottomBtn(
          title: title,
          textScaleFactor: textScaleFactor,
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 25,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 14,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 14,
            ).value,
          ),
        ),
        tablet: _ResponsiveBottomBtn(
          title: title,
          textScaleFactor: textScaleFactor,
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 26,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 13,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 10,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 10,
            ).value,
          ),
        ),
        desktop: _ResponsiveBottomBtn(
          title: title,
          textScaleFactor: textScaleFactor,
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 31,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 16,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 14,
            ).value,
          ),
        ),
      ),
    );
  }
}

class _ResponsiveBottomBtn extends StatelessWidget {
  const _ResponsiveBottomBtn(
      {Key key,
      @required this.title,
      @required this.textScaleFactor,
      @required this.padding})
      : super(key: key);

  final String title;
  final double textScaleFactor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            ScaleManager.spaceScale(
              spaceing: 25,
            ).value,
          ),
          bottomRight: Radius.circular(
            ScaleManager.spaceScale(
              spaceing: 25,
            ).value,
          ),
        ),
        color: blueDarkShade,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyle.buttonTextStyle,
            textScaleFactor: textScaleFactor,
          ),
          SizedBox(
            width: ScaleManager.spaceScale(spaceing: 14).value,
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: whiteshade,
            size: ScaleManager.spaceScale(
              spaceing: 19,
            ).value,
          ),
        ],
      ),
    );
  }
}
