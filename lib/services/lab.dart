import 'package:inventory_management/api/technical_officer/technical_officer.dart';

class Lab {
  List labs = [];

  Lab(setfun) {
    set(setfun);
  }
  Future set(setfun) async {
    labs = await getLabs(this);
    setfun();
  }

  getid(name) {
    for (int i = 0; i < labs.length; i++) {
      if (labs[i]['labName'] == name) {
        return labs[i]['id'];
      }
    }
  }
}
