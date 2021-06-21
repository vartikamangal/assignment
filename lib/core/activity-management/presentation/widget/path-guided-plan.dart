// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

// Project imports:
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../../../../core/routes/app-routes/app-routes.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../controller/path-controller.dart';
import 'plan-container.dart';

// ignore: must_be_immutable
class PathGuidedPlan extends StatelessWidget {
  final PathController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final textScaleFactor = ScaleManager.textScale.value;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: blueDarkShade,
              size: ScaleManager.spaceScale(spaceing: 26).value,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: ScaleManager.spaceScale(spaceing: 29).value,
            right: ScaleManager.spaceScale(spaceing: 29).value,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: ScaleManager.spaceScale(
                          spaceing: 10 
                        ).value,
                      ),
                      child: Text(
                        tr(
                          'your plan',
                        ),
                        style: AppTextStyle.Askfeeling,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                    Text(
                      tr('practice divided'),
                      style: AppTextStyle.pathdescription,
                      textScaleFactor: textScaleFactor,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScaleManager.spaceScale(
                          spaceing: 13,
                        ).value,
                      ),
                      child: Text(
                        tr('pick a day'),
                        style: AppTextStyle.actiontoperform,
                        textScaleFactor: textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  top: ScaleManager.spaceScale(
                    spaceing: 22,
                  ).value,
                ),
                sliver: SliverToBoxAdapter(
                  child: Obx(
                    () => _controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: _buildPlan(),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<PlanContainer> _buildPlan() {
    final List<PlanContainer> _plans = [];
    for (final planItem in _controller.guidedPlan.value.activitySchedule) {
      _plans.add(
        PlanContainer(
          requireBottomSpacing: true,
          title: planItem.title,
          description: planItem.dayNumber == 1 ? planItem.subtitle : '',
          image: '${ImagePath.guidedOption}day 2.png',
          // ignore: avoid_bool_literals_in_conditional_expressions
          isFaded: planItem.dayNumber == 1 ? false : true,
          onPressed: () {
            _controller.selectDay = planItem;
            Get.toNamed(RouteName.guidedPathPlanInside);
          },
        ),
      );
    }
    return _plans;
  }
}
