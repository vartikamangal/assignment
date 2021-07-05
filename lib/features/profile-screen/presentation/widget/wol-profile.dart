import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controller/profile-controller.dart';
import 'bottom-sheet.dart';
import 'wol-pie-chart.dart';

class WheelOfLifeProfile extends GetWidget<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(
              spaceing: 32,
            ).value,
            right: ScaleManager.spaceScale(
              spaceing: 29,
            ).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr('my wheel of life'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 5,
              ).value,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 240,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 240,
                  ).value,
                  child: PiChart(
                    chartData: controller.pieChartData,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 5,
              ).value,
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              children: [
                for (final area in controller
                    .hubStatus.value!.lifePriorities!.areasInOrderOfPriority)
                  WheelOfLifeArea(
                    onPressed: (){
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (context) =>  InfoBottomSheet(
                          selectedArea: area,
                          description:
                          'Your best self can only happen when you have access to  growth in different areas o',
                        ),
                      );
                    },
                    wolAreaImage: 'assets/profile-icon/user-image.png',
                    title: area,
                    profileController: controller,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class WheelOfLifeArea extends StatelessWidget {
  final String wolAreaImage;
  final String title;
  final Callback onPressed;
  final ProfileController profileController;
  const WheelOfLifeArea({
    required this.wolAreaImage,
    required this.title,
    required this.onPressed,
    required this.profileController,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return GestureDetector(
      onTap: onPressed,
      /*() {
        profileController.addWolLifeToPieChart(
          lifeArea: title,
        );
      },*/
      child: Column(
        children: [
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 52,
            ).value,
            width: ScaleManager.spaceScale(
              spaceing: 52,
            ).value,
            child: Image.asset(
              wolAreaImage,
              scale: imageScaleFactor,
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 8,
            ).value,
          ),
          Container(
            constraints: BoxConstraints(
                minHeight: ScaleManager.spaceScale(
              spaceing: 17,
            ).value),
            width: ScaleManager.spaceScale(
              spaceing: 87,
            ).value,
            child: Text(
              /// For removing the underscores
              title.replaceAll('_', ' '),
              style: AppTextStyle.hintStyleXS.copyWith(fontSize: 14),
              textScaleFactor: textScaleFactor,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 20,
            ).value,
          )
        ],
      ),
    );
  }
}
