import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-x-axis.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-left-gradient-button.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-right-text-button.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/loading-widget.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../../../../core/utils/buttons/bottomRightButton.dart';

class RapportScreen extends StatelessWidget {
  final RapportBuildingController _onBoardingController = Get.find();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(
      [
        SystemUiOverlay.bottom,
      ],
    );
    final scale = ScaleManager.imageScale.value;
    final size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          _onBoardingController.focusNode.unfocus();
        },
        child: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: Image.asset(
                    ImagePath.topRightLeaf,
                    width: size.width,
                    // fit: BoxFit.fitWidth,
                    scale: scale,
                  ),
                ),
                // Top Left Call button
                Positioned(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value,
                  left: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value,
                  child: BottomLeftGradientButton(
                    // ignore: avoid_print
                    onPressed: () => Navigator.of(context).pushNamed(RouteName.instantRelief),
                  ),
                ),
                Positioned(
                  top: size.height * 0.06,
                  child: Obx(
                        () => _onBoardingController.isLoadComplete.value
                        ? _onBoardingController.currentSelectedPage.value
                        : const _LoadingWidget(),
                  ),
                ),
                Positioned(
                  right: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value,
                  bottom: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value,
                  child: Obx(
                        () => _onBoardingController
                        .currentOnBoardPageCounter.value ==
                        0
                        ? BottomRightButton(
                      title: '',
                      onPressed: () =>
                      // ignore: prefer_is_empty
                      _onBoardingController.userName.value.length > 0
                          ? _onBoardingController
                          .changeNickNameAndMoveOnwards()
                          : Container(),
                    )
                        : AnimatedSwitcher(
                      switchInCurve: Curves.easeIn,
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      child: _onBoardingController
                          .currentOnBoardPageCounter.value ==
                          _onBoardingController.maxIntroPages
                          ? FadeAnimationXAxis(
                        0.2,BottomRightTextButton(
                          title: tr('done'),
                          onPressed: () async {
                            await _onBoardingController
                                .persistSubjectFeeing(
                              feeling:
                              _onBoardingController.feeling.value,
                            );
                            Navigator.of(context).pushNamed(
                              RouteName.hubScreen,
                            );
                          }),
                      )
                          : _onBoardingController
                          .currentOnBoardPageCounter.value ==
                          1
                          ? Container()
                          : BottomRightButton(
                        title: '',
                        onPressed: () => _onBoardingController
                            .selectedFeelingDuration
                            .value ==
                            null
                            ? Container()
                            : _onBoardingController
                            .changeScreen(),
                      ),
                    ),
                  ),
                ),
                Obx(
                      () => _onBoardingController.isProcessing.value
                      ? const LinearProgressIndicator()
                      : Container(),
                ),
                Positioned(
                  left: ScaleManager.spaceScale(
                    spaceing: 17,
                  ).value,
                  top: ScaleManager.spaceScale(
                    spaceing: 17,
                  ).value,
                  child: Obx(
                        () =>
                    _onBoardingController.currentOnBoardPageCounter.value ==
                        0
                        ? EmptySpacePlaceHolder()
                        : IconButton(
                      onPressed: () {
                        _onBoardingController.navigateBack();
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                      color: blueDarkShade,
                      iconSize: ScaleManager.spaceScale(
                        spaceing: 26,
                      ).value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.20,
          left: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
        ),
        child: Loader(),
      ),
      tablet: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.20,
          left: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 90,
          ).value,
        ),
        child: Loader(),
      ),
      desktop: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.20,
          left: ScaleManager.spaceScale(
            spaceing: 30,
          ).value,
          right: ScaleManager.spaceScale(
            spaceing: 90,
          ).value,
        ),
        child: Loader(),
      ),
    );
  }
}