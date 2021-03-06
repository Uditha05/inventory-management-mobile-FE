import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventory_management/services/category.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/widget/equipment.dart';
import 'package:inventory_management/services/iteam.dart';
import 'package:inventory_management/theme/app_colors.dart';
import 'package:inventory_management/widget/search_bar.dart';

class ItemTrackScreen extends StatefulWidget {
  const ItemTrackScreen({Key key}) : super(key: key);

  @override
  _ItemTrackScreenState createState() => _ItemTrackScreenState();
}

class _ItemTrackScreenState extends State<ItemTrackScreen> {
  List<Iteam> equipments = [];
  Category categories;
  bool loading = false;
  @override
  Future setEquipments(quary) async {
    setState(() {
      this.loading = true;
    });
    List<Iteam> result = await Iteam.findIteamsByCatogary(quary);

    setState(() {
      this.equipments = result;
      this.loading = false;
    });
  }

  setCategories() {
    setState(() {});
  }

  void initState() {
    categories = new Category(setCategories);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.main_green_background,
        title: Text('Tracking Details'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 75, 5, 0),
            child: loading
                ? SpinKitFadingCircle(
                    color: Colors.black,
                    size: 50.0,
                  ) //Icon(FontAwesomeIcons.spinner)
                : ListView.builder(
                    itemCount: equipments.length,
                    itemBuilder: (contex, index) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                          child: Equipment(
                            iteam: equipments[index],
                            isviewed: false,
                          ));
                    }),
          ),
          SearchBar(
              setEquipments: setEquipments,
              setQuarysFuntion: categories.findCatogaryByQuary),
        ],
      ),
    );
  }
}
