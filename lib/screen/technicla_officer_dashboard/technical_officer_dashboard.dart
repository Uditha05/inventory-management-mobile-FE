import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/screen/accept_equipment/accept_equipment.dart';
import 'package:inventory_management/screen/add_update_equipment/add_update_equipment.dart';
import 'package:inventory_management/screen/issue_equipment/issue_equipment.dart';
import 'package:inventory_management/screen/view_track/view_track.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/screen/monthly_report/usage_report.dart';
import 'package:printing/printing.dart';

class TechnicalOfficerDashboard extends StatefulWidget {
  const TechnicalOfficerDashboard({Key key}) : super(key: key);

  @override
  _TechnicalOfficerDashboardState createState() =>
      _TechnicalOfficerDashboardState();
}

class _TechnicalOfficerDashboardState extends State<TechnicalOfficerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.main_green_background,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Dashboard"),
            SizedBox(
              width: 70,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white30),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide.none))),
              onPressed: () {},
              child: Icon(Icons.notifications),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            DashboardButton(
              btntitle: "View Track Of Equipment",
              btnicon: FontAwesomeIcons.eye,
              btndestription: "View Track Of Equipment",
              nextpage: ItemTrackScreen(),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardButton(
              btntitle: "Issue Equipment",
              btnicon: FontAwesomeIcons.cartPlus,
              btndestription: "Issue Equipment",
              nextpage: IssueEquipment(),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardButton(
              btntitle: "ADD Update Equipment",
              btnicon: FontAwesomeIcons.pen,
              btndestription: "ADD Update Equipment",
              nextpage: AddUpdateEquipment(),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardButton(
              btntitle: "Accect Equipment",
              btnicon: FontAwesomeIcons.calendarCheck,
              btndestription: "Accect Equipment",
              nextpage: AcceptEquipmentForm(),
            ),
            SizedBox(
              height: 20,
            ),
            DashboardButton(
              btntitle: "Monthly Report",
              btnicon: FontAwesomeIcons.chartBar,
              btndestription: "Monthly Report",
              nextpage: UsageReport(),
            ),
          ],
        ),
      ),
      backgroundColor: AppColor.main_green_background,
    );
  }
}

class DashboardButton extends StatelessWidget {
  final IconData btnicon;
  final String btntitle;
  final String btndestription;
  final Widget nextpage;

  const DashboardButton(
      {Key key,
      this.btnicon,
      this.btntitle,
      this.btndestription,
      this.nextpage})
      : super(key: key);

  Future next(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => nextpage));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => next(context),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide.none))),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Icon(
                      btnicon,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(btntitle,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                        overflow: TextOverflow.fade),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      btndestription,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
