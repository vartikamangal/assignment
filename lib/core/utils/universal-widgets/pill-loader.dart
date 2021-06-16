// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class PillLoaderComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScaleManager.spaceScale(
        spaceing: 85,
      ).value,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          ScaleManager.spaceScale(
            spaceing: 43,
          ).value,
        ),
      ),
    );
  }
}
