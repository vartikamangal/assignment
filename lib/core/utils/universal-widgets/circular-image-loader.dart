import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircularImageLoader extends StatelessWidget {
  final double? height;
 const  CircularImageLoader({ required this.height});
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromRGBO(230, 230, 230, 1),
    highlightColor: const Color.fromRGBO(242, 245, 245, 1),
    child:Container(
      height: height,
      decoration: const BoxDecoration(shape: BoxShape.circle,color: Colors.grey),
    ));
  }
}
