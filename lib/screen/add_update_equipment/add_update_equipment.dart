import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/services/iteam.dart';


import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_string_input.dart';

import 'add_update_equipment_form.dart';

class AddUpdateEquipment extends StatefulWidget {
  const AddUpdateEquipment({Key key}) : super(key: key);

  @override
  _AddUpdateEquipmentState createState() => _AddUpdateEquipmentState();
}

class _AddUpdateEquipmentState extends State<AddUpdateEquipment> {
  TextEditingController storeIdController = new TextEditingController();
  String addUpdateType = 'Add Equipment';
  List addUpdateTypes = ["Add Equipment", "Update Equipment Details"];
  Iteam iteam;
  Future next(BuildContext context) async {
    if (addUpdateType == "Update Equipment Details") {
      iteam = await Iteam.findByStoreId(storeIdController.text);
    }
    if (iteam == null && addUpdateType == "Update Equipment Details") {
      Fluttertoast.showToast(
          msg: "Invalid Store ID",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddUpdateEquipmetForm(
              type: addUpdateType,
              iteam: iteam,
            ),
          ));
    }
  }

  Future findDataByQr() async {
    iteam = await Iteam.findDataByQr();
    if (iteam != null) {
      setState(() {
        storeIdController.text = iteam.store_code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Update Equipment'),
        centerTitle: true,
        backgroundColor: AppColor.main_green_background,
        elevation: 0,
      ),
      backgroundColor: AppColor.main_green_background,
      body: SingleChildScrollView(
        child: Padding(
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
                    Container(
                      padding: EdgeInsets.all(8),
                      child: DropdownButton(
                        hint: Text("Select one ..."),
                        value: addUpdateType,
                        onChanged: (newvalue) {
                          setState(() {
                            addUpdateType = newvalue;
                          });
                        },
                        items: addUpdateTypes.map((e) {
                          return DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          );
                        }).toList(),
                      ),
                    ),
                    addUpdateType == "Update Equipment Details"
                        ? Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                child: CustomStringInput(
                                  hintText: "Store ID",
                                  icon: Icon(Icons.person),
                                  isEnable: addUpdateType ==
                                      "Update Equipment Details",
                                  maxLetters: 15,
                                  textEditingController: storeIdController,
                                ),
                              ),
                              Container(
                                child: CustomButton(
                                  onPressed: () => findDataByQr(),
                                  text: "bar code",
                                ),
                              ),
                            ],
                          )
                        : Container(),
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
      ),
    );
  }
}
