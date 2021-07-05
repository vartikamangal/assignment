import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/bottomsheet-fixed-top.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../controller/home-controller.dart';
import '../../../rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../../../rapport-building/Presentation/widgets/emotion_selector.dart';

class DailyMoodBottomSheet extends StatelessWidget {
  DailyMoodBottomSheet({Key? key}) : super(key: key);

  final _rapportController = Get.find<RapportBuildingController>();
  final _homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return Container(
      height: ScaleManager.spaceScale(
        spaceing: 180,
      ).value,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            ScaleManager.spaceScale(
              spaceing: 6,
            ).value,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          ScaleManager.spaceScale(
            spaceing: 6.0,
          ).value,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  tr('ask feeling title'),
                  textScaleFactor: textScale,
                  style: AppTextStyle.titleL,
                ),
                SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value,
                ),
                Obx(
                  () => _rapportController.isLoadComplete.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: invalid_use_of_protected_member
                          children: _rapportController.moods
                              .map(
                                (mood) => emotionSelector(
                                  mood.moodName!.toLowerCase(),
                                  () async {
                                    await _homeController.popupSetMoodAssist(
                                      moodName: mood.moodName,
                                    );
                                  },
                                  height: 42,
                                  width: 42,
                                ),
                              )
                              .toList(),
                        )
                      : EmptySpacePlaceHolder(),
                ),
              ],
            ),
            Obx(
              () => _homeController.isRating.value
                  ? const LinearProgressIndicator()
                  : const BottomSheetFixedTop(),
            )
          ],
        ),
      ),
    );
  }
}
