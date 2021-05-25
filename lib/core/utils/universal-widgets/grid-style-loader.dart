import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class GridLoaderScreen extends StatelessWidget {
  const GridLoaderScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.9,
      width: Get.width,
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: const Color.fromRGBO(230, 230, 230, 1),
            highlightColor: const Color.fromRGBO(242, 245, 245, 1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: ScaleManager.spaceScale(spaceing: 120.0).value,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(spaceing: 13).value,
                ),
                Container(
                  height: ScaleManager.spaceScale(spaceing: 14.0).value,
                  margin: EdgeInsets.symmetric(
                      horizontal: ScaleManager.spaceScale(spaceing: 35).value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        ScaleManager.spaceScale(spaceing: 2).value),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
