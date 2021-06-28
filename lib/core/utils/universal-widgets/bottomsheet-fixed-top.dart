import 'package:flutter/material.dart';
import '../../responsive/scale-manager.dart';

class BottomSheetFixedTop extends StatelessWidget {
  const BottomSheetFixedTop({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: ScaleManager.spaceScale(
          spaceing: 6,
        ).value,
        width: ScaleManager.spaceScale(
          spaceing: 100,
        ).value,
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(
            ScaleManager.spaceScale(
              spaceing: 32,
            ).value,
          ),
        ),
      ),
    );
  }
}
