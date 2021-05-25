import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class FocusCard extends StatelessWidget {
  const FocusCard({
    Key key,
    @required this.imageAddress,
    @required this.title,
    @required this.onTap,
  }) : super(key: key);

  final String imageAddress;
  final String title;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Container(
      child: Column(
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
              child: Image.asset(
                imageAddress,
                height: 100,
                scale: imageScaleFactor,
              ),
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Text(
            title,
            style: AppTextStyle.greysmall,
            textScaleFactor: textScaleFactor,
          ),
        ],
      ),
    );
  }
}
