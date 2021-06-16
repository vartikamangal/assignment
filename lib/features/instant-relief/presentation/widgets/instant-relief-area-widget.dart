// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';

class ReliefAreaCard extends StatelessWidget {
  const ReliefAreaCard({
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
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth:ScaleManager.spaceScale(
                  spaceing: 120,
                ).value,
              ),
              child: Text(
                title,
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
