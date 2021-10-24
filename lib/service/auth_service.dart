import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:inventory_management/config/api/auth_api.dart';
import 'package:inventory_management/config/constant_data.dart';

class AuthService {
  Future attemptLogIn(String username, String password) async {
    print("Try access");
    try {
      var url = Uri.parse(loginURL);
      var res =
          await http.post(url, body: {"email": username, "password": password});

      if (res.statusCode == 200) {
        print(res.body);
        final parsed = json.decode(res.body);
        ConstantData.TOKEN = parsed['token'].toString();
        // print("res.body ${parsed['token']}");
        return res.body;
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
