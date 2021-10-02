import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_management/api/technical_officer/technical_officer.dart'
    as api;
import 'package:inventory_management/services/borrow_data.dart';
import 'package:inventory_management/widget/borrow_details.dart';
import 'dart:io';
import 'package:barcode/barcode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Iteam {
  final String catogary;
  final String store_code;
  final String model;
  final String lab;
  final bool isAvailable;
  final DateTime available_time = DateTime.now();
  String status = "damaged";
  String imgURL;

  Iteam(
      {this.catogary,
      this.isAvailable,
      this.lab,
      this.model,
      this.store_code,
      this.status});

  Future<List<BorrowData>> getBorrowData(fromDate, toDate) async {
    return await api.getBorrowData(this.store_code, fromDate, toDate);
    //   List<BorrowData> list = [];
    //   list.add(new BorrowData(
    //       type: "Lecture",
    //       toDate: toDate,
    //       fromDate: fromDate,
    //       name: "pubba pubba pubba pubba",
    //       index: "180240J",
    //       id: '23456'));
    //   list.add(new BorrowData(
    //       type: "Student",
    //       toDate: toDate,
    //       fromDate: fromDate,
    //       name: "pubudu prabhathiya",
    //       index: "180240J",
    //       id: '23456'));
    //   list.add(new BorrowData(
    //       type: "Lecture",
    //       toDate: toDate,
    //       fromDate: fromDate,
    //       name: "pubba",
    //       index: "180240J",
    //       id: '23456'));
    //   list.add(new BorrowData(
    //       type: "Student",
    //       toDate: toDate,
    //       fromDate: fromDate,
    //       name: "pubudu",
    //       index: "180240J",
    //       id: '23456'));
    //   return list;
    // }
  }

  Future<BorrowData> getLastBorrowData() async {
    BorrowData list = new BorrowData(
        type: "Lecture",
        toDate: DateTime.now(),
        fromDate: DateTime.now(),
        name: "pubba pubba pubba pubba",
        status: "180240J",
        id: '23456');

    return list;
  }

  static Future<Iteam> findDataByQr() async {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => Barcode()));
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeScanRes != '-1') {
        return await api.getEquipmentByStoreCode(barcodeScanRes);
        //   return new Iteam(
        //       store_code: barcodeScanRes,
        //       isAvailable: true,
        //       catogary: 'Cam',
        //       model: 'Nikon',
        //       lab: 'level2');
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }

// ignore_for_file: always_specify_types

  static String buildBarcode(
    Barcode bc,
    String data, {
    String filename,
    double width,
    double height,
    double fontHeight,
  }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    return svg;
  }

  Future IssueEquipment(userid, fromdate, todate) async {
    return await api.temporyIssueEquipment(
        userid, store_code, fromdate, todate, 'reason');
  }

  Future<Uint8List> create() async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.SvgImage(
                svg: buildBarcode(
              Barcode.code128(useCode128B: false, useCode128C: false),
              store_code,
              filename: store_code,
            )),
          ); // Center
        })); // Page

    final output = await getExternalStorageDirectory();
    return doc.save();
  }

  static Future<Uint8List> createwithid(id) async {
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.SvgImage(
                svg: buildBarcode(
              Barcode.code128(useCode128B: false, useCode128C: false),
              id,
              filename: id,
            )),
          ); // Center
        })); // Page

    final output = await getExternalStorageDirectory();
    return doc.save();
  }

  static Future<Iteam> findByStoreId(String id) async {
    return await api.getEquipmentByStoreCode(id);
    // if (id != "") {
    //   return await Iteam(
    //       store_code: id,
    //       isAvailable: true,
    //       catogary: 'Cam',
    //       model: 'Nikon',
    //       lab: 'level2');
    // } else {
    //   return null;
    // }
  }

  static Future<List<Iteam>> findIteamsByCatogary(int categoryId) async {
    print(categoryId);
    return await api.findIteamsByCatogary(categoryId);
    //  [
    //   Iteam(
    //       store_code: "1234-234-355",
    //       isAvailable: true,
    //       catogary: 'cat',
    //       model: 'Nikon',
    //       lab: 'level2'),
    //   Iteam(
    //       store_code: "1234-234-231",
    //       isAvailable: false,
    //       catogary: 'cat',
    //       model: 'Canon',
    //       lab: 'level2')
    // ];
  }

  Future<List> checkIteamVaild() async {
    if (Random().nextInt(10) < 1235) {
      return [true, "none"];
    } else {
      return [false, "Error"];
    }
  }

  Future<List> SetLabandStatus(String lab, String Status) async {
    return await api.updateEquipment(store_code, Status);
    // if (Random().nextInt(10) < 125) {
    //   return [true, "none"];
    // } else {
    //   return [false, "Error"];
    // }
  }

  static Future<List> createNewIteam(
      String catogary, String Model, String lab) async {
    return await api.AddEquipment(catogary, Model, lab);
    // Iteam iteam = Iteam(
    //     catogary: catogary,
    //     model: Model,
    //     lab: lab,
    //     store_code: Random().nextInt(1000).toString() +
    //         "-1234-" +
    //         Random().nextInt(1000).toString(),
    //     status: Status);
    // if (Random().nextInt(10) < 1235) {
    //   return [true, "none", iteam];
    // } else {
    //   return [false, "Error", null];
    // }
  }
}
