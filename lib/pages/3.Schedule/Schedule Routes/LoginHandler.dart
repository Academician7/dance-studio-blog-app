import 'dart:convert';
import "package:http/http.dart" as http;
import "package:logger/logger.dart";

class LoginHandler {
  String baseurl = "https://peaceful-ravine-35848.herokuapp.com";
  var log = Logger();
  dynamic messege;

  Future get(String url) async {
    url = formater(url);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formater(url);
    print("I am here to test");
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      //   log.i("the value of msg is $huhu");
      return response.body;
    } else {}
  }

  Future<dynamic> update(String url, Map<String, String> body) async {
    url = formater(url);
    print("I entered heree");
    print("This is th ebody $body");
    var response = await http.patch(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    } else {
      print("Nope it ddnt worked");
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
