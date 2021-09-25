import 'package:flutter/material.dart';
import 'package:inventory_management/model/dummy/avaiability_detail.dart';
import 'availability_tile.dart';

class AvailabilityList extends StatelessWidget {
  final List<AvailabilityDetail> details;
  final String type;
  AvailabilityList(this.details, this.type);

  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
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