import 'package:flutter/material.dart';
import 'package:inventory_management/controller/office_clerk_controller.dart';
import 'package:inventory_management/model/dummy/broken_item.dart';
import 'package:inventory_management/widget/broken_item_view_card.dart';

class OldRequestScreen extends StatefulWidget {
  OldRequestScreen({Key key}) : super(key: key);

  @override
  _OldRequestScreenState createState() => _OldRequestScreenState();
}

class _OldRequestScreenState extends State<OldRequestScreen> {
  List<BrokenItem> oldItems = [];

  @override
  void initState() {
    super.initState();
    getoldItemsRequest();
  }

  Future getoldItemsRequest() async {
    oldItems.clear();
    List<BrokenItem> out = []; //dummyBroken;
    out = await OfficeClerkController().getOldDamageItem();
    print(out.length);
    for (var one in out) {
      if (one.status == "Broken") {
        oldItems.add(one);
      }
    }
    if (mounted) {
      setState(() {
        print("refresh");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Body_Widget();
  }

  Widget Body_Widget() {
    if (oldItems.length == 0) {
      return Center(
        child: Container(
          child: Text("No Old Damage Record"),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.blue,
              ),
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(5),
              child: Text(
                "Old",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
          Container(
            height: MediaQuery.of(context).size.height - 189,
            child: ListView.builder(
                itemCount: oldItems.length,
                itemBuilder: (context, index) {
                  BrokenItem brokenItem = oldItems[index];
                  return BrokenItemViewCard(
                    brokenItem: brokenItem,
                    isOld: true,
                  );
                }),
          )
        ]),
      );
    }
  }
}
