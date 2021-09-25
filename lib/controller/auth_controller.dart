import 'dart:convert';

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

    return payload["type"];
  }

  decodeJWT(String jwt) {
    var payload = json.decode(
        ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
    print(payload);
    return payload;
  }
}
