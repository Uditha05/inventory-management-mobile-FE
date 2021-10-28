import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/services/category.dart';
import 'package:inventory_management/services/report.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/chart.dart';
import 'package:inventory_management/widget/custom_button.dart';
import 'package:share/share.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:multiselect/multiselect.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UsageReport extends StatefulWidget {
  const UsageReport({Key key}) : super(key: key);

  @override
  _UsageReportState createState() => _UsageReportState();
}

class _UsageReportState extends State<UsageReport> {
  Category categories;
  List<String> catlist = [];
  List category = [];

  List<String> selected = [];
  List chartTypes = [
    'Bar Chart',
    'Column Chart',
    'Line Chart',
    'Stack Line Chart'
  ];
  String charttype = 'Column Chart';
  List reporttypes = ['usage', 'availability'];
  String reporttype = 'usage';
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  bool loading = false;
  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  GlobalKey<ScaffoldState> scafoldkey = GlobalKey<ScaffoldState>();
  List<ChartData> chartData = [];
  Report report;

  setCategories() {
    setState(() {
      print(categories.categories.map((e) => e['categoryName']).toList());
      catlist = categories.categories
          .map((e) => e['categoryName'].toString())
          .toList();
    });
  }

  Future submit() async {
    setState(() {
      this.loading = true;
    });
    fromdateController.text = fromDate.toString();
    todateController.text = toDate.toString();
    scafoldkey.currentState.openEndDrawer();
    category = [];

    for (int i = 0; i < selected.length; i++) {
      category.add({
        'id': categories.getid(selected[i]).toString(),
        'categoryName': selected[i]
      });
    }

    setState(() {
      report = new Report(
          fromdate: fromDate,
          toDate: toDate,
          categories: category,
          reportType: reporttype);
    });
    List<ChartData> chartDatatmp = await report.getReport();
    setState(() {
      chartData = chartDatatmp;
      this.loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    categories = new Category(setCategories);
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    setState(() {
      report = new Report(
          fromdate: fromDate,
          toDate: toDate,
          categories: selected,
          reportType: reporttype);
      //chartData = report.getReport();
    });
    super.initState();
  }

  Future generateXL() async {
    if (report != null) {
      String path = await report.generateXL();
      Share.shareFiles(
        [path],
      );
    }
  }

  _onLayoutDone(_) {
    scafoldkey.currentState.openDrawer();
    fromdateController.text = fromDate.toString();
    todateController.text = toDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldkey,
      appBar: AppBar(
        backgroundColor: AppColor.main_green_background,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(),
          Text('Reports'),
          Container(
            child: IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () {
                  scafoldkey.currentState.openDrawer();
                }),
          ),
        ]),
        leading: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            child: IconButton(
                icon: new Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ]),
      ),
      body: loading
          ? SpinKitFadingCircle(
              color: Colors.black,
              size: 50.0,
            ) //Icon(FontAwesomeIcons.spinner)
          : Chrartless(
              type: charttype,
              fromdate: fromDate,
              todate: toDate,
              chartData: chartData,
            ),
      floatingActionButton: report != null
          ? FloatingActionButton(
              backgroundColor: AppColor.main_green_background,
              child: Icon(FontAwesomeIcons.fileCsv),
              onPressed: () => generateXL(),
            )
          : Container(),
      drawer: SafeArea(
        child: Drawer(
          elevation: 0,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            Form(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: DropdownButton(
                      hint: Text("Select one ..."),
                      value: charttype,
                      onChanged: (newvalue) {
                        setState(() {
                          charttype = newvalue;
                        });
                      },
                      items: chartTypes.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: DropdownButton(
                      hint: Text("Select one ..."),
                      value: reporttype,
                      onChanged: (newvalue) {
                        setState(() {
                          reporttype = newvalue;
                        });
                      },
                      items: reporttypes.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    child: DropDownMultiSelect(
                      onChanged: (List<String> x) {
                        setState(() {
                          selected = x;
                        });
                      },
                      options: catlist,
                      selectedValues: selected,
                      whenEmpty: 'Select Something',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateHintText: 'From',
                      initialDate: fromDate,
                      firstDate: DateTime(2010, 1, 1),
                      lastDate: DateTime.now(),
                      enabled: true,
                      controller: fromdateController,
                      onChanged: (value) => setState(() {
                        fromDate = DateTime.parse(value);
                        print(fromDate);
                      }),
                    ),
                  ),
                  Text(
                    "To",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: DateTimePicker(
                      autovalidate: true,
                      type: DateTimePickerType.date,
                      dateHintText: 'To',
                      initialDate: toDate,
                      lastDate: DateTime.now(),
                      firstDate: fromDate,
                      enabled: true,
                      controller: todateController,
                      onChanged: (value) => setState(() {
                        toDate = DateTime.parse(value);
                        print(toDate);
                      }),
                    ),
                  ),
                  Container(
                    child: CustomButton(
                      onPressed: () => submit(),
                      text: "Submit",
                    ),
                  ),
                ],
              ),
            ),
            //Initialize the chart widget
          ]),
        ),
      ),
    );
  }
}
