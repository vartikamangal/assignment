import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class RecommendationLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaleManager.spaceScale(
        spaceing: 31,
      ).value,
      child: Shimmer.fromColors(
        baseColor: const Color.fromRGBO(230, 230, 230, 1),
        highlightColor: const Color.fromRGBO(242, 245, 245, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: ScaleManager.spaceScale(
                  spaceing: 14,
                ).value,
              width:  ScaleManager.spaceScale(
                spaceing: 269,
              ).value,
              color: Colors.grey,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 8,
              ).value,
            ),
            Container(
              height: ScaleManager.spaceScale(
                spaceing: 14,
              ).value,
              width:  ScaleManager.spaceScale(
                spaceing: 209,
              ).value,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
