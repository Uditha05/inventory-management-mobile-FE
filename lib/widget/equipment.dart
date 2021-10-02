import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/config/asset_config.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/screen/view_track/view_track_details.dart';
import 'package:inventory_management/theme/app_colors.dart';

class Equipment extends StatelessWidget {
  final Iteam iteam;
  final bool isviewed;
  const Equipment({Key key, this.iteam, this.isviewed}) : super(key: key);

  Future show(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViewTrackDetails(iteam: iteam)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.zero),
        color: isviewed ? Colors.white : AppColor.main_green_background,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Container(
                    height: 100,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Image.network(iteam.imgURL)),
              ),
              Container(
                width: 85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      iteam.catogary,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      iteam.model,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      iteam.store_code,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      iteam.lab,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          iteam.isAvailable ? Colors.greenAccent : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        iteam.isAvailable ? "Available" : "Unavailable",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  isviewed
                      ? Container()
                      : ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide.none))),
                          onPressed: () => show(context),
                          child: Icon(Icons.remove_red_eye_sharp))
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.zero,
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.zero),
              color: Colors.grey[400],
            ),
            child: EquipmentAvailable(
              iteam: iteam,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class EquipmentAvailable extends StatelessWidget {
  final Iteam iteam;
  const EquipmentAvailable({Key key, this.iteam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (iteam.isAvailable) {
      return Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.check_circle_outline_sharp,
            color: Colors.green[800],
          ),
          SizedBox(
            width: 5,
          ),
          Text("Available in ${iteam.lab}")
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.dnd_forwardslash_outlined,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Unavailble")
            ],
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Icon(
          //       FontAwesomeIcons.exclamationCircle,
          //       color: Colors.orange,
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     //Text("Available on ${iteam.available_time.toString()}")
          //   ],
          // ),
        ],
      );
    }
  }
}
