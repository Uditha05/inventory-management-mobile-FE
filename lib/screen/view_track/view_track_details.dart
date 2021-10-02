import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/widget/borrow_details.dart';
import 'package:inventory_management/widget/equipment.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/theme/app_colors.dart';

class ViewTrackDetails extends StatefulWidget {
  final Iteam iteam;
  ViewTrackDetails({this.iteam});
  @override
  _ViewTrackDetailsState createState() => _ViewTrackDetailsState(iteam: iteam);
}

class _ViewTrackDetailsState extends State<ViewTrackDetails> {
  final Iteam iteam;
  List<BorrowDetails> borrowHistory = [];
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  Widget lastdata = Container();
  GlobalKey<ScaffoldState> scafoldkey = GlobalKey<ScaffoldState>();

  TextEditingController fromdateController = TextEditingController();
  TextEditingController todateController = TextEditingController();
  _ViewTrackDetailsState({this.iteam});

  @override
  void initState() {
    setHistory();
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    super.initState();
  }

  void setHistory() async {
    List<BorrowDetails> borrowHistorytmp =
        await iteam.getBorrowData(fromDate, toDate).then((value) => value
            .map((e) => BorrowDetails(
                  data: e,
                ))
            .toList());

    BorrowDetails tempborrwData =
        await iteam.getLastBorrowData().then((value) => BorrowDetails(
              data: value,
            ));
    setState(() {
      borrowHistory = borrowHistorytmp;
      lastdata = tempborrwData;
    });
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
          leading: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
              child: IconButton(
                  icon: new Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ]),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(
                'View Track Details',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
              ),
              Container(
                child: IconButton(
                    icon: new Icon(FontAwesomeIcons.calendarWeek),
                    onPressed: () {
                      scafoldkey.currentState.openDrawer();
                    }),
              ),
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: AppColor.main_green_background,
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: borrowHistory.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: borrowHistory[index]);
                  }),
            ),
          ],
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  "From",
                  style: TextStyle(fontWeight: FontWeight.w600),
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
                      setHistory();
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
                    lastDate: DateTime(DateTime.now().year,
                        DateTime.now().month, DateTime.now().day + 1),
                    firstDate: fromDate,
                    enabled: true,
                    controller: todateController,
                    onChanged: (value) => setState(() {
                      toDate = DateTime.parse(value);
                      setHistory();
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: AppColor.main_green_background,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: 56.0,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          color: AppColor.main_green_background,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Equipment(
                                iteam: iteam,
                                isviewed: true,
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(Icons.remove_red_eye_sharp),
                color: Colors.red,
              )),
        ));
  }
}
