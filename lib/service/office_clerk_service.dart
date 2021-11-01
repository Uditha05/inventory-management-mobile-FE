import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:inventory_management/config/api/office_clerk_api.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/model/office_clerk_related/broken_item_model.dart';

class OfficeClerkService {
  // var headers;
  Future getNewDamageItems() async {
    print("Try access " + ConstantData.TOKEN);
    // headers["Authorization"] = 'Bearer ${ConstantData.TOKEN}';
    try {
      var url = Uri.parse(getNewDamageURL);
      var res = await http.get(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        print(res.body);
        List<BrokenItems> responseModel = brokenItemsFromJson(res.body);

        print(responseModel.length);
        return responseModel;
        // return res.body;
      } else {
        print("status code : ${res.statusCode}");
        print(res.body);
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future getPendingRepairItems() async {
    print("Try access");
    try {
      var url = Uri.parse(getPendingRepair);
      var res = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + ConstantData.TOKEN,
      });

      if (res.statusCode == 200) {
        print(res.body);
        List<BrokenItems> responseModel = brokenItemsFromJson(res.body);

        print(responseModel.length);
        return responseModel;
        // return res.body;
      } else {
        print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future getOldDamageItem() async {
    print("Try access");
    try {
      var url = Uri.parse(getOldDamgeItems);
      var res = await http.get(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + ConstantData.TOKEN,
      });

      if (res.statusCode == 200) {
        print(res.body);
        List<BrokenItems> responseModel = brokenItemsFromJson(res.body);

        print(responseModel.length);
        return responseModel;
        // return res.body;
      } else {
        print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future markSendToRepair(String id) async {
    print("Try access");
    try {
      var url = Uri.parse(sendToRepair + id);
      print(sendToRepair + id);
      var res = await http.put(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + ConstantData.TOKEN,
      });

      if (res.statusCode == 200) {
        print(res.body);

        return "pass";
        // return res.body;
      } else {
        print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }

  Future markFinishedRepair(String id) async {
    print("Try access");
    try {
      var url = Uri.parse(markRepairFinish + id);
      print(sendToRepair + id);
      var res = await http.put(url, headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + ConstantData.TOKEN,
      });

      if (res.statusCode == 200) {
        print(res.body);

        return "pass";
        // return res.body;
      } else {
        print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
