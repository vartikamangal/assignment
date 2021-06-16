// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/add-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../../../../core/utils/universal-widgets/grid-style-loader.dart';
import '../controller/focus-screen-controller.dart';
import '../widgets/focus-card.dart';

// ignore: must_be_immutable
class IssueDetail extends StatelessWidget {
  final FocusController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: Obx(
                () => IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: blueDarkShade,
                    size: ScaleManager.spaceScale(
                      spaceing: 26,
                    ).value,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    /*_controller.topExpandedContainer.value == 0.0
                        ? Navigator.popAndPushNamed(context, RouteName.hubScreen)
                        : _controller.navigateBack();*/
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
                () => _controller.topExpandedContainer.value == 0.0
                    ? EmptySpacePlaceHolder()
                    // comes into play when any issue is clicked
                    : _MiddleExpandableContainer(
                        imageUrl: _controller.selectedIssueImage,
                        title: _controller.selectedIssue.value.displayName,
                        onTap: () async {
                          await _controller.addIssue();
                        },
                        subtitle:
                            _controller.selectedIssue.value.messageOnSelection,
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        showLoader:
                            _controller.isProcessing.value ? true : false,
                      ),
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
                          // Here 120 is being considered as height of each grid bloc
                          height: ScaleManager.spaceScale(
                            spaceing: _controller.issues.length *
                                ScaleManager.spaceScale(spaceing: 120).value,
                          ).value,
                          child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
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
    return Padding(
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
            style: AppTextStyle.lightblueheader.copyWith(color: blueLightShade),
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
    );
  }
}
