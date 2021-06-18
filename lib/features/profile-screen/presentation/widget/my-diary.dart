import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';

class MyDiary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.only(left: ScaleManager.spaceScale(
          spaceing: 32,
        ).value,
        right: ScaleManager.spaceScale(
          spaceing: 29,
        ).value),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tr('diary'),
              textScaleFactor: textScaleFactor,
              style: AppTextStyle.titleL.copyWith(fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: ScaleManager.spaceScale(
              spaceing: 10,
            ).value,),
            Text(tr('collection of thoughts title'),
              style: AppTextStyle.lightbold.copyWith(fontWeight: FontWeight.w300),
            textScaleFactor: textScaleFactor,),
            SizedBox(height: ScaleManager.spaceScale(
              spaceing: 20,
            ).value,),
            DiaryContent(imageAddress: 'assets/profile-icon/user-image.png',
            selectedActivityName: 'Gratitude journal',
              date: '19/02/21',
              selectedMoodImage: '${ImagePath.lightBlueEmoji}${'happy.png'}',
              enteredThought: 'Lorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enter',
            ),
            DiaryContent(imageAddress: 'assets/profile-icon/user-image.png',
              selectedActivityName: 'Gratitude journal',
              date: '19/02/21',
              selectedMoodImage: '${ImagePath.lightBlueEmoji}${'happy.png'}',
              enteredThought: 'Lorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enterLorem ipsum some random text goes here that the user will enter',
            )

          ],
        ),
      ),
    );
  }
}

class DiaryContent extends StatelessWidget {
  @required String imageAddress;
  @required String selectedActivityName;
  @required String date;
  @required String selectedMoodImage;
  @required String enteredThought;
  DiaryContent({this.imageAddress,this.selectedActivityName,this.date,this.selectedMoodImage,this.enteredThought});
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Column(
    children: [
    Container(
    width:ScaleManager.spaceScale(
        spaceing: 324,
      ).value,
      height: 1,
      color: greyline,
        ),
        SizedBox(height: ScaleManager.spaceScale(
        spaceing: 18,
        ).value,),
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
              SizedBox(width: ScaleManager.spaceScale(
                spaceing: 5,
              ).value,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(selectedActivityName,
                    style: AppTextStyle.Darkbluebold.copyWith(fontWeight: FontWeight.w400,fontSize: 20),
                  textScaleFactor: textScaleFactor,),
                  Text(date,style: AppTextStyle.titleS.copyWith(fontSize: 15),
                  textScaleFactor: textScaleFactor,)
                ],
              ),
            ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                children: [
                  SizedBox(height: ScaleManager.spaceScale(
                    spaceing: 10,
                  ).value,),
                  Image.asset(selectedMoodImage,height: 24,scale: imageScaleFactor,)],
              ))
          ],
        ),
      SizedBox(height: ScaleManager.spaceScale(
        spaceing: 5,
      ).value),
      Text(enteredThought,
        style: AppTextStyle.titleS.copyWith(color: greyDarkShade),
      textScaleFactor: textScaleFactor,),
      SizedBox(height: ScaleManager.spaceScale(
        spaceing: 19,
      ).value)
        ],
        );
  }
}
