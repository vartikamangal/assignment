
// Flutter imports:
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/core/utils/animations/fade-animation-y-axis.dart.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';
import '../../data/models/question-model.dart';
import '../../data/models/question-option-model.dart';
import '../controller/question-controller.dart';

class dropDownAssistor extends StatefulWidget  {
  const dropDownAssistor({
    Key key,
    @required this.options,
    @required this.color,
    @required this.conroller,
    @required this.isExpanded,
    @required this.onTap,
    @required this.questionIdModel,
    @required this.label,
  }) : super(key: key);

  final String label;
  //TODO change this logic to a cleaner way in future
  // must pass to make onOptionPressed work
  final   List<String> options;
  final bool isExpanded;
  final   Color color;
  final Callback onTap;
  final   QuestionnaireConroller conroller;
  final QuestionModel questionIdModel;

  @override
  _dropDownAssistorState createState() => _dropDownAssistorState();
}

class _dropDownAssistorState extends State<dropDownAssistor> with TickerProviderStateMixin  {
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return  AnimatedSizeAndFade(
        vsync: this,
        fadeDuration: const Duration(milliseconds: 50),
        sizeDuration: const Duration(milliseconds: 600),
        child: !widget.isExpanded
            ?_DropDownTopHeader(
          textScaleFactor: textScaleFactor,
          color: widget.color,
          onTap: widget.onTap,
          isExpanded: widget.isExpanded,
          label: widget.label,
        ):SizedBox(
          width: ScaleManager.spaceScale(spaceing: 151).value,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              FadeAnimationYAxis(
                0.4, Container(
                decoration: BoxDecoration(
                  color: blueLightShade,
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
                child: Obx(
                      () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      for (int i = 0; i < widget.options.length + 1; i++)
                        i == 0
                            ? Padding(
                          padding: EdgeInsets.only(
                            top: ScaleManager.spaceScale(
                              spaceing: 36,
                            ).value,
                            bottom: ScaleManager.spaceScale(
                              spaceing: i == widget.options.length ? 14 : 6,
                            ).value,
                            left: ScaleManager.spaceScale(
                              spaceing: 21,
                            ).value,
                            right: ScaleManager.spaceScale(
                              spaceing: 12,
                            ).value,
                          ),
                          child: EmptySpacePlaceHolder(),
                        )
                            : GestureDetector(
                          // ignore: void_checks
                          onTap: () {
                            widget.conroller.answerMcqTypeQuestion(
                              questionModel: widget.questionIdModel,
                              optionSelected:
                              widget.questionIdModel.questionOptionVO[i - 1]
                              as QuestionOptionModel,
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScaleManager.spaceScale(
                                    spaceing: 6,
                                  ).value,
                                  bottom: ScaleManager.spaceScale(
                                    spaceing:
                                    i == widget.options.length - 1 ? 14 : 6,
                                  ).value,
                                  left: ScaleManager.spaceScale(
                                    spaceing: 21,
                                  ).value,
                                  right: ScaleManager.spaceScale(
                                    spaceing: 12,
                                  ).value,
                                ),
                                child: Text(
                                  widget.options[i - 1],
                                  style: AppTextStyle.dropDownStyle.copyWith(
                                    fontSize: 14,
                                  ),
                                  textScaleFactor: textScaleFactor,
                                ),
                              ),
                              if (i == 0)
                                const Divider(
                                  color: Colors.transparent,
                                )
                              else if (i < widget.options.length)
                                const Divider(
                                  color: Colors.white,
                                )
                              else
                                EmptySpacePlaceHolder(),
                              if (i == widget.options.length)
                                SizedBox(
                                  height:
                                  ScaleManager.spaceScale(spaceing: 18)
                                      .value,
                                )
                              else
                                EmptySpacePlaceHolder(),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              ),
              _DropDownTopHeader(
                textScaleFactor: textScaleFactor,
                color: widget.color,
                onTap: widget.onTap,
                label: widget.label,
                isExpanded: widget.isExpanded,
              ),
            ],
          ),
        )
    );
  }
}

/*

Widget dropDownAssistor({
  String label,
  //TODO change this logic to a cleaner way in future
  // must pass to make onOptionPressed work
  List<String> options,
  bool isExpanded,
  Color color,
  Callback onTap,
  QuestionnaireConroller conroller,
  QuestionModel questionIdModel,
}) {
  final textScaleFactor = ScaleManager.textScale.value;
  return AnimatedSwitcher(duration: const Duration(milliseconds: 800),
    reverseDuration: const Duration(milliseconds: 400),
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    transitionBuilder: (Widget child, Animation<double> animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: child,
      );
    },
  child: !isExpanded
      ?_DropDownTopHeader(
    textScaleFactor: textScaleFactor,
    color: color,
    onTap: onTap,
    isExpanded: isExpanded,
    label: label,
  ):SizedBox(
    width: ScaleManager.spaceScale(spaceing: 151).value,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        FadeAnimationYAxis(
          0.4, Container(
            decoration: BoxDecoration(
              color: blueLightShade,
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
            child: Obx(
                  () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < options.length + 1; i++)
                    i == 0
                        ? Padding(
                      padding: EdgeInsets.only(
                        top: ScaleManager.spaceScale(
                          spaceing: 36,
                        ).value,
                        bottom: ScaleManager.spaceScale(
                          spaceing: i == options.length ? 14 : 6,
                        ).value,
                        left: ScaleManager.spaceScale(
                          spaceing: 21,
                        ).value,
                        right: ScaleManager.spaceScale(
                          spaceing: 12,
                        ).value,
                      ),
                      child: EmptySpacePlaceHolder(),
                    )
                        : GestureDetector(
                      // ignore: void_checks
                      onTap: () {
                        conroller.answerMcqTypeQuestion(
                          questionModel: questionIdModel,
                          optionSelected:
                          questionIdModel.questionOptionVO[i - 1]
                          as QuestionOptionModel,
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: ScaleManager.spaceScale(
                                spaceing: 6,
                              ).value,
                              bottom: ScaleManager.spaceScale(
                                spaceing:
                                i == options.length - 1 ? 14 : 6,
                              ).value,
                              left: ScaleManager.spaceScale(
                                spaceing: 21,
                              ).value,
                              right: ScaleManager.spaceScale(
                                spaceing: 12,
                              ).value,
                            ),
                            child: Text(
                              options[i - 1],
                              style: AppTextStyle.dropDownStyle.copyWith(
                                fontSize: 14,
                              ),
                              textScaleFactor: textScaleFactor,
                            ),
                          ),
                          if (i == 0)
                            const Divider(
                              color: Colors.transparent,
                            )
                          else if (i < options.length)
                            const Divider(
                              color: Colors.white,
                            )
                          else
                            EmptySpacePlaceHolder(),
                          if (i == options.length)
                            SizedBox(
                              height:
                              ScaleManager.spaceScale(spaceing: 18)
                                  .value,
                            )
                          else
                            EmptySpacePlaceHolder(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        _DropDownTopHeader(
          textScaleFactor: textScaleFactor,
          color: color,
          onTap: onTap,
          label: label,
          isExpanded: isExpanded,
        ),
      ],
    ),
  )
  );

}
*/

// Persistent Dropdown header
class _DropDownTopHeader extends StatelessWidget {
  const _DropDownTopHeader({
    Key key,
    @required this.textScaleFactor,
    @required this.color,
    @required this.label,
    @required this.isExpanded,
    @required this.onTap,
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
