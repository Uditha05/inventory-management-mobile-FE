import 'dart:math';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:inventory_management/services/UserModel.dart';
import 'package:inventory_management/services/category.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/services/lab.dart';
import 'package:inventory_management/services/modal.dart';
import 'package:inventory_management/services/printing.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/custem_input.dart';

import 'package:inventory_management/widget/custom_button.dart';
import 'package:inventory_management/widget/custom_string_input.dart';
import 'package:inventory_management/widget/search_bar.dart';

class AddUpdateEquipmetForm extends StatefulWidget {
  final String type;
  final Iteam iteam;
  const AddUpdateEquipmetForm({Key key, this.type, this.iteam})
      : super(key: key);

  @override
  _AddUpdateEquipmetFormState createState() =>
      _AddUpdateEquipmetFormState(type: type, iteam: iteam);
}

class _AddUpdateEquipmetFormState extends State<AddUpdateEquipmetForm> {
  String type;
  Iteam iteam;
  TextEditingController catetoryController = new TextEditingController();
  TextEditingController modelController = new TextEditingController();
  TextEditingController storeCodeController = new TextEditingController();
  TextEditingController labController = new TextEditingController();
  List addUpdateTypes = ["notdamaged", "damaged"];
  String addUpdateType = "notdamaged";

  String model = '';
  bool isIDVailed;
  bool isUpdate;
  bool _allowWriteFile = false;
  _AddUpdateEquipmetFormState({this.type, this.iteam});
  Category categories;
  List catlist = [];
  String category = '';

  Lab labs;
  List lablist = [];
  String lab = '';

  Model models;
  List modellist = [];
  bool submi = false;
  @override
  void initState() {
    submi = false;
    isIDVailed = false;
    if (type == "Add Equipment") {
      isUpdate = false;
      categories = new Category(setCategories);
      labs = new Lab(setlabs);
    } else {
      isUpdate = true;
      catetoryController.text = iteam.catogary;
      modelController.text = iteam.model;
      storeCodeController.text = iteam.store_code;
      labController.text = iteam.lab;
      addUpdateType = iteam.status;
    }

    super.initState();
    //requestWritePermission();
  }

  setlabs() {
    setState(() {
      lablist = labs.labs;
    });
  }

  setCategories() {
    setState(() {
      catlist = categories.categories;
    });
  }

  Future genarateQr(id) async {
    if (!isUpdate) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Printer(funtion: Iteam.createwithid(id))));
  }

  Future submit() async {
    print(submi);
    String error = '';
    submi = true;
    if (isUpdate) {
      if (catetoryController.text.isEmpty) {
        error = "Catogary is Empty";
      } else if (modelController.text.isEmpty) {
        error = "Model is Empty";
      } else if (labController.text.isEmpty) {
        error = "Lab is Empty";
      } else if (addUpdateType.isEmpty) {
        error = "Status is Empty";
      } else {
        List check =
            await iteam.SetLabandStatus(labController.text, addUpdateType);
        if (check[0]) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        } else {
          error = check[1];
        }
      }
    } else {
      if (category == '') {
        error = "Catogary is Empty";
      } else if (model == '') {
        error = "Model is Empty";
      } else if (lab == '') {
        error = "Lab is Empty";
      } else {
        List check = await Iteam.createNewIteam(category, model, lab);

        if (check[0]) {
          genarateQr(check[2]);
        } else {
          error = check[1];
        }
      }
    }
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
    submi = false;
  }

  setmodels() {
    setState(() {
      modellist = models.models;
    });
  }

  setCategory(val) {
    setState(() {
      category = categories.getid(val).toString();
      models = new Model(category, setmodels);
    });
  }

  setmodel(name) {
    setState(() {
      model = models.getid(name).toString();
    });
  }

  setlab(name) {
    setState(() {
      lab = labs.getid(name).toString();
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
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      !isUpdate
                          ? Column(
                              children: [
                                DropdownSearch(
                                    mode: Mode.MENU,
                                    enabled: !isUpdate,
                                    items: catlist
                                        .map(
                                            (e) => e['categoryName'].toString())
                                        .toList(),
                                    label: "Catetory",
                                    hint: "select categories",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('I'),
                                    onChanged: setCategory,
                                    selectedItem: "Category"),
                                SizedBox(
                                  height: 15,
                                ),
                                DropdownSearch(
                                    mode: Mode.MENU,
                                    enabled: !isUpdate,
                                    items: models != null
                                        ? modellist
                                            .map((e) =>
                                                e['modelName'].toString())
                                            .toList()
                                        : [''],
                                    label: "Model",
                                    hint: "select model",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('I'),
                                    onChanged: setmodel,
                                    selectedItem: "Model"),
                                SizedBox(
                                  height: 15,
                                ),
                                DropdownSearch(
                                    mode: Mode.MENU,
                                    enabled: !isUpdate,
                                    items: labs != null
                                        ? lablist
                                            .map((e) => e['labName'].toString())
                                            .toList()
                                        : [''],
                                    label: "Lab",
                                    hint: "select lab",
                                    popupItemDisabled: (String s) =>
                                        s.startsWith('I'),
                                    onChanged: setlab,
                                    selectedItem: "Lab"),
                              ],
                            )
                          : Column(
                              children: [
                                InputFeildType(
                                  textEditingController: catetoryController,
                                  isEnable: !isUpdate,
                                  name: 'Catetory',
                                ),
                                InputFeildType(
                                  textEditingController: modelController,
                                  isEnable: !isUpdate,
                                  name: 'Model',
                                ),
                                InputFeildType(
                                  textEditingController: labController,
                                  isEnable: true,
                                  name: 'Lab',
                                ),
                              ],
                            ),
                      isUpdate
                          ? Container(
                              padding: EdgeInsets.all(8),
                              child: DropdownButton(
                                hint: Text("Select one ..."),
                                value: addUpdateType,
                                onChanged: (newvalue) {
                                  setState(() {
                                    addUpdateType = newvalue;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    child: Text('damaged'),
                                    value: 'damaged',
                                  ),
                                  DropdownMenuItem(
                                    child: Text('notdamaged'),
                                    value: 'notdamaged',
                                  )
                                ],
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: CustomButton(
                              onPressed: () => !submi ? submit() : null,
                              text: "Submit",
                            ),
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          isUpdate
                              ? Container(
                                  child: CustomButton(
                                    onPressed: () =>
                                        genarateQr(iteam.store_code),
                                    text: "bar code Genarate",
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
