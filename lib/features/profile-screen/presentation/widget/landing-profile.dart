import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/profile-controller.dart';
import 'bottom-sheet.dart';

class LandingProfileScreen extends GetWidget<ProfileController> {
  const LandingProfileScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return SizedBox(
      width: Get.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
            ),
            Image.asset(
              'assets/profile-icon/user-image.png',
              height: ScaleManager.spaceScale(
                spaceing: 79,
              ).value,
              scale: imageScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
            ),
            Text(
              controller.profileData.value.nickName,
              style: AppTextStyle.titleMDark,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
            ),
            Text(
              "I want to ${controller.profileData.value.focusIssues.first.displayName} better",
              style: AppTextStyle.Darkbluebold.copyWith(color: greyLightShade),
              textScaleFactor: textScaleFactor,
            ),
            Text(
              controller.profileData.value.journeyPath.title,
              style: AppTextStyle.lightbold,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 10,
              ).value,
            ),
            Container(
              height: 1,
              width: ScaleManager.spaceScale(
                spaceing: 324,
              ).value,
              color: greyline,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 18,
              ).value,
            ),
            InfoContainer(
              image: 'assets/profile-icon/user-image.png',
              field: tr('holistic score'),
              score: controller.profileData.value.holisticScore.toString(),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (context) => const InfoBottomSheet(
                    selectedArea: 'What is my holistic score?',
                    description:
                        'Your best self can only happen when you have access to  growth in different areas o',
                  ),
                );
              },
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 17,
              ).value,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 65,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 50,
                  ).value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoContainer(
                    image: 'assets/profile-icon/user-image.png',
                    field: tr('time taken'),
                    score: controller.profileData.value.timeOnActivitiesThisWeek
                        .toString(),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (context) => const InfoBottomSheet(
                          selectedArea: 'What is my holistic score?',
                          description:
                          'Your best self can only happen when you have access to  growth in different areas o',
                        ),
                      );
                    },
                  ),
                  InfoContainer(
                    image: 'assets/profile-icon/user-image.png',
                    field: tr('how many activity done'),
                    score: controller.profileData.value.activitiesThisWeek
                        .toString(),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        builder: (context) => const InfoBottomSheet(
                          selectedArea: 'What is my holistic score?',
                          description:
                          'Your best self can only happen when you have access to  growth in different areas o',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 21,
              ).value,
            )
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String image;
  final String field;
  final String score;
  final Callback onPressed;
  const InfoContainer({this.image, this.field, this.score, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 113,
              ).value,
              width: ScaleManager.spaceScale(
                spaceing: 113,
              ).value,
              child: Image.asset(
                image,
                scale: imageScaleFactor,
              )),
          SizedBox(
            height: ScaleManager.spaceScale(
              spaceing: 11,
            ).value,
          ),
          Text(
            field,
            style: AppTextStyle.dayText.copyWith(fontSize: 14),
            textScaleFactor: textScaleFactor,
          ),
          Text(
            score,
            textScaleFactor: textScaleFactor,
            style: AppTextStyle.ligntbluedescription.copyWith(fontSize: 18),
          ),
          Text(
            tr('current week'),
            style: AppTextStyle.dayText.copyWith(fontSize: 14),
            textScaleFactor: textScaleFactor,
          ),
        ],
      ),
    );
  }
}
