import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class CircularShimmerLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromRGBO(230, 230, 230, 1),
      highlightColor: const Color.fromRGBO(242, 245, 245, 1),
      child: Container(
        width: ScaleManager.spaceScale(
          spaceing: 360,
        ).value,
        height: ScaleManager.spaceScale(
          spaceing: 360,
        ).value,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
    );
  }
}
