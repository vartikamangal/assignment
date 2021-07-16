import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/cache-manager/domain/entities/activity-feedback.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/helper_functions/generate-date-from-datetime.dart';
import '../../../../core/utils/universal-widgets/private-view.dart';
import '../../../../features/profile-screen/presentation/controller/profile-controller.dart';

/// Wrapper which will make the child private
class DiaryScreen extends PrivateView {
  DiaryScreen() : super(child: MyDiary());
}

class MyDiary extends GetWidget<ProfileController> {
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
              tr('diary'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 10,
              ).value,
            ),
            Text(
              tr('collection of thoughts title'),
              style:
                  AppTextStyle.lightbold.copyWith(fontWeight: FontWeight.w300),
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            Obx(
              () => _buildDiary(
                controller.diaryLogs,
                controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildDiary(List<ActivityFeedback> logs, ProfileController controller) {
  final List<DiaryContent> _contents = [];
  logs.forEach(
    (diaryLog) {
      log(diaryLog.toString());

      /// TODO: Fix null error in below LOC
      final selectedMoodImage =
          '${ImagePath.lightBlueEmoji}${'${controller.actionIdToActionMap[int.parse(diaryLog.actionId!)]?.feedbackMood!.toLowerCase()}.png'}';
      final activityPerformed =
          controller.actionIdToActionMap[int.parse(diaryLog.actionId!)]?.title;
      _contents.add(
        DiaryContent(
          imageAddress: 'assets/profile-icon/user-image.png',
          selectedActivityName: activityPerformed,
          enteredThought: diaryLog.textFeedback,
          selectedMoodImage: selectedMoodImage,
          date: generateDateFromDateTime(
            DateTime.parse(
              diaryLog.timeOfCreation!,
            ),
          ),
        ),
      );
    },
  );
  return Column(
    children: _contents,
  );
}

class DiaryContent extends StatelessWidget {
  final String imageAddress;
  final String? selectedActivityName;
  final String date;
  final String selectedMoodImage;
  final String? enteredThought;

  const DiaryContent({
    required this.imageAddress,
    required this.selectedActivityName,
    required this.date,
    required this.selectedMoodImage,
    required this.enteredThought,
  });
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ScaleManager.spaceScale(
            spaceing: 324,
          ).value,
          height: 1,
          color: greyline,
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 18,
          ).value,
        ),
        Stack(
          children: [
            Row(
              children: [
                Image.asset(
                  imageAddress,
                  height: ScaleManager.spaceScale(
                    spaceing: 51,
                  ).value,
                  scale: imageScaleFactor,
                ),
                SizedBox(
                  width: ScaleManager.spaceScale(
                    spaceing: 5,
                  ).value,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ScaleManager.spaceScale(
                        spaceing: 230,
                      ).value,
                      child: Text(
                        selectedActivityName!,
                        style: AppTextStyle.Darkbluebold.copyWith(
                            fontWeight: FontWeight.w400, fontSize: 20),
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                    Text(
                      date,
                      style: AppTextStyle.titleS.copyWith(fontSize: 15),
                      textScaleFactor: textScaleFactor,
                    )
                  ],
                ),
              ],
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 10,
                      ).value,
                    ),
                    Image.asset(
                      selectedMoodImage,
                      height: 24,
                      scale: imageScaleFactor,
                    )
                  ],
                ))
          ],
        ),
        SizedBox(
          height: ScaleManager.spaceScale(
            spaceing: 5,
          ).value,
        ),
        Text(
          enteredThought!,
          style: AppTextStyle.titleS.copyWith(color: greyDarkShade),
          textScaleFactor: textScaleFactor,
        ),
        SizedBox(
            height: ScaleManager.spaceScale(
          spaceing: 19,
        ).value)
      ],
    );
  }
}
