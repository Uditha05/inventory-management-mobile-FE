import 'package:flutter/material.dart';
import 'availability_tile.dart';
import 'package:inventory_management/model/avaiability_detail.dart';

class AvailabilityList extends StatelessWidget {
  final List<AvailabilityDetail> details;
  //final AvailabilityDetailList details;
  final String type;
  AvailabilityList(this.details,this.type);

  Widget build(BuildContext context) {
    //print(details[4].availability);
    return ListView.builder(
      itemBuilder: (context, index){
        return AvailabilityTile(
          availability: details[index].availability,
          itemDetail: details[index].data,
          availableDate: details[index].availableDate,
          type: type,
        );
      },
      itemCount: details.length,
    );
  }
}
