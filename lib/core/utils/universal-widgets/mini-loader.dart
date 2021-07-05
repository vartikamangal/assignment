import 'package:flutter/material.dart';
import '../../responsive/scale-manager.dart';

class MiniLoader extends StatelessWidget {
  const MiniLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaleManager.spaceScale(
        spaceing: 20,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 20,
      ).value,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.white,
        ),
        strokeWidth: 2,
      ),
    );
  }
}
