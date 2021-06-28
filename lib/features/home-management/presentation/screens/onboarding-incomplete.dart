// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-x-axis.dart';
import 'package:tatsam_app_experimental/features/home-management/presentation/widgets/old-vs-new-rendering-checker.dart';
import 'package:tatsam_app_experimental/features/home-management/presentation/widgets/weekend-renderer.dart';
import 'package:tatsam_app_experimental/features/home-management/presentation/widgets/weekend-ui-fragment.dart';

// Project imports:
import '../../../../core/activity-management/presentation/controller/path-controller.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/buttons/bottom-middle-button.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../../../../features/home-management/presentation/controller/home-controller.dart';
import '../../../../features/home-management/presentation/widgets/appbar.dart';
import '../../../../features/home-management/presentation/widgets/rendering-condition-checker.dart';
import '../../../../features/home-management/presentation/widgets/view-injector.dart';
import '../../../../features/home-management/presentation/widgets/week-day-viewer.dart';
import '../../../../features/rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';

class OnBoardingIncomplete extends StatefulWidget {
  @override
  _OnBoardingIncompleteState createState() => _OnBoardingIncompleteState();
}

class _OnBoardingIncompleteState extends State<OnBoardingIncomplete> {
  final HomeController controller = Get.find();

  final DurationTrackerController durationController = Get.find();

  final PathController pathController = Get.find();
  final RapportBuildingController rapportBuildingController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchMostRecentActivity();
      //! Uncomment if want immidieate actions after completing activity
      // controller.retrievePostOnboardingActions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final imageScaleFactor = ScaleManager.imageScale.value;
    final textScaleFactor = ScaleManager.textScale.value;

