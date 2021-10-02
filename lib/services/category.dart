import 'package:inventory_management/api/technical_officer/technical_officer.dart';

class Category {
  List categories = [];
  Category(setfun) {
    set(setfun);
  }
  Future set(setfun) async {
    categories = await getCategories(this);
    setfun();
  }

  List findCatogaryByQuary(String quary) {
    List result = [];
    for (int i = 0; i < categories.length; i++) {
      if (quary.length < categories[i]['categoryName'].length &&
          categories[i]['categoryName']
                  .substring(0, quary.length)
                  .toLowerCase() ==
              (quary)) {
        result.add(categories[i]);
      }
    }
    return result;
  }

  getid(name) {
    for (int i = 0; i < categories.length; i++) {
      if (categories[i]['categoryName'] == name) {
        return categories[i]['id'];
      }
    }
  }
}
