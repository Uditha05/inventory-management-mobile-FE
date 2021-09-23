import 'package:http/http.dart' as http;
import 'package:inventory_management/config/api/auth_api.dart';

class AuthService {
  Future<String> attemptLogIn(String username, String password) async {
    try {
      var url = Uri.parse(loginURL);
      var res = await http
          .post(url, body: {"username": username, "password": password});
      if (res.statusCode == 200) {
        return res.body;
      } else {}
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
