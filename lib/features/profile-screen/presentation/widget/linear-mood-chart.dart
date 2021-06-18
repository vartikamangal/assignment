import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tatsam_app_experimental/core/asset-image-path/image-path.dart';
import 'package:tatsam_app_experimental/core/utils/app-text-style-components/app-text-styles.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';

class LinearChart extends StatefulWidget {
  @override
  _LinearChartState createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart> {
  final textScaleFactor = ScaleManager.textScale.value;
  final imageScaleFactor = ScaleManager.imageScale.value;
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData(1, 1,),
      ChartData(10, 1,),
      ChartData(21, 2,),
      ChartData(30, 5,),
      ChartData(40, 6,),
      ChartData(50, 1,)
    ];
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
                        height:ScaleManager.spaceScale(
                          spaceing: 19,
                        ).value,
                        child: Image.asset(ImagePath.happyEmoji,scale: imageScaleFactor,))),

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
                          child: Image.asset(ImagePath.sadEmoji,scale: imageScaleFactor,))),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Padding(
                    padding:  EdgeInsets.only(right: ScaleManager.spaceScale(
                      spaceing: 25,
                    ).value),
                    child: Stack(
                      children: [
                        Positioned(
                          child: Container(
                              constraints: BoxConstraints(
                                  minWidth: ScaleManager.spaceScale(
                                    spaceing: 370,
                                  ).value,
                                  //TODO calculation for max width
                                  // (At place charData[5] we have to put number of days)
                                  maxWidth: ScaleManager.spaceScale(
                                    spaceing: 370,
                                  ).value+ ScaleManager.spaceScale(
                                    spaceing: 10,
                                  ).value*chartData[5].x.toDouble()
                              ),
                              child:  SfCartesianChart(
                                  enableAxisAnimation: true,
                                  borderColor: Colors.transparent,
                                  onAxisLabelRender: (AxisLabelRenderArgs args) {
                                    if (args.axisName == 'primaryXAxis') {
                                      TextStyle textStyle = args.textStyle;
                                      args.textStyle =  AppTextStyle.hintStyleXS.copyWith(fontSize: ScaleManager.spaceScale(
                                        spaceing: 14,
                                      ).value);}
                                    else{
                                      TextStyle textStyle = args.textStyle;
                                      args.textStyle =  textStyle.copyWith(color: Colors.transparent);
                                    }
                                  },
                                  //on desired interval place we have to write days count
                                  primaryXAxis: NumericAxis(desiredIntervals:10,
                                      majorGridLines: MajorGridLines(width: 0),
                                      interval: 1,
                                      axisLine: AxisLine(color: blueDarkerShade),
                                    majorTickLines: MajorTickLines(size:  ScaleManager.spaceScale(
                                      spaceing: 7,
                                    ).value, width: 1, color: blueDarkerShade),),
                                  primaryYAxis: NumericAxis(minimum: 0, maximum: 7,
                                      majorGridLines: MajorGridLines(dashArray: <double>[7, 7],),
                                      opposedPosition: true,
                                  interval: 1, axisLine: AxisLine(color: Colors.white)),
                                  axes: <ChartAxis>[
                                    NumericAxis(name: 'YAxis', opposedPosition: true,interval: 1)
                                  ],
                                  series: <LineSeries<ChartData, double>>[
                                    LineSeries<ChartData, double>(
                                        color: blueLightShade,
                                        dataSource: chartData,
                                        xValueMapper: (ChartData data, _) => data.x,
                                        yValueMapper: (ChartData data, _) => data.y
                                    ),
                                  ]
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y,);
  final double x;
  final double y;
}