import 'package:flutter/material.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/screen/office_clerk/handle_damage/handle_damage.dart';
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
  List upcoming = [];
  @override
  void initState() {
    super.initState();
    getUpcomingRequest();
  }

  void getUpcomingRequest() {
    List<BrokenItem> out = dummyBroken;
    for (var one in out) {
      if (one.status == "Broken") {
        upcoming.add(one);
      }
    }
    setState(() {
      print("refresh");
    });
  }

  void _showDialog(BuildContext context) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Body_Widget(),
        Positioned(
          bottom: 20,
          right: 20,
          child: Fab(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QRScannPage()),
              );
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
            height: MediaQuery.of(context).size.height - 186,
            child: ListView.builder(
                itemCount: upcoming.length,
                itemBuilder: (context, index) {
                  BrokenItem brokenItem = upcoming[index];
                  return GestureDetector(
                      onTap: () {
                        _showDialog(context);
                      },
                      child: BrokenItemViewCard(brokenItem: brokenItem));
                }),
          )
        ]),
      );
    }
  }
}
