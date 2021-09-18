import 'package:flutter/material.dart';
import 'package:inventory_management/model/request_detai.dart';
import 'request.dart';

class RequestList extends StatelessWidget {
  final List<RequestDetail> requests;

  RequestList(this.requests);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index){
        return Request(requests[index]);
      },
      itemCount: requests.length,
    );
  }
}
