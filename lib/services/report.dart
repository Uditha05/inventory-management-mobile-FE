import 'dart:math';

import 'package:inventory_management/services/excel.dart';
import 'package:inventory_management/widget/chart.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart'
    as api;

class Report {
  DateTime fromdate;
  DateTime toDate;
  List categories;
  List<ChartData> report;
  String reportType;
  Report({this.fromdate, this.toDate, this.categories, this.reportType});

  Future<List<ChartData>> getReport() async {
    List<ChartData> lis =
        await api.getReport(fromdate, toDate, categories, reportType);
    print(lis);
    // for (var i = fromdate.day.toInt(); i < toDate.day.toInt() + 1; i++) {
    //   List data = [];
    //   for (var j = 0; j < categories.length; j++) {
    //     data.add([categories[j], Random().nextInt(20)]);
    //   }
    //   lis.add(ChartData(fromdate.month.toString() + '/' + i.toString(), data));
    // }
    report = lis;
    return lis;
  }

  Future<String> generateXL() async {
    String path = await Excel.generateExcel(report);
    return path;
  }
}
