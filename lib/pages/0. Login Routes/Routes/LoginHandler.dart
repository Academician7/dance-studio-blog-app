import 'dart:convert';
import "package:http/http.dart" as http;
import "package:logger/logger.dart";

class LoginHandler {
  String baseurl = "https://whispering-taiga-05909.herokuapp.com";
  var log = Logger();
  dynamic messege;
  Future<dynamic> post(String url, Map<String, String> body) async {
    url = formater(url);
    print("I reached here first");
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> huhu = json.decode(response.body);
      log.i("the value of msg is ${huhu["msg"]}");
      if (huhu["msg"] == "success")
        messege = huhu["msg"];
      else
        messege = "wrong information";
      return response;
    } else {
      return log.i("wrong information given");
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
