import 'package:NudgeBuddy/controllers/stats.dart';
import 'package:NudgeBuddy/services/nutrients.dart';
import 'package:NudgeBuddy/services/stats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Chart import
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../utils/size_config.dart';

/// Renders the inversed numeric axis chart for both calorie and weight tracking.
class Graph extends StatefulWidget {
  /// Creates the inversed numeric axis sample.
  const Graph(Key? key, this.color, this.dataList, this.maxVal, this.interval)
      : super(key: key);
  final Color color;
  final int interval;
  final double maxVal;
  final List<ChartSampleData> dataList;
  @override
  _GraphState createState() => _GraphState();
}

/// State class of the inversed numeric axis.
class _GraphState extends State<Graph> {
  _GraphState();
  
  @override
  void initState() {
    isYInversed = true;
    isXInversed = true;
    
    super.initState();
  }

  bool? isYInversed, isXInversed;
  final cont = Get.find<StatsCont>();
  final dateFormat = DateFormat('dd MMMM');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.heightMultiplier * 1,
            vertical: SizeConfig.heightMultiplier * 2),
        decoration: BoxDecoration(
            color: widget.color.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
            width: SizeConfig.widthMultiplier * 100,
            child: Column(
              children: [
                SizedBox(
                    height: SizeConfig.heightMultiplier * 25,
                    child: _buildChart()),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.widthMultiplier * 7,
                      right: SizeConfig.widthMultiplier * 2),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            dateFormat.format(
                                StatsService.getFirstAndLastDatesOfMonth(
                                    DateTime.parse(
                                        cont.selectedDate.value))[0]),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500)),
                        Text(
                            dateFormat.format(
                                StatsService.getFirstAndLastDatesOfMonth(
                                    DateTime.parse(
                                        cont.selectedDate.value))[1]),
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  /// Returns the Cartesian chart with inversed x and y axis.
  /// Can change the isInversed bool value by toggle the custom button
  /// presented in property panel.
  SfCartesianChart _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      // borderWidth: 2,cr

      title: ChartTitle(
        text: '',
      ),
      primaryXAxis: NumericAxis(
          minimum: 1,
          maximum: 30,
          labelStyle: const TextStyle(fontSize: 12, color: Colors.black),
          majorGridLines: const MajorGridLines(width: 1, color: Colors.black12),
          majorTickLines: const MajorTickLines(
            width: 0,
          ),
          opposedPosition: false,
          isInversed: false,
          edgeLabelPlacement: EdgeLabelPlacement.none,
          interval: 1),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: widget.maxVal,
          majorGridLines: const MajorGridLines(width: 0.8),
          labelStyle: const TextStyle(
              fontSize: 14, color: Colors.black, fontFamily: 'Poppins'),
          numberFormat: NumberFormat.decimalPattern(),
          axisLine: const AxisLine(width: 0),
          interval: widget.interval.toDouble(),
          majorTickLines: const MajorTickLines(size: 0)),
      series: getInversedNumericSeries(),
      //Hover box
      tooltipBehavior: TooltipBehavior(
        enable: true,
        builder: (data, point, series, pointIndex, seriesIndex) {
          return Container(
            height: SizeConfig.heightMultiplier * 3,
            width: SizeConfig.widthMultiplier * 14,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(6)
            ),
            child: Center(child: Text(data.xValue.toString()+' : '+ data.yValue.toString(),style: TextStyle(fontSize: SizeConfig.textMultiplier*1.3,fontWeight: FontWeight.w500,color: Colors.white),)),
          );
        },
      ),
    );
  }

  /// Returns the list of Chart series
  /// which need to render on the inversed numeric axis.
  List<LineSeries<ChartSampleData, num>> getInversedNumericSeries() {
    return <LineSeries<ChartSampleData, num>>[
      LineSeries<ChartSampleData, num>(
          dataSource: widget.dataList,
          xValueMapper: (ChartSampleData sales, _) => sales.xValue,
          yValueMapper: (ChartSampleData sales, _) => sales.yValue,
          width: 2,
          color: widget.color,
          markerSettings: MarkerSettings(
              isVisible: true,
              borderColor: widget.color,
              height: 7,
              width: 8,
              color: widget.color))
    ];
  }
}

class ChartSampleData {
  ChartSampleData(this.xValue, this.yValue);
  final num xValue;
  final num yValue;
}
