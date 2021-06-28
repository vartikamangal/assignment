// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/controller/profile-controller.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/utils/universal-widgets/empty-space.dart';

Widget DropDownBtn({
  String label,
  ProfileController controller,
  Callback onPressed,
  bool isExpanded,
  Color color,

}) {
  final textScaleFactor = ScaleManager.textScale.value;
  List<String> options=<String>['select','Male','Female'];
  return isExpanded
      ? SizedBox(
    width: ScaleManager.spaceScale(spaceing: 151).value,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < options.length; i++)
                GestureDetector(
                  // ignore: void_checks
                  onTap: () {
                    ///have set gender
                    controller.toggleDropDownExpansion();
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
                            spaceing: i == options.length - 1 ? 14 : 6,
                          ).value,
                          left: ScaleManager.spaceScale(
                            spaceing: 21,
                          ).value,
                          right: ScaleManager.spaceScale(
                            spaceing: 12,
                          ).value,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                options[i]
                                    .toUpperCase(),
                                style:
                                AppTextStyle.dropDownStyle.copyWith(
                                  fontSize: 14,
                                ),
                                textScaleFactor: textScaleFactor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (i == 0)
                        const Divider(
                          color: Colors.transparent,
                        )
                      else if (i <= options.length - 2)
                        const Divider(
                          color: Colors.white,
                        )
                      else
                        EmptySpacePlaceHolder(),
                    ],
                  ),
                ),
            ],
          ),
        ),
        _DropDownTopHeader(
          textScaleFactor: textScaleFactor,
          color: color,
          onTap: onPressed,
          label: label,
          isExpanded: isExpanded,
        ),
      ],
    ),
  )
      : _DropDownTopHeader(
    textScaleFactor: textScaleFactor,
    color: color,
    onTap: onPressed,
    isExpanded: isExpanded,
    label: label,
  );
}

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