    return SafeArea(
      child: FadeAnimationXAxis(
        0.2,
        Scaffold(
          body: Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : CustomScrollView(
                    slivers: [
                      /// Custom appbar component
                      HomScreenAppBar(
                        imageScaleFactor: imageScaleFactor,
                      ),

                      /// Top half UI portion of screen
                      Obx(
                        () => _TopHalfComponent(
                          imageScaleFactor: imageScaleFactor,
                          userMood: controller.userMood.value.moodName,
                          textScaleFactor: textScaleFactor,
                          toShowCatgories: controller.toShowCategories.value,
                          whatToDoNextTitle: controller.chosenPath.value ==
                                  'BIG_WINS'
                              ? 'Here are ${controller.recommendedActivities.length} more things on your list today.'
                              : 'Here are some things you can do now. ',
                          smallIntroText: 'Today is the start of your journey!',
                          recentActivityTitle:
                              controller.mostRecentAcitivity.value == null
                                  ? ''
                                  : controller.mostRecentAcitivity.value.title,
                          userName: controller.userNickname.value,
                          userPath: controller.chosenPath.value,
                          daysInWeek: controller.daysToBeShownInUI,
                          activeWeekday: controller.getActiveDay(),
                          isFirstTimeUser: controller.isFirstTimeUser.value,
                        ),
                      ),

                      /// View injector will weither show ui accoring to first-time-omboarding or normal visitor
                      ViewInjector(
                        homeController: controller,
                        durationController: durationController,
                        rapportBuildingController: rapportBuildingController,
                        pathController: pathController,
                      ),

                      /// Bottom accetptence button
                      _ConfirmButtonManager(
                        controller: controller,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Will generate the top-ui component, based on user has onboarded or not
/// i.e: from Hello {userName} to above recommendations
class _TopHalfComponent extends StatelessWidget {
  const _TopHalfComponent({
    Key key,
    @required this.imageScaleFactor,
    @required this.textScaleFactor,
    @required this.userName,
    @required this.userMood,
    @required this.userPath,
    @required this.recentActivityTitle,
    @required this.smallIntroText,
    @required this.whatToDoNextTitle,
    @required this.activeWeekday,
    @required this.daysInWeek,
    @required this.isFirstTimeUser,
    @required this.toShowCatgories,
  }) : super(key: key);

  final double imageScaleFactor;
  final double textScaleFactor;
  final String userName;
  final String userMood;
  final String userPath;
  final String smallIntroText;
  final String recentActivityTitle;
  final String whatToDoNextTitle;
  final String activeWeekday;
  final List<String> daysInWeek;
  final bool isFirstTimeUser;
  final bool toShowCatgories;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(
          top: ScaleManager.spaceScale(
            spaceing: 25,
          ).value,
          bottom: ScaleManager.spaceScale(
            spaceing: 35,
          ).value,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UiForOldAndNewUserRenderer(
                  isNewUser: isFirstTimeUser,
                  widgetForNewUser: Image.asset(
                    ImagePath.onBoardingIncompleteImage,
                    height: ScaleManager.spaceScale(
                      spaceing: 94,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 94,
                    ).value,
                    scale: imageScaleFactor,
                  ),
                  widgetForOldUser: SizedBox(
                    height: ScaleManager.spaceScale(
                      spaceing: 35,
                    ).value,
                    width: ScaleManager.spaceScale(
                      spaceing: 35,
                    ).value,
                    child: Image.asset(
                      '${ImagePath.emojiList}${'/$userMood.png'}',
                      scale: ScaleManager.imageScale.value,
                    ),
                  ),
                ),
                UiForOldAndNewUserRenderer(
                  isNewUser: isFirstTimeUser,
                  widgetForNewUser: SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 16,
                    ).value,
                  ),
                  widgetForOldUser: SizedBox(
                    width: ScaleManager.spaceScale(
                      spaceing: 16,
                    ).value,
                  ),
                ),
                UiForOldAndNewUserRenderer(
                  isNewUser: isFirstTimeUser,
                  widgetForNewUser: Text(
                    'Hello $userName',
                    style: AppTextStyle.boldDarkBlueText,
                    textScaleFactor: textScaleFactor,
                  ),
                  widgetForOldUser: Text(
                    'Welcome back $userName',
                    style: AppTextStyle.boldDarkBlueText.copyWith(
                      fontSize: 19,
                    ),
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
            ),
            Container(
              margin: EdgeInsets.only(
                left: ScaleManager.spaceScale(
                  spaceing: 44,
                ).value,
                right: ScaleManager.spaceScale(
                  spaceing: 43,
                ).value,
              ),
              width: ScaleManager.spaceScale(
                spaceing: Get.width,
              ).value,
              height: ScaleManager.spaceScale(
                spaceing: 1,
              ).value,
              color: greyline,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 6,
              ).value,
            ),
            Text(
              smallIntroText,
              style: AppTextStyle.startingDayText,
              textScaleFactor: textScaleFactor,
            ),
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 15,
              ).value,
            ),
            Text(
              'Focus : the mind',
              style: AppTextStyle.darkerTitle,
              textScaleFactor: textScaleFactor,
            ),
            RenderingConditionChecker(
              whatToShow: Container(
                margin: EdgeInsets.only(
                  top: ScaleManager.spaceScale(
                    spaceing: 5,
                  ).value,
                  left: ScaleManager.spaceScale(
                    spaceing: 16,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 19,
                  ).value,
                ),
                child: WeekDayViewerComponent(
                  daysToBeShownInUI: daysInWeek,
                  activeDay: activeWeekday,
                ),
              ),
            ),
            RenderingConditionChecker(
              whatToShow: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 23,
                ).value,
              ),
            ),
            WeekendWidgetInjector(
              weekDay: activeWeekday,
              toShowCatgories: toShowCatgories,
              userPath: userPath,
              placeHolderWidget: EmptySpacePlaceHolder(),
              widgetToShow: RenderingConditionChecker(
                whatToShow: Container(
                  margin: EdgeInsets.only(
                    left: ScaleManager.spaceScale(
                      spaceing: 44,
                    ).value,
                    right: ScaleManager.spaceScale(
                      spaceing: 43,
                    ).value,
                  ),
                  width: Get.width,
                  height: ScaleManager.spaceScale(
                    spaceing: 1,
                  ).value,
                  color: greyline,
                ),
              ),
              isNewUser: isFirstTimeUser,
            ),
            WeekendWidgetInjector(
              weekDay: activeWeekday,
              toShowCatgories: toShowCatgories,
              placeHolderWidget: EmptySpacePlaceHolder(),
              userPath: userPath,
              widgetToShow: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 33,
                ).value,
              ),
              isNewUser: isFirstTimeUser,
            ),
            //! Content to be shown on weekends will go here
            WeekendWidgetInjector(
              weekDay: activeWeekday,
              userPath: userPath,
              toShowCatgories: toShowCatgories,
              isNewUser: isFirstTimeUser,
              placeHolderWidget: EmptySpacePlaceHolder(),
              widgetToShow: WeekendUiFragment(),
            ),
            RenderingConditionChecker(
              whatToShow: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 23,
                ).value,
              ),
            ),
            RenderingConditionChecker(
              whatToShow: Container(
                margin: EdgeInsets.only(
                  left: ScaleManager.spaceScale(
                    spaceing: 44,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 43,
                  ).value,
                ),
                width: Get.width,
                height: ScaleManager.spaceScale(
                  spaceing: 1,
                ).value,
                color: greyline,
              ),
            ),

            /// If user hasn't completed any activity recently
            /// No recent activity elemnt would be shown to him
            if (recentActivityTitle.isNotEmpty)
              RenderingConditionChecker(
                whatToShow: Container(
                  margin: EdgeInsets.only(
                    top: ScaleManager.spaceScale(spaceing: 33).value,
                    left: ScaleManager.spaceScale(spaceing: 70).value,
                    right: ScaleManager.spaceScale(spaceing: 60).value,
                  ),
                  child: Text(
                    'You just finished $recentActivityTitle. Wohoo!!',
                    style: AppTextStyle.greyHint,
                    textAlign: TextAlign.center,
                    textScaleFactor: textScaleFactor,
                  ),
                ),
              )
            else
              EmptySpacePlaceHolder(),
            RenderingConditionChecker(
              whatToShow: SizedBox(
                height: ScaleManager.spaceScale(spaceing: 20).value,
              ),
            ),
            RenderingConditionChecker(
              whatToShow: Text(
                whatToDoNextTitle,
                style: AppTextStyle.greyHint,
                textScaleFactor: textScaleFactor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Injects the buton done button by confirming wheater user has previously onboarded or not
class _ConfirmButtonManager extends StatelessWidget {
  const _ConfirmButtonManager({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(
        () => controller.fulfilledAllPostOnboardingActions.value
            ? Container(
                /*margin: EdgeInsets.only(
                  bottom: ScaleManager.spaceScale(
                    spaceing: 40,
                  ).value,
                  right: ScaleManager.spaceScale(
                    spaceing: 97,
                  ).value,
                  left: ScaleManager.spaceScale(
                    spaceing: 97,
                  ).value,
                ),
                height: ScaleManager.spaceScale(
                  spaceing: 56,
                ).value,
                width: MediaQuery.of(context).size.width,
                child: BottomMiddleButton(
                  title: 'DONE FOR TODAY',
                  onPressed: () async {},
                ),*/
              )
            : EmptySpacePlaceHolder(),
      ),
    );
  }
}
