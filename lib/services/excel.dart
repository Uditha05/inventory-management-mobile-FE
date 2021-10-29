import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management/widget/chart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column, Alignment;

/// Represents the XlsIO widget class.
class Excel {
  static Future<String> generateExcel(List<ChartData> report) async {
    //Create a Excel document.

    //Creating a workbook.
    final Workbook workbook = Workbook();
    //Accessing via index
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

    // Enable calculation for worksheet.
    sheet.enableSheetCalculations();
    sheet.getRangeByName('A1').setText('Report');
    sheet.getRangeByName('A1').cellStyle.fontSize = 32;
    sheet.getRangeByName('A1').cellStyle.bold = true;
    sheet.getRangeByName('A1:C4').merge();

    sheet.getRangeByIndex(8, 1).setText('Date');
    sheet.getRangeByIndex(8, 1).cellStyle.bold = true;

    sheet.getRangeByIndex(9 + report.length, 1).setText('Total');
    sheet.getRangeByIndex(9 + report.length, 1).cellStyle.bold = true;

    sheet.getRangeByIndex(8, 2 + report[0].data.length).setText('Total');
    sheet.getRangeByIndex(8, 2 + report[0].data.length).cellStyle.bold = true;

    for (var i = 0; i < report.length; i++) {
      sheet.getRangeByIndex(9 + i, 1).setText(report[i].x);
      for (var j = 0; j < report[i].data.length; j++) {
        if (i == 0) {
          sheet.getRangeByIndex(8, 2 + j).setText(report[i].data[j][0]);
          sheet.getRangeByIndex(8, 2 + j).cellStyle.bold = true;
        }
        sheet
            .getRangeByIndex(9 + i, 2 + j)
            .setNumber(report[i].data[j][1].toDouble());
      }

      String start = sheet
          .getRangeByIndex(9 + i, 2)
          .addressGlobal
          .split('!')[1]
          .replaceAll(new RegExp(r'[^\w\s]+'), '');
      String end = sheet
          .getRangeByIndex(9 + i, 1 + report[i].data.length)
          .addressGlobal
          .split('!')[1]
          .replaceAll(new RegExp(r'[^\w\s]+'), '');
      print('=SUM($start:$end)');
      sheet
          .getRangeByIndex(9 + i, 2 + report[i].data.length)
          .setFormula('=SUM($start:$end)');
    }

    for (var j = 0; j < report[0].data.length; j++) {
      String start = sheet
          .getRangeByIndex(9, 2 + j)
          .addressGlobal
          .split('!')[1]
          .replaceAll(new RegExp(r'[^\w\s]+'), '');
      String end = sheet
          .getRangeByIndex(8 + report.length, 2 + j)
          .addressGlobal
          .split('!')[1]
          .replaceAll(new RegExp(r'[^\w\s]+'), '');

      sheet
          .getRangeByIndex(9 + report.length, 2 + j)
          .setFormula('=SUM($start:$end)');
    }

    //Set data in the worksheet.

    final List<int> bytes = workbook.saveAsStream();
    //Dispose the document.
    workbook.dispose();

    //Save and launch the file.
    File file = await writeCounter(bytes);
    return file.path;
  }

  static Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();

    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    String datetime = DateTime.now().toString();
    return File('$path/Report$datetime.xlsx');
  }

  static Future<File> writeCounter(bytes) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(bytes);
  }
}
