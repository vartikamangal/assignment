// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../responsive/scale-manager.dart';
import '../app-text-style-components/app-text-styles.dart';
import '../color-pallete.dart';

// ignore: camel_case_types
class bottomCurvedButton extends StatelessWidget {
  final String title;
  final Icon iconData;
  final Function() onPressed;
  const bottomCurvedButton({
    Key key,
    this.title,
    this.iconData,
    this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(spaceing: 44).value,
            right: ScaleManager.spaceScale(spaceing: 19).value,
            top: ScaleManager.spaceScale(spaceing: 15).value,
            bottom: ScaleManager.spaceScale(spaceing: 15).value),
        decoration: BoxDecoration(
          color: blueDarkShade,
          borderRadius: BorderRadius.only(
              topLeft:
                  Radius.circular(ScaleManager.spaceScale(spaceing: 44).value)),
        ),
        child: Text(
          title,
          style: AppTextStyle.buttonTextStyle,
          textScaleFactor: textScaleFactor,
        ),
      ),
    );
  }
}
