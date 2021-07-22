import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class CardExperiment extends StatefulWidget {
  @override
  _CardExperimentState createState() => _CardExperimentState();
}

class _CardExperimentState extends State<CardExperiment> {
  TextEditingController _usernameController = TextEditingController();

  var url = "https://sheltered-scrubland-28525.herokuapp.com/user/";
  var data;
  var backgroundColor = 0;
  var textColor = 0;
  var appbarColor = 0;
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    //  print(data);
    // print(data[1]['username']);
    setState(() {});
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Client List"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: data != null
          ? ListView.builder(
              itemBuilder: (context, index) {
                _usernameController.text = data[index]['username'];
                return Column(
                  children: [
                    usernameTextField("username"),
                    Container(
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.green,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      height: 50,
                      width: 300,
                      child: Center(
                        child: Text(
                          data[index]['username'],
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
                  ],
                );
              },
              itemCount: 1,
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //      print("The value of x $data");
          //    print("The value of json object ${data[0]}");
          //    print("The value of object data ${data[0]["_id"]}");
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (BuildContext context) => Homepage()));
          setState(() {});
        },
        child: Icon(Icons.send),
        backgroundColor: Colors.blue[900],
      ),
    );
  }

  Widget usernameTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(children: [
        Text(
          "$label",
          style: TextStyle(color: Colors.black),
        ),
        TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
              //            errorText: validate ? null : errorText,
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ))),
        )
      ]),
    );
  }

  Widget controller(String x) {
    _usernameController.text = x;
    return usernameTextField("username");
  }
}
