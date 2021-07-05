import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../controller/profile-controller.dart';
import 'bottom-sheet.dart';

class PiChart extends GetWidget<ProfileController> {
  final List<WOLAreaData> chartData;

  const PiChart({
    required this.chartData,
  });
  @override
  Widget build(BuildContext context) {
    double sumOfValue() {
      double sum = 0.0;
      for (int i = 0; i < chartData.length; i++) {
        sum += chartData[i].y;
      }
      return sum;
    }

    List<CircularChartAnnotation> getannoation() {
      final List<CircularChartAnnotation> label = [];
      final contentLength = chartData.length;
      final totalSum = sumOfValue();
      double yupto = 0;
      for (int i = 0; i < contentLength; i++) {
        yupto += chartData[i].y;
        final int assignedAngle =
            ((((yupto - (chartData[i].y / 2)) / totalSum) * 360) - 90).toInt();
        label.add(CircularChartAnnotation(
          angle: assignedAngle,
          radius: '40%',
          widget: InkWell(
            onTap: () {
              log("hello");
            },
            child: Image.asset(
              'assets/profile-icon/user-image.png',
              height: ScaleManager.spaceScale(
                spaceing: 29,
              ).value,
            ),
          ),
        ));
      }
      return label;
    }

    return Obx(
      () => SfCircularChart(
        // borderWidth: 2,
        annotations: getannoation(),
        series: <CircularSeries>[
          // Render pie chart
          DoughnutSeries<WOLAreaData, String>(
            dataSource: chartData,
            pointColorMapper: (WOLAreaData data, _) => data.color,
            xValueMapper: (WOLAreaData data, _) => data.x,
            yValueMapper: (WOLAreaData data, _) => data.y,
            innerRadius: '65%',
            explode: true,
            explodeAll: true,
            explodeOffset: '2%',
            explodeGesture: ActivationMode.none,
            enableSmartLabels: true,
            dataLabelSettings: DataLabelSettings(
              //  isVisible: true,
              labelAlignment: ChartDataLabelAlignment.bottom,
            ),
            // dataLabelMapper: (ChartData data, _) => data.x,
            // explodeAll: true,
          ),
        ],
      ),
    );
  }
}

class WOLAreaData {
  WOLAreaData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}
