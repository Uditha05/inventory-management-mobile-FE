import 'package:flutter/material.dart';
import 'package:inventory_management/model/avaiability_detail.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/widget/availability_list.dart';

class SearchPage extends StatefulWidget {
  List<AvailabilityDetail> lst;
  String type;
   SearchPage(this.lst,this.type);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String inp;
  List<AvailabilityDetail>searchlst=[];
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.main_green_background,
      appBar: AppBar(
          // The search area here
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
                prefixIcon: IconButton(icon: Icon(Icons.search),onPressed: (){print(inp);},),
                // suffixIcon: IconButton(
                //   icon: Icon(Icons.clear),
                //   onPressed: () {
                //     inp='';
                //   },
                // ),
                hintText: 'Search...',
                border: InputBorder.none),
            onChanged: (calue){
              setState(() {
                searchlst = widget.lst.where((element) => element.data.category.toLowerCase().contains(calue.toLowerCase())).toList();
              });
            },
          ),
        ),
      )),
      body: Column(children: [
        Expanded(child: AvailabilityList(details: _textEditingController.text.isNotEmpty?searchlst:widget.lst,type:widget.type)),
      ],),
    );
  }
}