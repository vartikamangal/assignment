import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/app-bar/top-app-bar.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/buttons/middle-call-us-button.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-controller.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/drop-down-button.dart';


class  SettingScreen extends  GetWidget<ProfileController>  {
  String image=ImagePath.happyEmoji;
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    controller.nicknameEditingController.value= TextEditingValue(text: controller.profileData.value!.nickName!);
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0,
        leading: TopAppBar(onPressed: (){Navigator.of(context).pop();}),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
            spaceing: 14,
          ).value,
              left: ScaleManager.spaceScale(
                spaceing: 44,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 43,
              ).value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //For change pic
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScaleManager.spaceScale(
                      spaceing: 40,
                    ).value),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      width: ScaleManager.spaceScale(
                        spaceing: 79,
                      ).value,
                      height: ScaleManager.spaceScale(
                        spaceing: 79,
                      ).value,
                    ),
                  ),
                  SizedBox(width: ScaleManager.spaceScale(
                    spaceing: 14,
                  ).value,),
                  TextButton(onPressed: (){},
                      child: Text(tr('change your profile'),
                        style: AppTextStyle.titlel.copyWith(fontSize: 17),
                        textScaleFactor: textScaleFactor,
                      ))
                ],
              ),

              //For name

              Padding(
                padding:  EdgeInsets.only(top:ScaleManager.spaceScale(
                  spaceing: 10,
                ).value),
                child: TextField(
                  controller: controller.nameEditingController,
                  style: AppTextStyle.titlel.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: tr('name'),labelStyle: AppTextStyle.hintStyle.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value),
                      contentPadding:  EdgeInsets.symmetric(
                          vertical: ScaleManager.spaceScale(
                            spaceing: 10,
                          ).value)),
                ),
              ),

              //for nickname
              Padding(
                padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                  spaceing: 10,
                ).value),
                child: TextField(
                  controller: controller.nicknameEditingController,
                  style: AppTextStyle.titlel.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value),
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: tr('nickname'),labelStyle: AppTextStyle.hintStyle.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScaleManager.spaceScale(
                          spaceing: 10,
                        ).value),),
                ),
              ),

              //For Dob
              Padding(
                padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                  spaceing: 10,
                ).value),
                child: TextField(
                  controller: controller.dobEditingController,
                  style: AppTextStyle.titlel.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 26,
                  ).value),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                    LengthLimitingTextInputFormatter(10),
                    _DateFormatter(),
                  ],
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(labelText: tr('dob'),labelStyle: AppTextStyle.hintStyle.copyWith(fontSize: ScaleManager.spaceScale(
                    spaceing: 12,
                  ).value),

                    contentPadding: EdgeInsets.symmetric(
                        vertical: ScaleManager.spaceScale(
                          spaceing: 10,
                        ).value),),
                ),
              ),

              //For email id
              Padding(
                padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                  spaceing: 17,
                ).value),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr('email id'),
                        textScaleFactor: textScaleFactor,
                        style: AppTextStyle.hintStyle.copyWith(fontSize: 12),
                      ),
                      Text(
                        'test@test.com',
                        textScaleFactor: textScaleFactor,
                        style: AppTextStyle.dayText.copyWith(fontSize: 26),
                      )
                    ],
                  ),
                ),
              ),

              //For remaining item
              Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                      spaceing: 105,
                    ).value),
                    child: Column(
                      children: [

                        //focus area chosen
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(tr('focus area'),
                              textScaleFactor: textScaleFactor,
                              style: AppTextStyle.hintStyle.copyWith(fontSize: 20),),
                            TextButton(onPressed: () {print('first');},
                                child: Row(children: [
                                  Text('Sleep',
                                    style: AppTextStyle.titlel.copyWith(fontSize: 19),
                                    textScaleFactor: textScaleFactor,),
                                  SizedBox(width: ScaleManager.spaceScale(
                                    spaceing: 8,
                                  ).value,),
                                  SvgPicture.asset(ImagePath.forwardIcon,
                                    height: ScaleManager.spaceScale(
                                      spaceing: 16.3,
                                    ).value,
                                    color: blueDarkShade,)],))
                          ],
                        ),

                        //path chosen
                        Padding(
                          padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                            spaceing: 1,
                          ).value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(tr('path'),
                                textScaleFactor: textScaleFactor,
                                style: AppTextStyle.hintStyle.copyWith(fontSize: 20),),
                              TextButton(onPressed: () {print('second');},
                                  child: Row(children: [
                                    Text('Sleep',
                                      style: AppTextStyle.titlel.copyWith(fontSize: 19),
                                      textScaleFactor: textScaleFactor,),
                                    SizedBox(width: ScaleManager.spaceScale(
                                      spaceing: 8,
                                    ).value,),
                                    SvgPicture.asset(ImagePath.forwardIcon,
                                      height: ScaleManager.spaceScale(
                                        spaceing: 16.3,
                                      ).value,
                                      color: blueDarkShade,)],))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //gender selection
                  Padding(
                    padding:  EdgeInsets.only(top: ScaleManager.spaceScale(
                      spaceing: 22,
                    ).value),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr('gender'),
                            textScaleFactor: textScaleFactor,
                            style: AppTextStyle.hintStyle.copyWith(fontSize: 12),
                          ),

                          SizedBox(height: ScaleManager.spaceScale(
                            spaceing: 11,
                          ).value,),
                          Obx(
                                () => controller.isDropDownExpanded.value? DropDownBtn(
                              color: blueDarkShade,
                              isExpanded: true,
                              label:tr('selection'),
                              // ignore: avoid_print
                              onPressed: () => controller.toggleDropDownExpansion(),
                              controller: controller,
                            )
                                : DropDownBtn(
                              color: blueDarkShade,
                              isExpanded: false,
                              label:tr('selection'),
                              // ignore: avoid_print
                              onPressed: () => controller.toggleDropDownExpansion(),
                              // ignore: avoid_print
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 30,
                ).value,
              ),

              //Button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 101,
                    ).value,
                    child: MiddleCallUsButton(
                      title: 'SAVE',
                      onPressed: (){},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 14,
                ).value,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}



