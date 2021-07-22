import 'dart:convert';
import "package:http/http.dart" as http;
import "package:logger/logger.dart";

class LoginHandler {
  String baseurl = "https://warm-ridge-34462.herokuapp.com";
  var log = Logger();
  dynamic messege;
  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formater(url);
    print("I am here to test");
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    print("I did my work");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var huhu = json.decode(response.body);
      //   log.i("the value of msg is $huhu");
      return response.body;
    } else {}
  }

  Future<dynamic> update(String url, Map<String, String> body) async {
    url = formater(url);
    print(url);
    print(json.encode(body));
    var response = await http.patch(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      return response.body;
    } else {
      print("Nope it ddnt worked");
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
