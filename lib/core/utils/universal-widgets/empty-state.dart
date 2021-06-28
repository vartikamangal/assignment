import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../asset-image-path/image-path.dart';
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Container(

      child: Column(
          children: [
            SvgPicture.asset(ImagePath.emptyStateEmoji,
            height: ScaleManager.spaceScale(
              spaceing: 130,
            ).value,),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 13,
              ).value,
            ),
            Text(tr('empty state text'),
            textAlign: TextAlign.center,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.greyhint.copyWith(fontWeight: FontWeight.w600,fontSize: 20,),)
          ],
      ),
    );
  }
}
