// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';

import 'package:printing/printing.dart';

class Printer extends StatelessWidget {
  final funtion;
  const Printer({Key key, this.funtion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PDF Viewer'),
        ),
        body: PdfPreview(pageFormats: <String, PdfPageFormat>{
          'A4': PdfPageFormat.a4,
        }, build: (format) => funtion));
  }
}
