// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_fonts/google_fonts.dart';

// Project imports:
import '../responsive/scale-manager.dart';
import 'color-pallete.dart';

class RoundButton extends StatelessWidget {
  final String? title;
  final Icon? iconData;
  final Function()? onPressed;
  final Color? color;
  const RoundButton({
    Key? key,
    this.title,
    this.iconData,
    this.onPressed,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        padding: EdgeInsets.only(
          left: ScaleManager.spaceScale(
            spaceing: 32,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 32,
          ).value,
          top: ScaleManager.spaceScale(
            spaceing: 15,
          ).value,
          bottom: ScaleManager.spaceScale(
            spaceing: 15,
          ).value,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Text(
          title!,
          style: GoogleFonts.zillaSlab(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: aquashade,
          ),
          textScaleFactor: textScaleFactor,
        ),
      ),
    );
  }
}
