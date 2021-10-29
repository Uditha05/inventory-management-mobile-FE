import 'package:flutter/material.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment_form.dart';
import 'package:inventory_management/theme/app_colors.dart';

class IssueEquipment extends StatefulWidget {
  const IssueEquipment({Key key}) : super(key: key);

  @override
  _IssueEquipmentState createState() => _IssueEquipmentState();
}

class _IssueEquipmentState extends State<IssueEquipment> {
  String borrow_type = 'Select Approved borrowing';
  List borrow_types = [
    "Select Approved borrowing",
    "Create New Tempory Borrowing"
  ];

  Future next(BuildContext context) async {
    print("object");
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IssueEquipmetForm(
            type: borrow_type,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Equipment'),
        centerTitle: true,
        backgroundColor: AppColor.main_green_background,
        elevation: 0,
      ),
      backgroundColor: AppColor.main_green_background,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 370,
          height: 1000,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[200],
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Borrowing Type",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: DropdownButton(
                      hint: Text("Select one ..."),
                      value: borrow_type,
                      onChanged: (newvalue) {
                        setState(() {
                          borrow_type = newvalue;
                        });
                      },
                      items: borrow_types.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  RaisedButton(
                    onPressed: () => next(context),
                    color: AppColor.main_green_background,
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
