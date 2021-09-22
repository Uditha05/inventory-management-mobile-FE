import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String lang = "English";
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
                      'Sinhala',
                      'English',
                      'Tamil',
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
