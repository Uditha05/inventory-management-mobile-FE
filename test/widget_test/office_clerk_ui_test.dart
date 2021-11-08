import 'package:flutter_test/flutter_test.dart';
import 'package:inventory_management/main.dart';
import 'package:inventory_management/screen/login/login_screen.dart';

void main() {
  testWidgets("Login page", (tester) async {
    await tester.pumpWidget(MyApp());

    await expectLater(
        find.byType(LoginScreen), matchesGoldenFile("golden/logoScreen.png"));
  });
}
