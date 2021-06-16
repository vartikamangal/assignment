// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../controller/focus-screen-controller.dart';

class SelectedIssueDetails extends StatelessWidget {
  final FocusController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    final imageScaleFactor = ScaleManager.imageScale.value;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: ScaleManager.spaceScale(
                spaceing: 152,
              ).value,
            ),
            Align(
              child: AnimatedSwitcher(
                duration:const Duration(milliseconds: 500),
                switchInCurve: Curves.easeIn,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Hero(
                      tag: _controller.selectedIssueImage,
                      child: SizedBox(
                        height: ScaleManager.spaceScale(
                          spaceing: 274,
                        ).value,
                        width: ScaleManager.spaceScale(
                          spaceing: 274,
                        ).value,
                        child: Image.asset(
                          _controller.selectedIssueImage,
                          scale: imageScaleFactor,
                        ),
                      ),
                    ),
                    Text(
                      _controller.selectedIssue.value.displayName,
                      style: AppTextStyle.lightblueheader.copyWith(
                        fontSize: 24,
                        height: 2.6,
                      ),
                      textScaleFactor: textScaleFactor,
                    ),
                    SizedBox(
                      height: ScaleManager.spaceScale(
                        spaceing: 12,
                      ).value,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScaleManager.spaceScale(
                          spaceing: 60,
                        ).value,
                      ),
                      child: Text(
                        _controller.selectedIssue.value.messageOnSelection,
                        style: AppTextStyle.descriptiontext.copyWith(
                          fontSize: 17,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
