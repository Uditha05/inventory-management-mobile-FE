import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inventory_management/config/constant_data.dart';
import 'package:inventory_management/service/auth_service.dart';

class AuthController {
  Future checkLogin(String email, String password) async {
    if (email == "abc@gmail.com" && password == "abc123") {
      return "pass";
    } else {
      return null;
    }
  }

  Future submitUserNamePassword(String email, String password) async {
    var out = await AuthService().attemptLogIn(email, password);
    if (out == null) {
      return null;
    }

    var payload = decodeJWT(out);
    if (payload == null) {
      return null;
    }
    print(payload["type"]);
    print(payload["userID"]);
    ConstantData.USER_ID = payload["userID"].toString();
    //print(payload("email"));
    final localStorage = GetStorage();
    localStorage.write("email", email);
    localStorage.write("password", password);

    return payload["type"];
  }

  decodeJWT(String jwt) {
    var payload = json.decode(
        ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
    print(payload);
    return payload;
  }
}
