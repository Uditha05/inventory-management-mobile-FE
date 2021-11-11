import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/screen/technicla_officer_dashboard/technical_officer_dashboard.dart';
import 'package:inventory_management/services/borrow_data.dart';

import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/request.dart';
import 'package:inventory_management/services/i_request_user.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/custem_input.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_string_input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AcceptEquipmentForm extends StatefulWidget {
  final String type;
  const AcceptEquipmentForm({Key key, this.type}) : super(key: key);

  @override
  _AcceptEquipmentFormState createState() => _AcceptEquipmentFormState();
}

class _AcceptEquipmentFormState extends State<AcceptEquipmentForm> {
  TextEditingController studentIdController = new TextEditingController();
  TextEditingController requestIdController = new TextEditingController();
  TextEditingController catetoryController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  TextEditingController storeCodeController = new TextEditingController();
  TextEditingController fromDateController = new TextEditingController();
  TextEditingController toDateController = new TextEditingController();
  bool loading = false;
  bool loadingsubmit = false;
  BorrowData borrowData;
  IRequestUser iRequestUser;
  Iteam iteam;
  bool isIDVailed;
  List addUpdateTypes = ["notdamage", "damage"];
  String addUpdateType = "notdamage";
  _AcceptEquipmentFormState();
  @override
  void initState() {
    isIDVailed = false;
    super.initState();
  }

  Future findDataByQr() async {
    Iteam tmpiteam = await Iteam.findDataByQr();
    if (tmpiteam != null) {
      setState(() {
        // request.setIteam(iteam);
        iteam = tmpiteam;
        SetCatogoryModel(iteam);
      });
    } else {
      Fluttertoast.showToast(
          msg: "Store code is Worng",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  void onChangeStoreCode(String query) async {
    if (query.length > 5) {
      setState(() {
        this.loading = true;
      });
      iteam = await Iteam.findByStoreId(query);
      setState(() {
        this.loading = false;
      });
      if (iteam != null) {
        SetCatogoryModel(iteam);
      } else {
        Fluttertoast.showToast(
            msg: 'Store id invalid',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Store id invalid',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
    }

    print("hi");
  }

  Future submit() async {
    print("object");

    String error = "";
    if (studentIdController.text.isEmpty) {
      error = "Student id is Empty";
    } else if (storeCodeController.text.isEmpty) {
      error = "store Code is Empty";
    } else {
      setState(() {
        this.loadingsubmit = true;
      });
      var result = await borrowData.AcceptEquipment(iteam.status);
      setState(() {
        this.loadingsubmit = false;
      });
      if (result) {
        error = "Error";
      } else {
        //Navigator.popUntil(context, ModalRoute.withName('/'));
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => TechnicalOfficerDashboard()));
      }
    }
    print(error);
    if (error.isNotEmpty) {
      Fluttertoast.showToast(
          msg: error,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
    }
  }

  void SetCatogoryModel(Iteam iteam) async {
    BorrowData tempborrwData = await iteam.getLastBorrowData();
    if (tempborrwData != null) {
      setState(() {
        isIDVailed = true;
        borrowData = tempborrwData;
        storeCodeController.text = iteam.store_code;
        modelController.text = iteam.model;
        catetoryController.text = iteam.catogary;
        studentIdController.text = borrowData.userid;
        fromDateController.text = borrowData.fromDate.toString();
        toDateController.text = borrowData.toDate.toString();
        requestIdController.text = borrowData.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Accept Equipment"),
        backgroundColor: AppColor.main_green_background,
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: loadingsubmit
            ? SpinKitFadingCircle(
                color: Colors.black,
                size: 50.0,
              ) //Icon(FontAwesomeIcons.spinner)
            : Column(
                children: [
                  InputFeildType(
                    textEditingController: storeCodeController,
                    isEnable: !isIDVailed,
                    name: 'Store Code',
                    //onchange: onChangeStoreCode,
                  ),
                  loading
                      ? SpinKitFadingCircle(
                          color: Colors.black,
                          size: 50.0,
                        ) //Icon(FontAwesomeIcons.spinner)
                      : (!isIDVailed)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: CustomButton(
                                    onPressed: () => onChangeStoreCode(
                                        storeCodeController.text),
                                    text: "Next",
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Container(
                                  child: CustomButton(
                                    onPressed: () => findDataByQr(),
                                    text: "bar code",
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              child: Column(
                                children: [
                                  InputFeildType(
                                    textEditingController: studentIdController,
                                    isEnable: !isIDVailed,
                                    name: 'Student Id',
                                  ),
                                  InputFeildType(
                                    textEditingController: requestIdController,
                                    isEnable: false,
                                    name: 'Request ID',
                                  ),
                                  InputFeildType(
                                    textEditingController: catetoryController,
                                    isEnable: false,
                                    name: 'Catetory',
                                  ),
                                  InputFeildType(
                                    textEditingController: modelController,
                                    isEnable: false,
                                    name: 'Model',
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "From",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 20),
                                        child: DateTimePicker(
                                          type: DateTimePickerType.dateTime,
                                          dateHintText: 'From',
                                          initialDate: DateTime.now(),
                                          lastDate: new DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day),
                                          firstDate: DateTime.now(),
                                          enabled: false,
                                          controller: fromDateController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "To",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 20),
                                        child: DateTimePicker(
                                          type: DateTimePickerType.dateTime,
                                          dateHintText: 'To',
                                          initialDate: DateTime.now(),
                                          lastDate: new DateTime(
                                              DateTime.now().year,
                                              DateTime.now().month,
                                              DateTime.now().day + 7),
                                          firstDate: DateTime.now(),
                                          enabled: false,
                                          controller: toDateController,
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: CustomButton(
                                          onPressed: () => submit(),
                                          text: "Submit",
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                ],
              ),
      ),
    );
  }
}
