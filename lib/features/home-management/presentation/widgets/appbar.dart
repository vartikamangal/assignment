import 'package:flutter/material.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/buttons/bottom-left-gradient-button.dart';

class HomScreenAppBar extends StatelessWidget {
  const HomScreenAppBar({
    Key? key,
    required this.imageScaleFactor,
  }) : super(key: key);

  final double imageScaleFactor;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(
          ScaleManager.spaceScale(
            spaceing: 10,
          ).value,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.profileScreen);
              },
              child: Image.asset(
                ImagePath.cornerImage,
                height: ScaleManager.spaceScale(
                  spaceing: 43,
                ).value,
                width: ScaleManager.spaceScale(
                  spaceing: 43,
                ).value,
                scale: imageScaleFactor,
              ),
            ),
            BottomLeftGradientButton(
              onPressed: () => Navigator.pushNamed(
                context,
                RouteName.instantRelief,
              ),
            )
          ],
        ),
      ),
    );
  }
}
