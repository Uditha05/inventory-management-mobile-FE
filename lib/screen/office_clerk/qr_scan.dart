import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventory_management/theme/app_colors.dart';

class QRScannPage extends StatefulWidget {
  QRScannPage({Key key}) : super(key: key);

  @override
  _QRScannPageState createState() => _QRScannPageState();
}

class _QRScannPageState extends State<QRScannPage> {
  String _scanBarcode = 'Unknown';

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if (barcodeScanRes != " ") {
      validateBarcode(barcodeScanRes);
    } else {
      print("no barcode");
    }
    // setState(() {
    //   _scanBarcode = barcodeScanRes;
    // });
  }

  validateBarcode(String code) {
    if (code != "gg") {
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColor.main_green_background,
            title: new Text(
              "Are You Sure ?",
              style: TextStyle(color: Colors.white),
            ),
            content: new Text(
              "Move item to repair state",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              new FlatButton(
                color: Colors.green[200],
                child: new Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                color: Colors.green[200],
                child: new Text(
                  "Continue",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () => scanBarcodeNormal(),
                  child: Text('Start barcode scan')),
              Text('Scan result : $_scanBarcode\n',
                  style: TextStyle(fontSize: 20))
            ]));
  }
}
