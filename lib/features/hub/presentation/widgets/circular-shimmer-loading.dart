// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:shimmer/shimmer.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';

class CircularShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(230, 230, 230, 1),
      highlightColor: const Color.fromRGBO(242, 245, 245, 1),
      child: Container(
        width: ScaleManager.spaceScale(
          spaceing: 330,
        ).value,
        height: ScaleManager.spaceScale(
          spaceing: 330,
        ).value,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