// Persistent Dropdown header
class _DropDownTopHeader extends StatelessWidget {
  const _DropDownTopHeader({
    Key? key,
    required this.textScaleFactor,
    required this.color,
    required this.label,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  final double textScaleFactor;
  final Color color;
  final String label;
  final bool isExpanded;
  final Callback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ScaleManager.spaceScale(spaceing: 151).value,
        height: ScaleManager.spaceScale(spaceing: 40).value,
        padding: EdgeInsets.only(
          top: ScaleManager.spaceScale(
            spaceing: 2,
          ).value,
          bottom: ScaleManager.spaceScale(
            spaceing: 8,
          ).value,
          left: ScaleManager.spaceScale(
            spaceing: 21,
          ).value,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            topRight: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            bottomLeft: Radius.circular(
              ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
          ),
        ),
        child: Row(
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScaleManager.spaceScale(
                      spaceing: 6,
                    ).value),
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.dropDownStyle,
                  textScaleFactor: textScaleFactor,
                ),
              ),
            ),
            SizedBox(
              width: ScaleManager.spaceScale(
                spaceing: 12,
              ).value,
            ),
            if (isExpanded)
              Icon(
                Icons.arrow_drop_up,
                color: Theme.of(context).canvasColor,
                size: ScaleManager.spaceScale(
                  spaceing: 36,
                ).value,
              )
            else
              Icon(
                Icons.arrow_drop_down,
                color: Theme.of(context).canvasColor,
                size: ScaleManager.spaceScale(
                  spaceing: 36,
                ).value,
              ),
          ],
        ),
      ),
    );
  }
}



//




class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;
    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;
    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 18 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }
    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

