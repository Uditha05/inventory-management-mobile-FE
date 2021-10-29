import 'package:inventory_management/api/technical_officer/technical_officer.dart';

class Model {
  List models = [];
  var id;
  Model(cat, setfun) {
    id = cat;
    set(setfun);
  }
  Future set(setfun) async {
    models = await getModels(this);
    setfun();
  }

  getid(name) {
    for (int i = 0; i < models.length; i++) {
      if (models[i]['modelName'] == name) {
        return models[i]['id'];
      }
    }
  }
}
