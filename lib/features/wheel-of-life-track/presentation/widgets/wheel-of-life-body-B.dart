// Flutter imports:
// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/universal-widgets/textfield.dart';
import '../controllers/wheel-of-life-controller.dart';
import 're-orderable-ListItem.dart';

class WheelOfLifeBodyB extends StatefulWidget {
  final WheelOfLifeController controller;
  const WheelOfLifeBodyB({Key key, @required this.controller})
      : super(key: key);
  @override
  _WheelOfLifeBodyBState createState() => _WheelOfLifeBodyBState();
}

class _WheelOfLifeBodyBState extends State<WheelOfLifeBodyB> {
  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        // ignore: parameter_assignments
        newindex -= 1;
      }
      final items = widget.controller.lifeAreas.removeAt(oldindex);
      widget.controller.lifeAreas.insert(newindex, items);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          child: Column(
            children: [
              Text(
                tr('wol priority title'),
                style: AppTextStyle.titleLM,
                textScaleFactor: textScaleFactor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: widget.controller.toggleInformation,
                      child: SvgPicture.asset(ImagePath.connectionStatus))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ScaleManager.spaceScale(
                    spaceing: 9,
                  ).value,
                ),
                child: Obx(
                  () => FlipCard(
                    flipOnTouch: false,
                    key: widget.controller.cardKey1,
                    back: SizedBox(
                      width: Get.width,
                      height: widget.controller.lifeAreas.length *
                          ScaleManager.spaceScale(
                            spaceing: 65.0,
                          ).value,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 8,
                        itemBuilder: (BuildContext context, int index) {
                          final lifeArea = widget.controller.lifeAreas[index];
                          return WheelOfLifeAreaHolder(
                            title: lifeArea.name,
                            subtitle: lifeArea.description,
                          );
                        },
                      ),
                    ),
                    front: SizedBox(
                      width: Get.width,
                      height: widget.controller.lifeAreas.length *
                          ScaleManager.spaceScale(
                            spaceing: 65.0,
                          ).value,
                      child: Theme(
                        data: ThemeData(
                          scaffoldBackgroundColor: Colors.transparent,
                          canvasColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          dialogBackgroundColor: Colors.transparent,
                        ),
                        child: SingleTouchRecognizerWidget(
                          child: ReorderableListView(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            clipBehavior: Clip.antiAlias,
                            onReorder: reorderData,
                            children: <Widget>[
                              for (final lifeArea
                                  in widget.controller.lifeAreas)
                                reorderableListItem(lifeArea.name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleTouchRecognizerWidget extends StatelessWidget {
  final Widget child;
  const SingleTouchRecognizerWidget({this.child});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        _SingleTouchRecognizer:
            GestureRecognizerFactoryWithHandlers<_SingleTouchRecognizer>(
                () => _SingleTouchRecognizer(),
                (_SingleTouchRecognizer instance) {}),
      },
      child: child,
    );
  }
}

class _SingleTouchRecognizer extends OneSequenceGestureRecognizer {
  int _p = 0;
  @override
  void addAllowedPointer(PointerDownEvent event) {
    startTrackingPointer(event.pointer);
    if (_p == 0) {
      resolve(GestureDisposition.rejected);
      _p = event.pointer;
    } else {
      resolve(GestureDisposition.accepted);
    }
  }

  @override
  void didStopTrackingLastPointer(int pointer) {}
  @override
  void handleEvent(PointerEvent event) {
    if (!event.down && event.pointer == _p) {
      _p = 0;
    }
  }

  @override
  String get debugDescription => throw UnimplementedError();
}
