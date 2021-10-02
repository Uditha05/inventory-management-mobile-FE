import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chrartless extends StatelessWidget {
  final type;
  final fromdate;
  final todate;
  final chartData;
  const Chrartless(
      {Key key, this.type, this.fromdate, this.todate, this.chartData})
      : super(key: key);

  List<ChartSeries> setChartdata(List<ChartData> chartData) {
    List<ChartSeries> lis = [];
    if (chartData.length > 0) {
      for (var i = 0; i < chartData[0].data.length; i++) {
        
        lis.add(type == 'Column Chart'
            ? StackedColumnSeries<ChartData, String>(
                dataSource: chartData,
                xValueMapper: (ChartData sales, _) => sales.x,
                yValueMapper: (ChartData sales, _) => sales.data[i][1],
                name: chartData[0].data[i][0],
              )
            : type == 'Bar Chart'
                ? StackedBarSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData sales, _) => sales.x,
                    yValueMapper: (ChartData sales, _) => sales.data[i][1],
                    name: chartData[0].data[i][0],
                  )
                : type == 'Line Chart'
                    ? LineSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData sales, _) => sales.x,
                        yValueMapper: (ChartData sales, _) => sales.data[i][1],
                        name: chartData[0].data[i][0],
                      )
                    : StackedLineSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData sales, _) => sales.x,
                        yValueMapper: (ChartData sales, _) => sales.data[i][1],
                        name: chartData[0].data[i][0],
                      ));
      }
    }
    return (lis);
  }

  @override
  Widget build(BuildContext context) {
    TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);
    return SfCartesianChart(
        title: ChartTitle(text: 'Usage Report'),
        zoomPanBehavior: ZoomPanBehavior(
            enableDoubleTapZooming: false,
            enablePanning: true,
            enablePinching: true,
            enableMouseWheelZooming: false),
        primaryXAxis: CategoryAxis(),
        legend: Legend(isVisible: true, position: LegendPosition.bottom),
        tooltipBehavior: tooltipBehavior,
        series: setChartdata(chartData).toList());
  }
}

class ChartData {
  ChartData(this.x, this.data);
  final String x;
  final List data;
}
