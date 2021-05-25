import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/empty-space.dart';
import 'package:tatsam_app_experimental/features/focus/presentation/widgets/focus-card.dart';

import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/middle-call-us-button.dart';
import '../../../../core/utils/buttons/toprightcallbutton.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controllers/instant-relief-controller.dart';

class InstantReliefScreen extends StatelessWidget {
  final _controller = Get.find<InstantReliefController>();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: blueDarkShade,
            size: ScaleManager.spaceScale(
              spaceing: 26,
            ).value,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                left: ScaleManager.spaceScale(
                  spaceing: 21,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 21,
                ).value,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                  ),
                  Text(
                    tr('instant relief'),
                    style: AppTextStyle.boldText,
                    textAlign: TextAlign.center,
                    textScaleFactor: textScaleFactor.value,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 12,
                    ).value,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 65,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 226,
                    ).value,
                    child: TopRightCallbutton(
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 19,
                    ).value,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 23,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 22,
                      ).value,
                    ),
                    height: 1,
                    width: Get.width,
                    color: greyline,
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 30,
                    ).value,
                  ),
                  Text(
                    tr('instant relief description'),
                    style: AppTextStyle.greyText,
                    textAlign: TextAlign.center,
                    textScaleFactor: textScaleFactor.value,
                  ),
                  MiddleCallUsButton(
                    title: 'Call us',
                    onPressed: () {},
                  ),
                  SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 30,
                    ).value,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 23,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 22,
                      ).value,
                    ),
                    height: 1,
                    width: Get.width,
                    color: greyline,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => _controller.isProcessing.value
                  ? EmptySpacePlaceHolder()
                  : SizedBox(
                // Here 110 is being considered as height of each grid bloc
                height: ScaleManager.spaceScale(
                  spaceing: _controller.instantLifeAreas.length * 110.0,
                ).value,
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _controller.instantLifeAreas.length,
                  itemBuilder: (context, index) {
                    //TODO image addresses need to be changes later
                    final issueImageAddr =
                        '${ImagePath.issues}${'${_controller.instantLifeAreas[index].title.toLowerCase()}.png'}';
                    return FocusCard(
                      imageAddress: issueImageAddr,
                      title: _controller.instantLifeAreas[index].title,
                      onTap: () {

                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
  List<Widget> _buildInstantReliefAreas() {
    final List<Widget> _areas = [];
    int areaFillCount = 0;
    while (areaFillCount < _controller.instantLifeAreas.length) {
      final area = _controller.instantLifeAreas[areaFillCount];
      _areas.add(
        Padding(
          padding: EdgeInsets.only(
            bottom: ScaleManager.spaceScale(
              spaceing: 46,
            ).value,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FocusCard(
                imageAddress: '${ImagePath.selfDrivenOption}physical.png',
                title: area.title,
                onTap: () {},
              ),
            ],
          ),
        ),
      );
      areaFillCount++;
    }
    return _areas;
  }*/
