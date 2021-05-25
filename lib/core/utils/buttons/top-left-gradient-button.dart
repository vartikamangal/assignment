import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:meta/meta.dart';
import '../color-pallete.dart';

class TopLeftGradientButton extends StatelessWidget {
  final Callback onPressed;
  const TopLeftGradientButton({
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding:
            const EdgeInsets.only(left: 27, top: 17, bottom: 17, right: 33),
        decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.only(bottomRight: Radius.circular(40)),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                blueDarkShade,
                blueLightShade,
              ],
            )),
        child: Image.asset("assets/intro-screen-a/images/call_button.png"),
      ),
    );
  }
}
