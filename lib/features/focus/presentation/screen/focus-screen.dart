import 'package:animator/animator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/add-button.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../../../../core/utils/universal-widgets/grid-style-loader.dart';
import '../controller/focus-screen-controller.dart';
import '../widgets/focus-card.dart';

// ignore: must_be_immutable
class FocusScreen extends StatelessWidget {
  final FocusController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    int removedIssueIndex;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: Obx(
                    () => IconButton(
                  icon: SvgPicture.asset(
                    ImagePath.backButton,
                    height: ScaleManager.spaceScale(
                      spaceing: 26,
                    ).value,
                  ),
                  onPressed: () {
                    _controller.topExpandedContainer.value == 0.0
                        ? Navigator.popAndPushNamed(context, RouteName.hubScreen)
                        : _controller.navigateBack();
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScaleManager.spaceScale(
                    spaceing: 30,
                  ).value,
                ),
                child: Text(
                  tr('focus title1'),
                  style: AppTextStyle.titleLM,
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Obx(
                      () => AnimatedSwitcher(
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 400) ,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                          return SizeTransition(
                              sizeFactor: animation, child: child);
                        },
                    child: _controller.topExpandedContainer.value == 0.0
                        ? EmptySpacePlaceHolder()
                    // comes into play when any issue is clicked
                        : Center(
                          child: _MiddleExpandableContainer(
                      imageUrl: _controller.selectedIssueImage,
                      title: _controller.selectedIssue.value.displayName,
                      onTap: () async {
                          await _controller.addIssue();
                      },
                      subtitle:
                      _controller.selectedIssue.value.messageOnSelection,
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      showLoader: _controller.isProcessing.value ? true : false,
                    ),
                        ),)
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(
                top: ScaleManager.spaceScale(spaceing: 1).value,
              ),
              sliver: SliverToBoxAdapter(
                child: Obx(
                      () => _controller.isLoading.value
                      ? const GridLoaderScreen()
                      : SizedBox(
                    // Here 110 is being considered as height of each grid bloc
                    height: ScaleManager.spaceScale(
                      spaceing: _controller.issues.length * ScaleManager.spaceScale(spaceing: 140).value,
                    ).value,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),//NeverScrollableScrollPhysics()
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: _controller.issues.length,
                      itemBuilder: (context, index) {
                        //TODO image addresses need to be changes later
                        final issueImageAddr =
                            '${ImagePath.issues}${'${_controller.issues[index].focusName.toLowerCase()}.png'}';
                        return FocusCard(
                          imageAddress: issueImageAddr,
                          title: _controller.issues[index].displayName,
                          onTap: () {
                            _controller.getDescription(
                              issueImageAddr,
                              _controller.issues[index],
                            );
                            _controller.removeIssue( _controller.issues[index],);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiddleExpandableContainer extends StatelessWidget {
  const _MiddleExpandableContainer({
    Key key,
    @required this.imageUrl,
    @required this.onTap,
    @required this.subtitle,
    @required this.title,
    @required this.showLoader,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final String subtitle;
  final Callback onTap;
  final bool showLoader;

  @override
  Widget build(BuildContext context) {

    final textScaleFactor = ScaleManager.textScale.value;
    return  Animator<double>(
      curve: Curves.easeInOut,
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      resetAnimationOnRebuild: true,
      builder: (context, animatorState, child) => Opacity(
        opacity: animatorState.value,
        child: Padding(
          padding: EdgeInsets.only(
            top: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageUrl == '')
                Container()
              else
                Hero(
                  tag: imageUrl,
                  child: Image.asset(
                    imageUrl,
                    width: ScaleManager.spaceScale(
                      spaceing: 152,
                    ).value,
                    fit: BoxFit.fill,
                  ),
                ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 18,
                ).value,
              ),
              Text(
                title,
                style: AppTextStyle.lightblueheader,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: ScaleManager.spaceScale(
                    spaceing: 18,
                  ).value,
                ),
                width: ScaleManager.spaceScale(
                  spaceing: Get.width * 0.70,
                ).value,
                child: Text(
                  subtitle,
                  style: AppTextStyle.descriptiontext,
                  textAlign: TextAlign.center,
                  textScaleFactor: textScaleFactor,
                ),
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 24,
                ).value,
              ),
              if (showLoader)
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value,
                    maxWidth: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value,
                  ),
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              else
                MiddleAddButton(
                  title: ' ADD ',
                  onPressed: onTap,
                ),
            ],
          ),
        ),
      ),
    );
  }
}