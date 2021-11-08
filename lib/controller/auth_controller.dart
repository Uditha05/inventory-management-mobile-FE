import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import 'package:inventory_management/service/auth_service.dart';

class AuthController {
  Future submitUserNamePassword(String email, String password) async {
    var out = await AuthService().attemptLogIn(email, password);
    if (out == null) {
      return null;
    }

    var payload = decodeJWT(out);
    if (payload == null) {
      return null;
    }
    print(payload);
    final localStorage = GetStorage();
    localStorage.write("email", email);
    localStorage.write("password", password);

    return payload["type"];
  }

  decodeJWT(String jwt) {
    // print("Jwt $jwt");
    var payload = json.decode(
        ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))));
    // print("payload $payload");
    return payload;
  }
}
