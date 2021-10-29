import 'package:flutter/material.dart';
import 'package:inventory_management/screen/office_clerk/handle_damage/mark_request_screen.dart';
import 'package:inventory_management/screen/office_clerk/handle_damage/new_request_screen.dart';
import 'package:inventory_management/screen/office_clerk/handle_damage/old_request_screen.dart';
import 'package:get/get.dart';

class HandleDamage extends StatefulWidget {
  HandleDamage({Key key}) : super(key: key);

  @override
  _HandleDamageState createState() => _HandleDamageState();
}

class _HandleDamageState extends State<HandleDamage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'NEW REQUESTS'.tr),
              Tab(
                text: 'MARK REPAIR'.tr,
              ),
              Tab(
                text: 'OLD REQUEST'.tr,
              ),
            ],
          ),
          title: Text('Handle Request'.tr),
        ),
        body: Container(
          child: TabBarView(
            children: [
              NewRequestScreen(),
              MarkRequestScreen(),
              OldRequestScreen()
            ],
          ),
        ),
      ),
    );
  }
}
