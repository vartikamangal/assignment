import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tatsam_app_experimental/core/responsive/scale-manager.dart';
import 'package:tatsam_app_experimental/core/utils/color-pallete.dart';
import 'package:tatsam_app_experimental/features/profile-screen/presentation/widget/bottom-sheet.dart';


class PiChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<WOLAreaData> chartData = [
      WOLAreaData('A', 4, blueLightShade),
      WOLAreaData('B', 3, blueDarkShade),
      WOLAreaData('E', 1.5, blueDarkerShade),
      WOLAreaData('F', 3, blueDarkShade),
      WOLAreaData('G', 2, blueDarkerShade),
    ];
    final length=chartData.length;

    double sumOfValue(int length){
      double sum=0.0;
      for(int i=0;i<length;i++){
        sum+=chartData[i].y;
      }
      return sum;
    }

    List<CircularChartAnnotation> getannoation(int length){
      List<CircularChartAnnotation> label=[];
      double yupto=0;
      for(int i=0;i<length;i++){
        yupto+=chartData[i].y;
        int assignedAngle =((((yupto-(chartData[i].y/2))/sumOfValue(length))*360)-90).toInt();
        label.add(CircularChartAnnotation(
          angle: assignedAngle,
          radius:'40%',
          widget: Container(
            child: InkWell(
              onTap: (){print("hello");},
              child: Image.asset('assets/profile-icon/user-image.png',height: ScaleManager.spaceScale(
                spaceing: 29,
              ).value,),
            ),
          ),
        ));
      }
      return label;
    }
    return  GestureDetector(
      onTap: (){
        print("SfCircularChart");
      },
      child: SfCircularChart(
        onPointTapped: (x){
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) =>  InfoBottomSheet(
                selectedArea: x.pointIndex.toString(),
                description: 'Your best self can only happen when you have access to  growth in different areas o',
              ));
        },
        // borderWidth: 2,
        annotations: getannoation(length),
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
                labelAlignment: ChartDataLabelAlignment.bottom),
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
  final Color color;
}