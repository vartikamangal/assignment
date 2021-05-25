
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tatsam_app_experimental/core/utils/universal-widgets/textfield.dart';
import '../../../../core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import '../../../../core/utils/animations/fade-animation-y-axis.dart.dart';
import '../controllers/wheel-of-life-controller.dart';
import 'package:flip_card/flip_card.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/features/wheel-of-life-track/presentation/widgets/re-orderable-ListItem.dart';

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
    return FadeAnimationYAxis(
      0.4,
      Stack(
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
                Padding(
                  padding: EdgeInsets.only(
                      top: ScaleManager.spaceScale(
                        spaceing: 35,
                      ).value,
                      bottom: ScaleManager.spaceScale(
                        spaceing: 35,
                      ).value),
                  child: SizedBox(
                    width: Get.width,
                    height: Get.height * 0.7,
                    child: Obx(
                          () =>FlipCard(
                        flipOnTouch: false,
                        key: widget.controller.cardKey,
                        direction: FlipDirection.HORIZONTAL,
                        back: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: 8,
                          itemBuilder: (BuildContext context, int index) {
                            final lifeArea = widget.controller.lifeAreas[index];
                            return WheelOfLifeAreaHolder(
                              title: lifeArea.name,
                              subtitle: lifeArea.description,
                            );
                          },
                        ),
                        front:ReorderableListView(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          clipBehavior: Clip.antiAlias,
                          onReorder: reorderData,
                          children: <Widget>[
                            for (final lifeArea in widget.controller.lifeAreas)
                              reorderableListItem(lifeArea.name),
                          ],
                        ) ,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              right: Get.width * 0.075,
              top: 55,
              child: SizedBox(
                  height: ScaleManager.spaceScale(
                    spaceing: 29.8,
                  ).value,
                  width: ScaleManager.spaceScale(
                    spaceing: 29.8,
                  ).value,
                  child: GestureDetector(
                      onTap: widget.controller.toggleInformation,
                      child: SvgPicture.asset(ImagePath.connectionStatus))))
        ],
      ),
    );
  }
}

