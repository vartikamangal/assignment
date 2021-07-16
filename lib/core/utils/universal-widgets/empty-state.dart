import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../asset-image-path/image-path.dart';
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';

class EmptyState extends StatelessWidget {
  final String text;

  const EmptyState({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Column(
      children: [
        SvgPicture.asset(
          ImagePath.emptyStateEmoji,
          height: ScaleManager.spaceScale(
            spaceing: 130,
          ).value,
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 13,
          ).value,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          textScaleFactor: textScaleFactor,
          style: AppTextStyle.greyhint.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
