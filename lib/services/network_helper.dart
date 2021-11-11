import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url,this.client);

  final String url;
  final http.Client client;

  //http.Client client = new http.Client();

  Future getData() async {
    http.Response response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }

  Future sendDate(Object obj)async{
    http.Response response = await client.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(obj),
      
    );
    print(response.body);
  }
}
