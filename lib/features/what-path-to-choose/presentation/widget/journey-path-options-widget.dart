import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import '../../../../core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/text-title-box.dart';
import '../controller/choose-path-controller.dart';

class WhatPathToChoose extends StatelessWidget {
  final _controller = Get.find<ChoosePathController>();
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: Get.width,
            child: Image.asset(
              ImagePath.backGroundImage,
              fit: BoxFit.cover,
              scale: imageScale,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            right: ScaleManager.spaceScale(
              spaceing: 16,
            ).value,
            left: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 64,
            ).value,
          ),
          child: Text(
            tr('select path'),
            textAlign: TextAlign.center,
            style: AppTextStyle.choosepath,
            textScaleFactor: textScale,
          ),
        ),
        Obx(
          () => _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _AvailablePathsWidget(
                  controller: _controller,
                ),
        ),
      ],
    );
  }
}

// Widget for showing available paths, {Differed coz. of better modularity}
class _AvailablePathsWidget extends StatelessWidget {
  const _AvailablePathsWidget({
    Key key,
    @required ChoosePathController controller,
  })  : _controller = controller,
        super(key: key);

  final ChoosePathController _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ScaleManager.spaceScale(
        spaceing: 197,
      ).value,
      left: Get.width * 0.09,
      child: Column(
        children: [
          for (var path in _controller.availableJournies)
            Container(
              margin: EdgeInsets.only(
                bottom: ScaleManager.spaceScale(
                  spaceing: 42,
                ).value,
              ),
              child: RadialBoxForPathSelection(
                title: path.title,
                imgUrl: "assets/choose-path-screen/${path.pathName}.png",
                subtitle: path.subtitle,
                onPressed: () {
                  _controller.selectJourney(journey: path);
                },
              ),
            )
        ],
      ),
    );
  }
}
