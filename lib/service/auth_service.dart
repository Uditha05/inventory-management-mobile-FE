import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:inventory_management/config/api/auth_api.dart';
import 'package:inventory_management/config/constant_data.dart';

class AuthService {
  final http.Client _client;
  AuthService() : _client = http.Client();

  @visibleForTesting
  AuthService.internal(this._client);

  Future attemptLogIn(
    String username,
    String password,
  ) async {
    print("Try access");
    try {
      var url = Uri.parse(loginURL);
      var res = await _client
          .post(url, body: {"email": username, "password": password});

      if (res.statusCode != null && res.statusCode == 200) {
        final parsed = json.decode(res.body);
        ConstantData.TOKEN = parsed['token'].toString();

        return res.body;
      } else {
        return null;
      }
    } on Exception catch (e) {
      return null;
    }
  }

  Future testLogin(
    String username,
    String password,
  ) async {
    print("Try access");
    try {
      var url = Uri.parse(loginURL);
      var res = await _client.get(url);
      if (res.statusCode == 200) {
        return res.body;
      } else {
        return null;
      }
    } on Exception catch (e) {
      print(e);

      return null;
    }
  }
}
