import 'dart:ui';

import 'package:flutter/material.dart';
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
    return BottomAppBar(
        elevation: 0,
        notchMargin: 0,
        color: Colors.white,
        child: widget.controller.selectedScreenIndex.value == 0
            ? Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScaleManager.spaceScale(
                      spaceing: 20,
                    ).value),
                    child: IconButton(
                        icon: Image.asset(
                          'assets/profile-icon/profile.png',
                          height: ScaleManager.spaceScale(
                            spaceing: 30,
                          ).value,
                          color:
                              widget.controller.selectedScreenIndex.value == 0
                                  ? blueDarkShade
                                  : greyLightShade,
                          scale: imageScaleFactor,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.controller.selectedScreenIndex.value = 0;
                          });
                        }),
                  ),
                  SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 15,
                    ).value,
                  ),
                  Expanded(
                    child: Container(
                      width: ScaleManager.spaceScale(
                        spaceing: 325.70,
                      ).value,
                      height: ScaleManager.spaceScale(
                        spaceing: 61,
                      ).value,
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
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: ScaleManager.spaceScale(
                            spaceing: 15,
                          ).value,
                          right: ScaleManager.spaceScale(
                            spaceing: 15,
                          ).value,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Image.asset(
                                'assets/profile-icon/wheel.png',
                                height: ScaleManager.spaceScale(
                                  spaceing: 30,
                                ).value,
                                scale: imageScaleFactor,
                                color:
                                    widget.controller.selectedScreenIndex.value ==
                                            1
                                        ? blueDarkShade
                                        : greyLightShade,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    widget.controller.selectedScreenIndex.value =
                                        1;
                                  },
                                );
                              },
                            ),
                            IconButton(
                                icon: Image.asset(
                                  'assets/profile-icon/mood.png',
                                  height: ScaleManager.spaceScale(
                                    spaceing: 30,
                                  ).value,
                                  scale: imageScaleFactor,
                                  color: widget.controller.selectedScreenIndex
                                              .value ==
                                          2
                                      ? blueDarkShade
                                      : greyLightShade,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      widget.controller.selectedScreenIndex
                                          .value = 2;
                                    },
                                  );
                                }),
                            IconButton(
                                icon: Image.asset(
                                  'assets/profile-icon/diary.png',
                                  height: ScaleManager.spaceScale(
                                    spaceing: 30,
                                  ).value,
                                  scale: imageScaleFactor,
                                  color: widget.controller.selectedScreenIndex
                                              .value ==
                                          3
                                      ? blueDarkShade
                                      : greyLightShade,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      widget.controller.selectedScreenIndex
                                          .value = 3;
                                    },
                                  );
                                }),
                            IconButton(
                              icon: Image.asset(
                                'assets/profile-icon/profile_diary.png',
                                height: ScaleManager.spaceScale(
                                  spaceing: 30,
                                ).value,
                                scale: imageScaleFactor,
                                color:
                                    widget.controller.selectedScreenIndex.value ==
                                            4
                                        ? blueDarkShade
                                        : greyLightShade,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    widget.controller.selectedScreenIndex.value =
                                        4;
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )

            ///when selected index is 2

            : widget.controller.selectedScreenIndex.value == 2
                ? Row(
                    children: [
                      Container(
                        width: ScaleManager.spaceScale(
                          spaceing: 165.20,
                        ).value,
                        height: ScaleManager.spaceScale(
                          spaceing: 61,
                        ).value,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(
                              ScaleManager.spaceScale(
                                spaceing: 25,
                              ).value,
                            )),
                            border: Border.all(
                              color: greyLightShade,
                              width: ScaleManager.spaceScale(
                                spaceing: 1,
                              ).value,
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ScaleManager.spaceScale(
                              spaceing: 20,
                            ).value,
                            right: ScaleManager.spaceScale(
                              spaceing: 15,
                            ).value,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Image.asset(
                                  'assets/profile-icon/profile.png',
                                  height: ScaleManager.spaceScale(
                                    spaceing: 30,
                                  ).value,
                                  scale: imageScaleFactor,
                                  color: widget.controller.selectedScreenIndex
                                              .value ==
                                          0
                                      ? blueDarkShade
                                      : greyLightShade,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      widget.controller.selectedScreenIndex
                                          .value = 0;
                                    },
                                  );
                                },
                              ),
                              IconButton(
                                icon: Image.asset(
                                  'assets/profile-icon/wheel.png',
                                  height: ScaleManager.spaceScale(
                                    spaceing: 30,
                                  ).value,
                                  scale: imageScaleFactor,
                                  color: widget.controller.selectedScreenIndex
                                              .value ==
                                          1
                                      ? blueDarkShade
                                      : greyLightShade,
                                ),
                                onPressed: () {
                                  setState(
                                    () {
                                      widget.controller.selectedScreenIndex
                                          .value = 1;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScaleManager.spaceScale(
                          spaceing: 15,
                        ).value,
                      ),
                      IconButton(
                        icon: Image.asset(
                          'assets/profile-icon/mood.png',
                          height: ScaleManager.spaceScale(
                            spaceing: 30,
                          ).value,
                          scale: imageScaleFactor,
                          color:
                              widget.controller.selectedScreenIndex.value == 2
                                  ? blueDarkShade
                                  : greyLightShade,
                        ),
                        onPressed: () {
                          setState(
                            () {
                              widget.controller.selectedScreenIndex.value = 2;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: ScaleManager.spaceScale(
                          spaceing: 15,
                        ).value,
                      ),
                      Expanded(child: Container(
                        width: ScaleManager.spaceScale(
                          spaceing: 165.60,
                        ).value,
                        height: ScaleManager.spaceScale(
                          spaceing: 61,
                        ).value,
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
                              width: ScaleManager.spaceScale(
                                spaceing: 1,
                              ).value,
                            )),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: ScaleManager.spaceScale(
                              spaceing: 15,
                            ).value,
                            right: ScaleManager.spaceScale(
                              spaceing: 15,
                            ).value,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: Image.asset(
                                    'assets/profile-icon/diary.png',
                                    height: ScaleManager.spaceScale(
                                      spaceing: 30,
                                    ).value,
                                    scale: imageScaleFactor,
                                    color: widget.controller.selectedScreenIndex
                                        .value ==
                                        3
                                        ? blueDarkShade
                                        : greyLightShade,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.controller.selectedScreenIndex
                                          .value = 3;
                                    });
                                  }),
                              IconButton(
                                icon: Image.asset(
                                  'assets/profile-icon/profile_diary.png',
                                  height: ScaleManager.spaceScale(
                                    spaceing: 30,
                                  ).value,
                                  color: widget.controller.selectedScreenIndex
                                      .value ==
                                      4
                                      ? blueDarkShade
                                      : greyLightShade,
                                ),
                                onPressed: () {
                                  setState(
                                        () {
                                      widget.controller.selectedScreenIndex
                                          .value = 4;
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),)
                    ],
                  )

                ///when selected index is 1

                : widget.controller.selectedScreenIndex.value == 1
                    ? Row(
                        children: [
                          Container(
                            width: ScaleManager.spaceScale(
                              spaceing: 84,
                            ).value,
                            height: ScaleManager.spaceScale(
                              spaceing: 61,
                            ).value,
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
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: ScaleManager.spaceScale(
                                  spaceing: 20,
                                ).value,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/profile-icon/profile.png',
                                      height: ScaleManager.spaceScale(
                                        spaceing: 30,
                                      ).value,
                                      scale: imageScaleFactor,
                                      color: widget.controller
                                                  .selectedScreenIndex.value ==
                                              0
                                          ? blueDarkShade
                                          : greyLightShade,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          widget.controller.selectedScreenIndex
                                              .value = 0;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScaleManager.spaceScale(
                              spaceing: 15,
                            ).value,
                          ),
                          IconButton(
                            icon: Image.asset(
                              'assets/profile-icon/wheel.png',
                              height: ScaleManager.spaceScale(
                                spaceing: 30,
                              ).value,
                              color:
                                  widget.controller.selectedScreenIndex.value ==
                                          1
                                      ? blueDarkShade
                                      : greyLightShade,
                            ),
                            onPressed: () {
                              setState(
                                () {
                                  widget.controller.selectedScreenIndex.value =
                                      1;
                                },
                              );
                            },
                          ),
                          SizedBox(
                            width: ScaleManager.spaceScale(
                              spaceing: 15,
                            ).value,
                          ),
                          Expanded(
                            child: Container(
                              width: ScaleManager.spaceScale(
                                spaceing: 246.65,
                              ).value,
                              height: ScaleManager.spaceScale(
                                spaceing: 61,
                              ).value,
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
                                    width: ScaleManager.spaceScale(
                                      spaceing: 1,
                                    ).value,
                                  )),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: ScaleManager.spaceScale(
                                    spaceing: 15,
                                  ).value,
                                  right: ScaleManager.spaceScale(
                                    spaceing: 15,
                                  ).value,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/profile-icon/mood.png',
                                        height: ScaleManager.spaceScale(
                                          spaceing: 30,
                                        ).value,
                                        scale: imageScaleFactor,
                                        color: widget.controller
                                                    .selectedScreenIndex.value ==
                                                2
                                            ? blueDarkShade
                                            : greyLightShade,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            widget.controller.selectedScreenIndex
                                                .value = 2;
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/profile-icon/diary.png',
                                        height: ScaleManager.spaceScale(
                                          spaceing: 30,
                                        ).value,
                                        scale: imageScaleFactor,
                                        color: widget.controller
                                                    .selectedScreenIndex.value ==
                                                3
                                            ? blueDarkShade
                                            : greyLightShade,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            widget.controller.selectedScreenIndex
                                                .value = 3;
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Image.asset(
                                        'assets/profile-icon/profile_diary.png',
                                        height: ScaleManager.spaceScale(
                                          spaceing: 30,
                                        ).value,
                                        scale: imageScaleFactor,
                                        color: widget.controller
                                                    .selectedScreenIndex.value ==
                                                4
                                            ? blueDarkShade
                                            : greyLightShade,
                                      ),
                                      onPressed: () {
                                        setState(
                                          () {
                                            widget.controller.selectedScreenIndex
                                                .value = 4;
                                          },
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )

                    ///when selected index is 3

                    : widget.controller.selectedScreenIndex.value == 3
                        ? Row(
                            children: [
                              Container(
                                width: ScaleManager.spaceScale(
                                  spaceing: 246.65,
                                ).value,
                                height: ScaleManager.spaceScale(
                                  spaceing: 61,
                                ).value,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                      ScaleManager.spaceScale(
                                        spaceing: 25,
                                      ).value,
                                    )),
                                    border: Border.all(
                                      color: greyLightShade,
                                      width: ScaleManager.spaceScale(
                                        spaceing: 1,
                                      ).value,
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: ScaleManager.spaceScale(
                                      spaceing: 20,
                                    ).value,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/profile.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    0
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 0;
                                            });
                                          }),
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/wheel.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    1
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 1;
                                            });
                                          }),
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/mood.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    2
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 2;
                                            });
                                          }),
                                      SizedBox(
                                        width: ScaleManager.spaceScale(
                                          spaceing: 0,
                                        ).value,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScaleManager.spaceScale(
                                  spaceing: 15,
                                ).value,
                              ),
                              IconButton(
                                  icon: Image.asset(
                                    'assets/profile-icon/diary.png',
                                    height: ScaleManager.spaceScale(
                                      spaceing: 30,
                                    ).value,
                                    color: widget.controller.selectedScreenIndex
                                                .value ==
                                            3
                                        ? blueDarkShade
                                        : greyLightShade,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.controller.selectedScreenIndex
                                          .value = 3;
                                    });
                                  }),
                              SizedBox(
                                width: ScaleManager.spaceScale(
                                  spaceing: 15,
                                ).value,
                              ),
                              Expanded(child: Container(
                                width: ScaleManager.spaceScale(
                                  spaceing: 84,
                                ).value,
                                height: ScaleManager.spaceScale(
                                  spaceing: 61,
                                ).value,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            ScaleManager.spaceScale(
                                              spaceing: 25,
                                            ).value)),
                                    border: Border.all(
                                        color: greyLightShade,
                                        width: ScaleManager.spaceScale(
                                          spaceing: 1,
                                        ).value)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScaleManager.spaceScale(
                                        spaceing: 15,
                                      ).value,
                                      right: ScaleManager.spaceScale(
                                        spaceing: 15,
                                      ).value),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/profile_diary.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                .controller
                                                .selectedScreenIndex
                                                .value ==
                                                4
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 4;
                                            });
                                          })
                                    ],
                                  ),
                                ),
                              ),)
                            ],
                          )

                        ///for selected index 4

                        : Row(
                            children: [
                              Container(
                                width: ScaleManager.spaceScale(
                                  spaceing: 325.70,
                                ).value,
                                height: ScaleManager.spaceScale(
                                  spaceing: 61,
                                ).value,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            ScaleManager.spaceScale(
                                      spaceing: 25,
                                    ).value)),
                                    border: Border.all(
                                        color: greyLightShade,
                                        width: ScaleManager.spaceScale(
                                          spaceing: 1,
                                        ).value)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: ScaleManager.spaceScale(
                                        spaceing: 15,
                                      ).value,
                                      right: ScaleManager.spaceScale(
                                        spaceing: 15,
                                      ).value),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/profile.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    0
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 0;
                                            });
                                          }),
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/wheel.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    1
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 1;
                                            });
                                          }),
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/mood.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    2
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 2;
                                            });
                                          }),
                                      IconButton(
                                          icon: Image.asset(
                                            'assets/profile-icon/diary.png',
                                            height: ScaleManager.spaceScale(
                                              spaceing: 30,
                                            ).value,
                                            scale: imageScaleFactor,
                                            color: widget
                                                        .controller
                                                        .selectedScreenIndex
                                                        .value ==
                                                    3
                                                ? blueDarkShade
                                                : greyLightShade,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              widget
                                                  .controller
                                                  .selectedScreenIndex
                                                  .value = 3;
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: ScaleManager.spaceScale(
                                  spaceing: 15,
                                ).value,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    right: ScaleManager.spaceScale(
                                  spaceing: 20,
                                ).value),
                                child: IconButton(
                                    icon: Image.asset(
                                      'assets/profile-icon/profile_diary.png',
                                      height: ScaleManager.spaceScale(
                                        spaceing: 30,
                                      ).value,
                                      color: widget.controller
                                                  .selectedScreenIndex.value ==
                                              4
                                          ? blueDarkShade
                                          : greyLightShade,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget.controller.selectedScreenIndex
                                            .value = 4;
                                      });
                                    }),
                              ),
                            ],
                          ));
  }
}
