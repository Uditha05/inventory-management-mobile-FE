import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TextEditingController storeCode = new TextEditingController();
  List pendingList = [];

  @override
  void initState() {
    super.initState();
    getPendingRequest();
  }

  void getPendingRequest() {
    List<BrokenItem> out = dummyBroken;
    for (var one in out) {
      if (one.status == "Repair") {
        pendingList.add(one);
      }
    }
    setState(() {
      print("refresh");
    });
  }

  void markRepair() {
    if (storeCode.text.trim().isEmpty) {
      Fluttertoast.showToast(
          msg: "Invalid Store ID",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      return;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            style: TextStyle(color: const Color(0xFF5A5E5C), fontSize: 20),
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
                  textEditingController: storeCode,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QRScannPage()),
                          );
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
            style: TextStyle(color: const Color(0xFF5A5E5C), fontSize: 20),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                  itemCount: pendingList.length,
                  itemBuilder: (contex, index) {
                    BrokenItem brokenItem = pendingList[index];
                    return BrokenItemViewCard(
                      brokenItem: brokenItem,
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget Pending_Request() {
    return Expanded(
      child: ListView.builder(
          itemCount: pendingList.length,
          itemBuilder: (contex, index) {
            BrokenItem brokenItem = pendingList[index];
            return BrokenItemViewCard(
              brokenItem: brokenItem,
            );
          }),
    );
  }

  Widget Mark_Request() {
    return Container(
      child: Column(
        children: [
          CustomStringInput(
            hintText: "Store ID",
            icon: Icon(Icons.stacked_bar_chart),
            isEnable: true,
            maxLetters: 10,
            textEditingController: storeCode,
          ),
          CustomButton(
            onPressed: () {},
            text: "Mark Repaired",
          ),
          Text("-OR-"),
          CustomButton(
            onPressed: () {},
            text: "Scan Code",
          )
        ],
      ),
    );
  }
}
