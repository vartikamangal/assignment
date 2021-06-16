import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/activity-management/presentation/controller/path-controller.dart';
import '../../../../core/duration-tracker/duration-tracker-controller.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../../../rapport-building/Presentation/controllers/rapport-building-controller.dart.dart';
import '../../../rapport-building/Presentation/widgets/emotion_selector.dart';
import '../controller/home-controller.dart';

class FeedbackView extends StatefulWidget {
  final bool isGuidedPlan;
  final HomeController homeController;
  final DurationTrackerController durationController;
  final PathController pathController;
  final RapportBuildingController rapportBuildingController;
  const FeedbackView({
    Key key,
    @required this.isGuidedPlan,
    @required this.durationController,
    @required this.homeController,
    @required this.pathController,
    @required this.rapportBuildingController,
  }) : super(key: key);

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textScale = ScaleManager.textScale.value;
    return SliverToBoxAdapter(
      child: Obx(
        () => widget.homeController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            // ignore: unrelated_type_equality_checks
            //! This condition check whater every recommendation is fulfilled
            : widget.homeController.fulfilledAllPostOnboardingActions.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('NO ACTIONS TO FULFILL Going back!'),
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(
                      left: ScaleManager.spaceScale(
                        spaceing: 17,
                      ).value,
                      right: ScaleManager.spaceScale(
                        spaceing: 16,
                      ).value,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'How was your experience with ${widget.homeController.currentActivePostOnboardingFeedbackAction.value.title}',
                          style: AppTextStyle.hintStyleDarkerForTextInputs,
                          textAlign: TextAlign.center,
                          textScaleFactor: textScale,
                        ),
                        SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 30,
                          ).value,
                        ),
                        Obx(
                          () => widget.rapportBuildingController.isLoadComplete
                                  .value
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // ignore: invalid_use_of_protected_member
                                  children:
                                      widget.rapportBuildingController.moods
                                          .map(
                                            (mood) => emotionSelector(
                                              mood.moodName.toLowerCase(),
                                              () async {
                                                //TODO ADD THE RATE USECASE IN HOME-CONTROLLER TOO
                                                //TODO and then implement similiar method for fulfilling the action
                                                await widget.homeController
                                                    .fulfillActionStatus(
                                                  mood: mood.moodName,
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
                        SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 38,
                          ).value,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await widget.homeController.changeActionStatus(
                              actionStatus: ActionStatus.SCHEDULED_BUT_NOT_DONE,
                            );
                          },
                          child: Text(
                            'Or maybe you couldn’t',
                            style: AppTextStyle.hintStyleDarkerForTextInputs
                                .copyWith(
                              decoration: TextDecoration.underline,
                            ),
                            textAlign: TextAlign.center,
                            textScaleFactor: textScale,
                          ),
                        ),
                        SizedBox(
                          height: ScaleManager.spaceScale(
                            spaceing: 33,
                          ).value,
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
