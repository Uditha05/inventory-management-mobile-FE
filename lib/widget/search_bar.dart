import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  @override
  final Function setEquipments;
  final Function setQuarysFuntion;

  SearchBar({this.setEquipments, this.setQuarysFuntion});
  _SearchBarState createState() => _SearchBarState(
      setEquipments: setEquipments, setQuarysFuntion: setQuarysFuntion);
}

class _SearchBarState extends State<SearchBar> {
  List<SearchString> seach_list = [];
  final controller = FloatingSearchBarController();
  final Function setEquipments;
  final Function setQuarysFuntion;

  String searchTerm = '';
  _SearchBarState({this.setEquipments, this.setQuarysFuntion});

  Future quarySeach(String quary) async {
    List result = await setQuarysFuntion(quary);
    print(result);
    setState(() {
      seach_list = result
          .map((e) => SearchString(query: e, searchIteam: searchIteam))
          .toList();
    });
  }

  Future searchIteam(iteam_name) async {
    controller.close();
    setState(() {
      controller.query = iteam_name['categoryName'];
      searchTerm = iteam_name['categoryName'];
    });
    setEquipments(iteam_name['id']);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      hint: controller.query.isNotEmpty ? searchTerm : 'Enter catogary',
      controller: controller,
      onQueryChanged: (query) {
        if (query.isNotEmpty) {
          quarySeach(query);
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            // icon: const Icon(Icons.search),
            onPressed: () {}, icon: null,
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: seach_list.toList(),
            ),
          ),
        );
      },
    );
  }
}

class SearchString extends StatelessWidget {
  final query;
  final Function searchIteam;
  const SearchString({this.query, this.searchIteam});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        color: Colors.grey[200],
        child: ListTile(
          onTap: () => searchIteam(query),
          title: Text(query['categoryName']),
        ),
      ),
    );
  }
}
