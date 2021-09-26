import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/controller/office_clerk_controller.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/screen/office_clerk/handle_damage/handle_damage.dart';
import 'package:inventory_management/screen/office_clerk/office_clerk_dashboard.dart';
import 'package:inventory_management/screen/office_clerk/qr_scan.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/broken_item_view_card.dart';
import 'package:inventory_management/widget/qr_float_button.dart';

class NewRequestScreen extends StatefulWidget {
  NewRequestScreen({Key key}) : super(key: key);

  @override
  _NewRequestScreenState createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {
  String barcodeString;
  List upcoming = [];
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getUpcomingRequest();
  }

  Future getUpcomingRequest() async {
    upcoming.clear();
    List<BrokenItem> out = []; //dummyBroken;
    out = await OfficeClerkController().getNewDamages();
    for (var one in out) {
      if (one.status == "Broken") {
        upcoming.add(one);
      }
    }
    setState(() {
      print("refresh");
    });
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      if (barcodeString != null) {
        chckFromBendingRequest();
        return;
      }
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      barcodeString = barcodeScanRes;
    });
  }

  chckFromBendingRequest() {}

  void markAsRepair(String id) async {
    var out = await OfficeClerkController().markSendToRepair(id);
    if (out == "pass") {
      await getUpcomingRequest();
      setState(() {
        isloading = false;
      });
      Navigator.pop(context);
      // Navigator.of(context).push(new MaterialPageRoute(
      //     builder: (BuildContext context) => OfficeClerkDashboard()));
    } else {
      setState(() {
        isloading = false;
      });
      Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  void _showDialog(BuildContext context, String id) {
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
                setState(() {
                  isloading = true;
                });
                markAsRepair(id);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: [
              Body_Widget(),
              Positioned(
                bottom: 20,
                right: 20,
                child: Fab(
                  onTap: () {
                    scanBarcodeNormal();
                  },
                  child: Icon(Icons.qr_code),
                ),
              ),
            ],
          );
  }

  Widget Body_Widget() {
    if (upcoming.length == 0) {
      return Center(
        child: Container(
          child: Text("No New Damage Request"),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.red,
              ),
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(5),
              child: Text(
                "NEW",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
          Container(
            height: MediaQuery.of(context).size.height - 189,
            child: ListView.builder(
                itemCount: upcoming.length,
                itemBuilder: (context, index) {
                  BrokenItem brokenItem = upcoming[index];
                  return GestureDetector(
                      onTap: () {
                        _showDialog(context, brokenItem.itemId);
                      },
                      child: BrokenItemViewCard(
                        brokenItem: brokenItem,
                        isOld: false,
                      ));
                }),
          )
        ]),
      );
    }
  }
}
