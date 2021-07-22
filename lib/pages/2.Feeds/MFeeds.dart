import "package:flutter/material.dart";
import 'package:studio_monitor/pages/Drawer.dart';
import 'Feeds.dart';
import 'dart:convert';
import 'Feeds Routes/LoginHandler.dart';

import 'dart:async';

// import 'package:responsive/pages/Myname.dart';

class MFeeds extends StatefulWidget {
  final username, imgUrl;
  MFeeds({@required this.username, this.imgUrl});
  @override
  _MFeedsState createState() => _MFeedsState();
}

class _MFeedsState extends State<MFeeds> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  final _globalkey = GlobalKey<FormState>();

  LoginHandler loginHandler = LoginHandler();

  TextEditingController _postController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _imageurlController = TextEditingController();
  String errorText;
  bool validate = false;
  // bool circular = false;

  bool authenticated = false;

  dynamic globaldata;

  String profilebuddyname;

  var preview =
      "https://st4.depositphotos.com/14953852/24787/v/600/depositphotos_247872612-stock-illustration-no-image-available-icon-vector.jpg";
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Return Back to Feeds?"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Feeds(
                                      username: widget.username,
                                      imgUrl: widget.imgUrl,
                                    )));
                      },
                      child: Icon(Icons.check)),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.cancel)),
                ],
              );
            });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MyDrawer(
          username: widget.username,
          imgUrl: widget.imgUrl,
        ),
        appBar: AppBar(
          title: Text("Create Post"),
          actions: [
            IconButton(
              icon: Icon(Icons.list_alt),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Return Back to Feeds?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Feeds(
                                              username: widget.username,
                                              imgUrl: widget.imgUrl,
                                            )));
                              },
                              child: Icon(Icons.check)),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.cancel)),
                        ],
                      );
                    });
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.width / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(preview), fit: BoxFit.cover)),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _globalkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          postTextField("Write Post"),
                          //     emailTextField("Email"),
                          imageurlTextField("Give the Image Url"),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              setState(() {
                                preview = _imageurlController.text;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              height: 30,
                              color: Colors.blue[900],
                              child: Center(
                                child: Text(
                                  "PREVIEW",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          InkWell(
                            onTap: () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var postedbyname = widget.username;
                              //  await checkUser();
                              //      if (_globalkey.currentState.validate() && validate) {
                              if (_globalkey.currentState.validate()) {
                                print(widget.username);
                                // send the data to API
                                Map<String, String> data = {
                                  "postedby": postedbyname,
                                  "post": _postController.text,
                                  "imageurl": _imageurlController.text
                                };
                                print(data);
                                var response = await loginHandler.post(
                                    "/user/register", data);
                                print(response);
                                var decoding = json.decode(response);
                                if (decoding == "$postedbyname Posted now") {
                                  print("Job Done");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Successfully Posted"),
                                        );
                                      });
                                  Timer(Duration(seconds: 3), () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Feeds(
                                                  username: widget.username,
                                                  imgUrl: widget.imgUrl,
                                                )));
                                  });
                                } else {
                                  print("NOpe got world to turn down");
                                }
                                //globaldata = data;
                                //print("This is to print global data $globaldata");
                              } else {}
                            },
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.pink,
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(50),
                                      right: Radius.circular(50)),
                                  border: Border.all(
                                      color: Colors.black, width: 3)),
                              child: Center(
                                child: Text(
                                  "POST",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget postTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(children: [
        Text(
          "$label",
          style: TextStyle(color: Colors.black),
        ),
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return "Post cant be empty";
            } else {
              return null;
            }
          },
          controller: _postController,
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

  Widget imageurlTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(children: [
        Text(
          "$label",
          style: TextStyle(color: Colors.black),
        ),
        TextFormField(
          controller: _imageurlController,
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
}
