import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_management/config/api/auth_api.dart';
import 'package:inventory_management/config/api/office_clerk_api.dart';
import 'package:inventory_management/model/response/broken_item_model.dart';
import 'package:inventory_management/model/response/response_model.dart';

class OfficeClerkService {
  Future getNewDamageItems() async {
    print("Try access");
    try {
      var url = Uri.parse(getNewDamageURL);
      var res = await http.get(url);

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
}
