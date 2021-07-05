import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/asset-image-path/image-path.dart';
import '../../../../core/utils/app-text-style-components/app-text-styles.dart';
import '../../../../core/utils/color-pallete.dart';
import '../../../../core/responsive/scale-manager.dart';
import '../controller/profile-controller.dart';

class LinearChart extends StatefulWidget {
  @override
  _LinearChartState createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart> {
  final textScaleFactor = ScaleManager.textScale.value;
  final imageScaleFactor = ScaleManager.imageScale.value;
  final ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: ScaleManager.spaceScale(
                spaceing: 15,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
              child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 19,
                ).value,
                child: Image.asset(
                  ImagePath.happyEmoji,
                  scale: imageScaleFactor,
                ),
              ),
            ),
            Positioned(
              top: ScaleManager.spaceScale(
                spaceing: 105,
              ).value,
              right: ScaleManager.spaceScale(
                spaceing: 20,
              ).value,
              child: SizedBox(
                height: ScaleManager.spaceScale(
                  spaceing: 19,
                ).value,
                child: Image.asset(
                  ImagePath.sadEmoji,
                  scale: imageScaleFactor,
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                accentColor: Theme.of(context).canvasColor.withOpacity(0.3),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: ScaleManager.spaceScale(
                      spaceing: 25,
                    ).value,
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: ScaleManager.spaceScale(
                              spaceing: 360,
                            ).value,
                            //TODO calculation for max width
                            // (At place charData[5] we have to put number of days)
                            maxWidth: _profileController.linearChartData.length<10
                                ?
                            ScaleManager.spaceScale(
                              spaceing: 360,
                            ).value
                                :ScaleManager.spaceScale(
                                  spaceing: 360,
                                ).value +
                                ScaleManager.spaceScale(
                                      spaceing: 40,
                                    ).value *
                                    (_profileController.linearChartData.length-10),
                          ),
                          child: SfCartesianChart(
                            enableAxisAnimation: true,
                            onAxisLabelRender: (AxisLabelRenderArgs args) {
                              if (args.axisName == 'primaryXAxis') {
                                args.textStyle =
                                    AppTextStyle.hintStyleXS.copyWith(
                                        fontSize: ScaleManager.spaceScale(
                                  spaceing: 14,
                                ).value);
                              } else {
                                final TextStyle textStyle = args.textStyle;
                                args.textStyle = textStyle.copyWith(
                                  color: Colors.transparent,
                                );
                              }
                            },
                            //on desired interval place we have to write days count
                            primaryXAxis: NumericAxis(
                              desiredIntervals: 10,
                              majorGridLines: const MajorGridLines(width: 0),
                              interval: 1,
                              axisLine: AxisLine(color: blueDarkerShade),
                              majorTickLines: MajorTickLines(
                                size: ScaleManager.spaceScale(
                                  spaceing: 7,
                                ).value,
                                color: blueDarkerShade,
                              ),
                            ),
                            primaryYAxis: NumericAxis(
                              minimum: 0,
                              maximum: 7,
                              majorGridLines: const MajorGridLines(
                                dashArray: <double>[7, 7],
                              ),
                              opposedPosition: true,
                              interval: 1,
                              axisLine: const AxisLine(
                                color: Colors.white,
                              ),
                            ),
                            axes: <ChartAxis>[
                              NumericAxis(
                                  name: 'YAxis',
                                  opposedPosition: true,
                                  interval: 1)
                            ],
                            series: <LineSeries<ChartData, double>>[
                              LineSeries<ChartData, double>(
                                color: blueLightShade,
                                dataSource: _profileController.linearChartData,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final double x;
  final double? y;
}
