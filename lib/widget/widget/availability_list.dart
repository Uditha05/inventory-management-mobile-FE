import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'availability_tile.dart';
import 'package:inventory_management/model/avaiability_detail.dart';

class AvailabilityList extends StatelessWidget {
  final List<AvailabilityDetail> details;
  final String type;
  //final AvailabilityDetailList details;
  //final ScrollController controller;
  //final loadMore;
  AvailabilityList({this.details, this.type});

  Widget build(BuildContext context) {
    //print(details[4].availability);
    // ScrollController controller = new ScrollController()..addListener(loadMore);
    return details.length>0 ?ListView.builder(
      itemBuilder: (context, index) {
        return AvailabilityTile(
          availability: details[index].availability,
          itemDetail: details[index].data,
          availableDate: details[index].availableDate,
          type: type,
        );
      },
      itemCount: details.length,
    ):Center(child: Text('No match item',style: TextStyle(fontWeight: FontWeight.bold),));
  }
}
