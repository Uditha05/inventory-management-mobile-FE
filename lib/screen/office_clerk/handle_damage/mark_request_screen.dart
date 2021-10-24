import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/controller/office_clerk_controller.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/screen/office_clerk/qr_scan.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_string_input.dart';
import 'package:inventory_management/widget/broken_item_view_card.dart';

class MarkRequestScreen extends StatefulWidget {
  MarkRequestScreen({Key key}) : super(key: key);

  @override
  _MarkRequestScreenState createState() => _MarkRequestScreenState();
}

class _MarkRequestScreenState extends State<MarkRequestScreen> {
  TextEditingController storeCodeEditor = new TextEditingController();
  String barcodeString;
  List<BrokenItem> pendingList = [];
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    getPendingRequest();
  }

  Future getPendingRequest() async {
    pendingList.clear();
    List<BrokenItem> out = []; //dummyBroken;
    out = await OfficeClerkController().getPendingRepair();
    for (var one in out) {
      if (one.status == "Broken") {
        pendingList.add(one);
      }
    }
    if (mounted) {
      setState(() {
        print("refresh");
      });
    }
  }

  void markRepair() async {
    if (storeCodeEditor.text.trim().isEmpty) {
      print("error empty");
      Fluttertoast.showToast(
          msg: "Store ID is empty or Invalid",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      return;
    } else {
      String id = searchFromList(storeCodeEditor.text);
      if (id == "No") {
        print("error No");
        Fluttertoast.showToast(
            msg: "Equipment is not recognize from below",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
        return;
      } else {
        _showDialog(context, id);
      }
    }
  }

  String searchFromList(String storeCode) {
    for (var oneReq in pendingList) {
      if (oneReq.storeCode == storeCode) {
        return oneReq.itemId;
      }
    }
    return "No";
  }

  Future continuMarking(String id) async {
    var output = await OfficeClerkController().markAsFinished(id);
    if (output != null) {
      await getPendingRequest();
      setState(() {
        isloading = false;
        storeCodeEditor.text = "";
      });
      Navigator.pop(context);
    } else {
      setState(() {
        isloading = false;
      });
      print("error ");
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
            "has this item repaired?",
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
                continuMarking(id);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);

      print(barcodeScanRes.toString());
      if (barcodeScanRes == "" || barcodeScanRes == "-1") {
        setState(() {
          barcodeString = barcodeScanRes;
        });
        if (barcodeString != "-1") {
          setState(() {
            storeCodeEditor.text = barcodeString;
          });
        }

        return;
      } else {
        Fluttertoast.showToast(
            msg: "Barcode can not ditect!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);

        return;
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          )
        : Container(
            // height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Finished Repair ?",
                  style:
                      TextStyle(color: const Color(0xFF5A5E5C), fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    children: [
                      CustomStringInput(
                        hintText: "Store ID",
                        icon: Icon(Icons.store),
                        isEnable: true,
                        maxLetters: 10,
                        textEditingController: storeCodeEditor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            onPressed: () {
                              markRepair();
                            },
                            text: "Mark Repaired",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "-OR-",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: AppColor.main_green_background,
                            ),
                            child: IconButton(
                              icon: Icon(Icons.qr_code_rounded),
                              onPressed: () {
                                scanBarcodeNormal();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => QRScannPage()),
                                // );
                              },
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Under Repairing Items:",
                  style:
                      TextStyle(color: const Color(0xFF5A5E5C), fontSize: 20),
                ),
                SizedBox(
                  height: 5,
                ),
                pendingList.length == 0
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Text("No items under repair"),
                        ),
                      )
                    : Expanded(
                        child: Container(
                          child: ListView.builder(
                              itemCount: pendingList.length,
                              itemBuilder: (contex, index) {
                                BrokenItem brokenItem = pendingList[index];
                                return GestureDetector(
                                  onTap: () {
                                    _showDialog(context, brokenItem.itemId);
                                  },
                                  child: BrokenItemViewCard(
                                    brokenItem: brokenItem,
                                    isOld: false,
                                  ),
                                );
                              }),
                        ),
                      )
              ],
            ),
          );
  }

  // Widget Pending_Request() {
  //   return Expanded(
  //     child: ListView.builder(
  //         itemCount: pendingList.length,
  //         itemBuilder: (contex, index) {
  //           BrokenItem brokenItem = pendingList[index];
  //           return BrokenItemViewCard(
  //             brokenItem: brokenItem,
  //           );
  //         }),
  //   );
  // }

  // Widget Mark_Requests() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         CustomStringInput(
  //           hintText: "Store ID",
  //           icon: Icon(Icons.stacked_bar_chart),
  //           isEnable: true,
  //           maxLetters: 10,
  //           textEditingController: storeCodeEditor,
  //         ),
  //         CustomButton(
  //           onPressed: () {},
  //           text: "Mark Repaired",
  //         ),
  //         Text("-OR-"),
  //         CustomButton(
  //           onPressed: () {},
  //           text: "Scan Code",
  //         )
  //       ],
  //     ),
  //   );
  // }
}
