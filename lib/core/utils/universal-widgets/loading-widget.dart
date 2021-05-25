import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: ScaleManager.spaceScale(
        spaceing: size.width * 0.7,
      ).value,
      child: Shimmer.fromColors(
        baseColor: const Color.fromRGBO(230, 230, 230, 1),
        highlightColor: const Color.fromRGBO(242, 245, 245, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: ScaleManager.spaceScale(
                spaceing: size.width * 0.7,
              ).value,
              height: ScaleManager.spaceScale(
                spaceing: 120,
              ).value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
            ),
            Container(
              width: ScaleManager.spaceScale(
                spaceing: size.width * 0.6,
              ).value,
              height: ScaleManager.spaceScale(
                spaceing: 60.0,
              ).value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
