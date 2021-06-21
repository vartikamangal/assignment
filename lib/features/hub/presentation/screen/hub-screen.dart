// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';

// Project imports:
import '../../../../core/responsive/responsive-builder.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-right-text-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../controller/hub-controller.dart';
import '../widgets/circular-shimmer-loading.dart';

class HubScreen extends StatelessWidget {
  final HubController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final imageScale = ScaleManager.imageScale.value;
    final textScale = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // ignore: unrelated_type_equality_checks
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: Obx(
            () => _controller.userHubStatus.value ==
                    HubAnswerStatus.nothingAnswered
                ? IconButton(
                   padding:EdgeInsets.only(left: ScaleManager.spaceScale(
                     spaceing: 10,
                   ).value,
                   top: ScaleManager.spaceScale(
                     spaceing: 10,
                   ).value,
                   bottom: 0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(
                      ImagePath.backButton,
                      height: ScaleManager.spaceScale(
                        spaceing: 26,
                      ).value,
                    ),
                  )
                : EmptySpacePlaceHolder(),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Responsive(
                  mobile: SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 90,
                    ).value,
                  ),
                  tablet: SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 50,
                    ).value,
                  ),
                  desktop: SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 80,
                    ).value,
                  ),
                ),
                Container(
                  height: Get.height*0.42,
                  child: Obx(
                    () => GestureDetector(
                      onTap: _controller.isLoading.value
                          // Do nothing untill some process is going on
                          ? () {}
                          : _controller.activeHubStateObject.value.onImageTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Responsive(
                            mobile: _MidImageMobileComponent(
                              controller: _controller,
                              imageScale: imageScale,
                            ),
                            tablet: _MidImageTabletContent(
                              controller: _controller,
                              imageScale: imageScale,
                            ),
                            desktop: _MidImageDesktopComponent(
                              controller: _controller,
                              imageScale: imageScale,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => _controller.userHubStatus.value ==
                          HubAnswerStatus.allAnswered
                      ? EmptySpacePlaceHolder()
                      : SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 12,
                          ).value,
                        ),
                ),
                Obx(
                  () => Text(
                    _controller.isLoading.value
                        ? 'Please hold on'
                        : _controller.activeHubStateObject.value.title,
                    style: AppTextStyle.lightbold,
                    textScaleFactor: textScale,
                  ),
                ),
                Obx(
                  () => Text(
                    _controller.userHubStatus.value ==
                            HubAnswerStatus.allAnswered
                        ? ''
                        : tr('tap on area'),
                    style: AppTextStyle.greyTapText,
                    textScaleFactor: textScale,
                  ),
                ),
                Obx(
                  () => _controller.userHubStatus.value ==
                          HubAnswerStatus.allAnswered
                      ? EmptySpacePlaceHolder()
                      : Container(
                          width: ScaleManager.spaceScale(
                            spaceing: Get.width * 0.75,
                          ).value,
                          margin: EdgeInsets.only(
                            top: ScaleManager.spaceScale(
                              spaceing: 3,
                            ).value,
                          ),
                          height: 1,
                          color: greyline,
                        ),
                ),
                Obx(
                  () => _controller.userHubStatus.value ==
                          HubAnswerStatus.allAnswered
                      ? EmptySpacePlaceHolder()
                      : SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 20,
                          ).value,
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 25,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 26,
                      ).value),
                  child: Obx(
                    () => Responsive(
                      mobile: Text(
                        _controller.isLoading.value
                            ? 'Loading description'
                            : _controller.activeHubStateObject.value.subtitle,
                        style: AppTextStyle.darkerBlueMedium,
                        textScaleFactor: textScale,
                      ),
                      tablet: Text(
                        _controller.isLoading.value
                            ? 'Loading description'
                            : _controller.activeHubStateObject.value.subtitle,
                        style: AppTextStyle.darkerBlueMedium,
                        textScaleFactor: textScale * 0.95,
                      ),
                      desktop: Text(
                        _controller.isLoading.value
                            ? 'Loading description'
                            : _controller.activeHubStateObject.value.subtitle,
                        style: AppTextStyle.darkerBlueMedium,
                        textScaleFactor: textScale * 0.95,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(
              () => _controller.isProcessing.value
                  ? const LinearProgressIndicator()
                  : EmptySpacePlaceHolder(),
            ),
            Positioned(
              bottom: ScaleManager.spaceScale(
                spaceing: 70,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 30,
              ).value,
              child: Obx(
                () => _controller.userHubStatus.value ==
                        HubAnswerStatus.targetAnswered
                    ? Text(
                        tr('now i am done'),
                        textScaleFactor: textScale,
                        style: AppTextStyle.greyTapText,
                      )
                    : Container(),
              ),
            ),
            Positioned(
              right: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
              bottom: ScaleManager.spaceScale(
                spaceing: 13,
              ).value,
              child: Obx(
                () => _controller.userHubStatus.value ==
                            HubAnswerStatus.allAnswered ||
                        _controller.userHubStatus.value ==
                            HubAnswerStatus.targetAnswered
                    ? _controller.isLoggingIn.value
                        ? Center(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: ScaleManager.spaceScale(
                                    spaceing: 65,
                                  ).value,
                                ),
                                child: SizedBox(
                                  height: ScaleManager.spaceScale(
                                    spaceing: 26,
                                  ).value,
                                  width: ScaleManager.spaceScale(
                                    spaceing: 26,
                                  ).value,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : BottomRightTextButton(
                            title: tr('pick a path'),
                            onPressed: () async =>
                                _controller.checkForLoginAndProceed(),
                          )
                    : EmptySpacePlaceHolder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////// Responsive Assistors /////////

class _MidImageDesktopComponent extends StatelessWidget {
  const _MidImageDesktopComponent({
    Key key,
    @required HubController controller,
    @required this.imageScale,
  })  : _controller = controller,
        super(key: key);

  final HubController _controller;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaleManager.spaceScale(
        spaceing: 360,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 360,
      ).value,
      child: _controller.isLoading.value
          ? CircularShimmerLoader()
          : Image.asset(
              _controller.activeHubStateObject.value.heroImageUrl,
              scale: imageScale,
            ),
    );
  }
}

class _MidImageMobileComponent extends StatelessWidget {
  const _MidImageMobileComponent({
    Key key,
    @required HubController controller,
    @required this.imageScale,
  })  : _controller = controller,
        super(key: key);

  final HubController _controller;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaleManager.spaceScale(
        spaceing: 330,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 330,
      ).value,
      child: _controller.isLoading.value
          ? CircularShimmerLoader()
          : Image.asset(
              _controller.activeHubStateObject.value.heroImageUrl,
              scale: imageScale,
            ),
    );
  }
}

class _MidImageTabletContent extends StatelessWidget {
  const _MidImageTabletContent({
    Key key,
    @required HubController controller,
    @required this.imageScale,
  })  : _controller = controller,
        super(key: key);

  final HubController _controller;
  final double imageScale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScaleManager.spaceScale(
        spaceing: 300,
      ).value,
      width: ScaleManager.spaceScale(
        spaceing: 300,
      ).value,
      child: _controller.isLoading.value
          ? CircularShimmerLoader()
          : Image.asset(
              _controller.activeHubStateObject.value.heroImageUrl,
              scale: imageScale,
            ),
    );
  }
}
