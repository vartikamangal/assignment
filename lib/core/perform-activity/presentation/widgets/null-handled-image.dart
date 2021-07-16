import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class NullHandledImage extends StatelessWidget {
  String? image;
  NullHandledImage({required this.image});
  // ignore: empty_constructor_bodies
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: image!,
      child: CachedNetworkImage(
        imageUrl: image!,
        height: ScaleManager.spaceScale(
          spaceing: 140,
        ).value,
        width: ScaleManager.spaceScale(
          spaceing: 138,
        ).value,
        // scale: imageScaleFactor,
      ),
    );
  }
}
