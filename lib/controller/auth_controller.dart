class AuthController {
  Future checkLogin(String email, String password) async {
    if (email == "abc@gmail.com" && password == "abc123") {
      return "pass";
    } else {
      return null;
    }
  }
}
