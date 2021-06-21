import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-controller.dart';

class BottomNavBar extends StatefulWidget {
  final ProfileController controller = Get.find();
  final String mood;

  BottomNavBar({Key key, @required this.mood}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color color;
  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomAppBar(
            elevation: 0,
            notchMargin: 0,
            color: Colors.white,
            child:Stack(children: [
              if (widget.controller.selectedScreenIndex.value == 0) Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                ],
              ) else widget.controller.selectedScreenIndex.value == 1?
              Row(
                children: [
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                  Spacer(),
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                ],
              )
                  :widget.controller.selectedScreenIndex.value == 2 ? Row(
                children: [
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                  Spacer(),
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                ],
              ):
              widget.controller.selectedScreenIndex.value == 3 ?
              Row(
                children: [
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  ),
                  Spacer(),
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  )
                ],
              ):Row(
                children: [
                  Container(
                    height: ScaleManager.spaceScale(
                      spaceing: 61,
                    ).value,
                    width: Get.width*0.80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(
                            ScaleManager.spaceScale(
                              spaceing: 25,
                            ).value,
                          ),
                        ),
                        border: Border.all(
                          color: greyLightShade,
                        )),
                  )
                ],
              ),

              ///row of icons

              Padding(
                padding:  EdgeInsets.only(left:ScaleManager.spaceScale(
                  spaceing: 20,
                ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value),
                child: Container(
                  height: ScaleManager.spaceScale(
                    spaceing: 61,
                  ).value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            ImagePath.profileIcon,
                            height: ScaleManager.spaceScale(
                              spaceing: 34,
                            ).value,
                            color: widget.controller.selectedScreenIndex.value == 0
                                ? blueDarkShade
                                : greyLightShade,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.controller.selectedScreenIndex.value = 0;
                            });
                          }),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          ImagePath.wheelIcon,
                          height: ScaleManager.spaceScale(
                            spaceing: 34,
                          ).value,
                          color: widget.controller.selectedScreenIndex.value == 1
                              ? blueDarkShade
                              : greyLightShade,
                        ),
                        onPressed: () {
                          setState(
                                () {
                              widget.controller.selectedScreenIndex.value = 1;
                            },
                          );
                        },
                      ),
                      IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            ImagePath.moodIcon,
                            height: ScaleManager.spaceScale(
                              spaceing: 34,
                            ).value,
                            color: widget.controller.selectedScreenIndex.value == 2
                                ? blueDarkShade
                                : greyLightShade,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.controller.selectedScreenIndex.value = 2;
                            });
                          }),
                      IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            ImagePath.diaryIcon,
                            height: ScaleManager.spaceScale(
                              spaceing: 34,
                            ).value,
                            color: widget.controller.selectedScreenIndex.value == 3
                                ? blueDarkShade
                                : greyLightShade,
                          ),
                          onPressed: () {
                            setState(
                                  () {
                                widget.controller.selectedScreenIndex.value = 3;
                              },
                            );
                          }),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: SvgPicture.asset(
                          ImagePath.profileDiaryIcon,
                          height: ScaleManager.spaceScale(
                            spaceing: 34,
                          ).value,
                          color: widget.controller.selectedScreenIndex.value == 4
                              ? blueDarkShade
                              : greyLightShade,
                        ),
                        onPressed: () {
                          setState(
                                () {
                              widget.controller.selectedScreenIndex.value = 4;
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ])
        ));
  }
}