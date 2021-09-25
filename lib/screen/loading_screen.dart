import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

class LoadingPage extends StatelessWidget {
  LoadingPage(this.jwt, this.payload);

  factory LoadingPage.fromBase64(String jwt) => LoadingPage(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;

  @override
  Widget build(BuildContext context) {
    print(payload);
    return Scaffold(
      appBar: AppBar(title: Text("Secret Data Screen")),
      body: Center(
          // child: FutureBuilder(
          //   future: http.read('$SERVER_IP/data', headers: {"Authorization": jwt}),
          //   builder: (context, snapshot) =>
          //     snapshot.hasData ?
          //     Column(children: <Widget>[
          //       Text("${payload['username']}, here's the data:"),
          //       Text(snapshot.data, style: Theme.of(context).textTheme.display1)
          //     ],)
          //     :
          //     snapshot.hasError ? Text("An error occurred") : CircularProgressIndicator()
          // ),
          ),
    );
  }
}
