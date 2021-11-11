import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String lang = "English";

  @override
  void initState() {
    super.initState();
    getAppLanguage();
    loadLanguage();
  }

  void loadLanguage() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("language", "English");
    // if (prefs.getString("language") == null) {
    //   prefs.setString("language", "English");
    // } else if (prefs.getString("language") == "English") {
    //   setState(() {
    //     lang = "English";
    //   });
    // } else {
    //   setState(() {
    //     lang = "සිංහල";
    //   });
    // }
  }

  void updateLanguage() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // if (prefs.getString("language") == null) {
    //   prefs.setString("language", "English");
    // }
    if (lang == "සිංහල") {
      var locale = Locale('si', 'LK');
      Get.updateLocale(locale);
      // prefs.setString("language", "සිංහල");
      print("language change");
    } else {
      var locale = Locale('en', 'US');
      Get.updateLocale(locale);
      // prefs.setString("language", "English");
      print("language change");
    }
  }

  void getAppLanguage() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Change the language:",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: DropdownButton<String>(
                    items: <String>[
                      'සිංහල',
                      'English',
                    ].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        lang = value;
                        print(lang);
                        updateLanguage();
                      });
                    },
                    value: lang,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
