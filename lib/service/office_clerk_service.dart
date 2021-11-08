import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:inventory_management/config/api/office_clerk_api.dart';
import 'package:inventory_management/config/constant_data.dart';

import 'package:inventory_management/model/office_clerk_related/repairModel.dart';

class OfficeClerkService {
  final http.Client _client;
  OfficeClerkService() : _client = http.Client();

  @visibleForTesting
  OfficeClerkService.internal(this._client);

  // var headers;
  Future getNewDamageItems() async {
    // //print("Try access " + ConstantData.TOKEN);
    // headers["Authorization"] = 'Bearer ${ConstantData.TOKEN}';
    try {
      var url = Uri.parse(getNewDamageURL);
      var res = await _client.get(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        List<DamageModel> responseModel = damageModelFromJson(res.body);

        return responseModel;
        // return res.body;
      } else {
        // //print("status code : ${res.statusCode}");
        // //print(res.body);
        return null;
      }
    } on Exception catch (e) {
      // //print(e);
      return null;
    }
  }

  Future getPendingRepairItems() async {
    try {
      var url = Uri.parse(getPendingRepair);
      var res = await _client.get(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        List<DamageModel> responseModel = damageModelFromJson(res.body);

        return responseModel;
        // return res.body;
      } else {
        // //print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      //print(e);
      return null;
    }
  }

  Future getOldDamageItem() async {
    //print("Try access");
    try {
      var url = Uri.parse(getOldDamgeItems);
      var res = await _client.get(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        //print(res.body);
        List<DamageModel> responseModel = damageModelFromJson(res.body);

        //print(responseModel.length);
        return responseModel;
        // return res.body;
      } else {
        //print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      //print(e);
      return null;
    }
  }

  Future markSendToRepair(String id) async {
    //print("Try access");
    try {
      var url = Uri.parse(sendToRepair + id);
      //print(sendToRepair + id);
      var res = await _client.put(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        //print(res.body);

        return "pass";
        // return res.body;
      } else {
        //print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      //print(e);
      return null;
    }
  }

  Future markFinishedRepair(String id, String itemId) async {
    //print("Try access");
    try {
      var url = Uri.parse(markRepairFinish + id + "/$itemId");
      //print(url);
      var res = await _client.put(url, headers: {
        "Authorization": 'Bearer ${ConstantData.TOKEN}',
      });

      if (res.statusCode == 200) {
        //print(res.body);
        return "pass";
      } else {
        //print("status code : ${res.statusCode}");
        return null;
      }
    } on Exception catch (e) {
      //print(e);
      return null;
    }
  }
}
