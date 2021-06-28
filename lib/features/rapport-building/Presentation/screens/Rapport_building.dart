// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/responsive-builder.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/routes/app-routes/app-routes.dart';
import 'package:tatsam_app_experimental/core/utils/animations/enter-exit-root-animation.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-left-gradient-button.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottom-right-text-button.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/bottomRightButton.dart';
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
                            ?  BottomRightButton(
                                    title: '',
                                    onPressed: () {
                                      _onBoardingController.switchButtonStatus
                                                      .value ==
                                                  true &&
                                              _onBoardingController
                                                  .userName.value.isNotEmpty && !_onBoardingController.isProcessing.value
                                          ? _onBoardingController
                                              .changeNickNameAndMoveOnwards()
                                          : Container();
                                    })
                            : const InactiveBottomRightButton(
                                title: '',
                              ))
                        : _onBoardingController
                                    .currentOnBoardPageCounter.value ==
                                _onBoardingController.maxIntroPages
                            ?
                        _onBoardingController
                        .isProcessing.value ? BottomRightButton(title: '',):BottomRightTextButton(
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
                            )
                            : _onBoardingController
                                        .currentOnBoardPageCounter.value ==
                                    1
                                ? Container()
                                : _onBoardingController
                                            .selectedFeelingDuration
                                            .value !=
                                        null
                                    ?  BottomRightButton(
                                            title: '',
                                            onPressed: () =>
                                                _onBoardingController
                                                            .selectedFeelingDuration
                                                            .value ==
                                                        null && _onBoardingController
                                                    .isProcessing.value
                                                    ? Container()
                                                    : _onBoardingController
                                                        .changeScreen(),
                                          )
                                    : const InactiveBottomRightButton(
                                        title: '',
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
                    spaceing: 3,
                  ).value,
                  top: ScaleManager.spaceScale(
                    spaceing: 9,
                  ).value,
                  child: Obx(
                    () =>
                        _onBoardingController.currentOnBoardPageCounter.value ==
                                0
                            ? EmptySpacePlaceHolder()
                            : IconButton(
                              padding:EdgeInsets.only(
                                  left: ScaleManager.spaceScale(
                                spaceing: 8,
                                  ).value,
                              top:ScaleManager.spaceScale(
                                spaceing: 8,
                              ).value,
                              bottom: ScaleManager.spaceScale(
                                spaceing: 0,
                              ).value),
                                onPressed: () {
                                  _onBoardingController.navigateBack();
                                },
                              iconSize: ScaleManager.spaceScale(
                                spaceing: 26,
                              ).value,
                                icon: SvgPicture.asset(
                                  ImagePath.backButton,
                                ),
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
