// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/animations/enter-exit-root-animation.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-x-axis.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-left-gradient-button.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-right-text-button.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/loading-widget.dart';
import 'package:tatsam_app_experimental/features/hub/presentation/screen/hub-screen.dart';
import 'package:tatsam_app_experimental/features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/inactive-bottom-right-button.dart';

class RapportScreen extends StatelessWidget {
  final RapportBuildingController _onBoardingController = Get.find();
  @override
  Widget build(BuildContext context) {
    final scale = ScaleManager.imageScale.value;
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
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
                    onPressed: () => Navigator.of(context).pushNamed(
                      RouteName.instantRelief,
                    ),
                  ),
                ),
                Positioned(
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
                        ? (_onBoardingController.userName.value.isNotEmpty
                            ? (_onBoardingController.isProcessing.value
                                ? CircularProgressIndicator()
                                : BottomRightButton(
                                    title: '',
                                    onPressed: () {
                                      _onBoardingController.switchButtonStatus
                                                      .value ==
                                                  true &&
                                              _onBoardingController
                                                  .userName.value.isNotEmpty
                                          ? _onBoardingController
                                              .changeNickNameAndMoveOnwards()
                                          : Container();
                                    }))
                            : const InactiveBottomRightButton(
                                title: '',
                              ))
                        : AnimatedSwitcher(
                            switchInCurve: Curves.easeIn,
                            duration: const Duration(
                              milliseconds: 300,
                            ),
                            child: _onBoardingController
                                        .currentOnBoardPageCounter.value ==
                                    _onBoardingController.maxIntroPages
                                ? FadeAnimationXAxis(
                                    0.2,
                                    BottomRightTextButton(
                                      title: tr('done'),
                                      onPressed: () async {
                                        await _onBoardingController
                                            .persistSubjectFeeing(
                                              feeling: _onBoardingController
                                                  .feeling.value,
                                            )
                                            .then(
                                              (value) => Navigator.push(
                                                  context,
                                                  EnterExitRoute(
                                                      exitPage: this,
                                                      enterPage: HubScreen())),
                                            );
                                      },
                                    ),
                                  )
                                : _onBoardingController
                                            .currentOnBoardPageCounter.value ==
                                        1
                                    ? Container()
                                    : _onBoardingController
                                                .selectedFeelingDuration
                                                .value !=
                                            null
                                        ? (_onBoardingController
                                                .isProcessing.value
                                            ? CircularProgressIndicator()
                                            : BottomRightButton(
                                                title: '',
                                                onPressed: () =>
                                                    _onBoardingController
                                                                .selectedFeelingDuration
                                                                .value ==
                                                            null
                                                        ? Container()
                                                        : _onBoardingController
                                                            .changeScreen(),
                                              ))
                                        : const InactiveBottomRightButton(
                                            title: '',
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
          top: MediaQuery.of(context).size.height * 0.25,
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
          top: MediaQuery.of(context).size.height * 0.25,
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
          top: MediaQuery.of(context).size.height * 0.25,
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

class BottomRightButton extends StatelessWidget {
  final String title;
  final Callback onPressed;
  const BottomRightButton({
    this.onPressed,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: ScaleManager.spaceScale(
          spaceing: 56,
        ).value,
        width: ScaleManager.spaceScale(
          spaceing: 97,
        ).value,
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 56,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 17,
            ).value,
            top: ScaleManager.spaceScale(
              spaceing: 18,
            ).value,
            bottom: ScaleManager.spaceScale(
              spaceing: 17,
            ).value),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
            bottomRight: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 25,
              ).value,
            ),
          ),
          color: blueDarkShade,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: AppTextStyle.buttonTextStyle,
              textScaleFactor: textScaleFactor,
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: whiteshade,
              size: ScaleManager.spaceScale(
                spaceing: 24,
              ).value,
            ),
          ],
        ),
      ),
    );
  }
}
