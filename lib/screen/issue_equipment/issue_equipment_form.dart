import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/screen/technicla_officer_dashboard/technical_officer_dashboard.dart';

import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/request.dart';
import 'package:inventory_management/services/i_request_user.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/custem_input.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_string_input.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IssueEquipmetForm extends StatefulWidget {
  final String type;
  const IssueEquipmetForm({Key key, this.type}) : super(key: key);

  @override
  _IssueEquipmetFormState createState() => _IssueEquipmetFormState(type: type);
}

class _IssueEquipmetFormState extends State<IssueEquipmetForm> {
  String type;
  TextEditingController studentIdController = new TextEditingController();
  TextEditingController requestIdController = new TextEditingController();
  TextEditingController catetoryController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  TextEditingController storeCodeController = new TextEditingController();
  TextEditingController lectureController = new TextEditingController();

  DateTime fromDate;
  DateTime toDate;
  bool loading = false;
  bool loadingsubmit = false;
  Request request;
  IRequestUser iRequestUser;
  Iteam iteam;
  bool isIDVailed;
  bool isnewRequest;
  bool isTemp;
  _IssueEquipmetFormState({this.type});
  @override
  void initState() {
    isIDVailed = false;
    if (type == "Select Approved borrowing") {
      isnewRequest = false;
    } else {
      isnewRequest = true;
    }
    if (type == "Create New Tempory Borrowing") {
      isTemp = true;
    } else {
      isTemp = false;
    }
    super.initState();
  }

  Future findStudentByID(String id) async {
    iRequestUser = await IRequestUser.findStudentByID(id);
    if (iRequestUser != null) {
      if (iRequestUser.request != null &&
          iRequestUser.request.status == "Approved") {
        setState(() {
          iteam = iRequestUser.request.iteam;
        });
        requestIdController.text = iRequestUser.request.id;
        catetoryController.text = iRequestUser.request.iteam.catogary;
        storeCodeController.text = iRequestUser.request.iteam.store_code;
        modelController.text = iRequestUser.request.iteam.model;
        lectureController.text = iRequestUser.request.lecture.id;
        setState(() {
          isIDVailed = true;
        });
      } else {
        Fluttertoast.showToast(
            msg: "Request is not Vaild",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
        isIDVailed = false;
      }
    } else {
      Fluttertoast.showToast(
          msg: "Invalid Student Id",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColor.toast_msg_warning,
          textColor: Colors.white,
          fontSize: 13.0);
      isIDVailed = false;
    }
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

  void onChangeStoreCode() async {
    if (storeCodeController.text.length > 0) {
      setState(() {
        this.loading = true;
      });
      iteam = await Iteam.findByStoreId(storeCodeController.text);
      setState(() {
        this.loading = false;
      });
      if (iteam != null) {
        SetCatogoryModel(iteam);
      } else {
        Fluttertoast.showToast(
            msg: 'invaid store id',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColor.toast_msg_warning,
            textColor: Colors.white,
            fontSize: 13.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Enter Store id',
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
    } else if (fromDate == null) {
      error = "From Date is Empty";
    } else if (toDate == null) {
      error = "To Date is Empty";
    } else if (!isTemp && lectureController.text.isEmpty) {
      error = "Lecture is Empty";
    } else {
      if (isnewRequest) {
        setState(() {
          this.loadingsubmit = true;
        });
        var result = await iteam.IssueEquipment(
            studentIdController.text, fromDate, toDate);
        setState(() {
          this.loadingsubmit = false;
        });
        if (result == null) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => TechnicalOfficerDashboard()));
        } else {
          error = result;
        }
      } else {
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

  void SetCatogoryModel(Iteam iteam) {
    print(iteam);
    setState(() {
      storeCodeController.text = iteam.store_code;
      modelController.text = iteam.model;
      catetoryController.text = iteam.catogary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(type),
          backgroundColor: AppColor.main_green_background,
        ),
        body: SingleChildScrollView(
          child: loadingsubmit
              ? SpinKitFadingCircle(
                  color: Colors.black,
                  size: 50.0,
                ) //Icon(FontAwesomeIcons.spinner)
              : Container(
                  child: Column(
                    children: [
                      InputFeildType(
                        textEditingController: studentIdController,
                        isEnable: !isIDVailed,
                        name: 'Student Id',
                      ),
                      (!isIDVailed && !isnewRequest)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: CustomButton(
                                    onPressed: () => findStudentByID(
                                        studentIdController.text),
                                    text: "Next",
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              child: Column(
                                children: [
                                  isnewRequest
                                      ? Container()
                                      : InputFeildType(
                                          textEditingController:
                                              requestIdController,
                                          isEnable: false,
                                          name: 'Request ID',
                                        ),
                                  InputFeildType(
                                    textEditingController: storeCodeController,
                                    isEnable: isnewRequest && iteam == null,
                                    name: 'Store Code',
                                  ),
                                  loading
                                      ? SpinKitFadingCircle(
                                          color: Colors.black,
                                          size: 50.0,
                                        ) //Icon(FontAwesomeIcons.spinner)
                                      : iteam == null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: CustomButton(
                                                    onPressed: () =>
                                                        onChangeStoreCode(),
                                                    text: "Next",
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                isnewRequest
                                                    ? Container(
                                                        child: CustomButton(
                                                          onPressed: () =>
                                                              findDataByQr(),
                                                          text: "bar code",
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                InputFeildType(
                                                  textEditingController:
                                                      catetoryController,
                                                  isEnable: false,
                                                  name: 'Catetory',
                                                ),
                                                InputFeildType(
                                                  textEditingController:
                                                      modelController,
                                                  isEnable: false,
                                                  name: 'Model',
                                                ),
                                                isTemp
                                                    ? Container()
                                                    : InputFeildType(
                                                        textEditingController:
                                                            lectureController,
                                                        isEnable:
                                                            isnewRequest &&
                                                                !isTemp,
                                                        name: 'Lecture',
                                                      ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "From",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 20),
                                                      child: DateTimePicker(
                                                        type: DateTimePickerType
                                                            .dateTime,
                                                        dateHintText: 'From',
                                                        initialDate:
                                                            DateTime.now(),
                                                        lastDate: new DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                .month,
                                                            DateTime.now().day),
                                                        firstDate:
                                                            DateTime.now(),
                                                        enabled: true,
                                                        onChanged: (value) =>
                                                            setState(() {
                                                          fromDate =
                                                              DateTime.parse(
                                                                  value);
                                                          print(fromDate);
                                                        }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      "To",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Container(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 0, 10, 20),
                                                      child: DateTimePicker(
                                                        type: DateTimePickerType
                                                            .dateTime,
                                                        dateHintText: 'To',
                                                        initialDate:
                                                            DateTime.now(),
                                                        lastDate: new DateTime(
                                                            DateTime.now().year,
                                                            DateTime.now()
                                                                .month,
                                                            DateTime.now().day +
                                                                7),
                                                        firstDate:
                                                            DateTime.now(),
                                                        enabled: true,
                                                        onChanged: (value) =>
                                                            setState(() {
                                                          toDate =
                                                              DateTime.parse(
                                                                  value);
                                                          print(toDate);
                                                        }),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      iteam != null
                                          ? Container(
                                              child: CustomButton(
                                                onPressed: () => submit(),
                                                text: "Submit",
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
