import "package:flutter/material.dart";
import 'package:studio_monitor/pages/Drawer.dart';
import 'Feeds.dart';
import 'dart:convert';
import '../Management.dart';
import './Feeds Routes/LoginHandler.dart';
import 'dart:async';
import './Feeds Routes/DeleteHandler.dart';
// import 'package:responsive/pages/Myname.dart';

class FeedsUpdate extends StatefulWidget {
  final postID, username, imgUrl, post, imageurl;
  FeedsUpdate(
      {@required this.postID,
      this.username,
      this.imgUrl,
      this.post,
      this.imageurl});
  @override
  _FeedsUpdateState createState() => _FeedsUpdateState();
}

class _FeedsUpdateState extends State<FeedsUpdate> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  bool clicked = false;
  var preText;
  var preUrl;

  final _globalkey = GlobalKey<FormState>();

  LoginHandler loginHandler = LoginHandler();

  DeleteHandler deleteHandler = DeleteHandler();

  TextEditingController _postController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _imageurlController = TextEditingController();
  String errorText;
  bool validate = false;
  // bool circular = false;

  bool authenticated = false;

  dynamic globaldata;

  String profilebuddyname;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Go back to Feeds?"),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Management(
                                      username: widget.username,
                                      imgUrl: widget.imgUrl,
                                    )));
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
          title: Text("Update Post"),
          actions: [
            IconButton(
              icon: Icon(Icons.list_alt),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Go back to Feeds?"),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Management(
                                              username: widget.username,
                                              imgUrl: widget.imgUrl,
                                            )));
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _globalkey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.imageurl),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          postTextField("Edit Post"),
                          //     emailTextField("Email"),
                          imageurlTextField("Give the Image Url"),
                          SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () async {
                              setState(() {
                                clicked = true;
                                preText = _postController.text;
                                preUrl = _imageurlController.text;
                              });
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var postedbyname = widget.username;
                              if (_globalkey.currentState.validate()) {
                                print(widget.username);
                                // send the data to API
                                Map<String, String> data = {
                                  "postedby": postedbyname,
                                  "post": _postController.text,
                                  "imageurl": _imageurlController.text
                                };
                                var response = await loginHandler.update(
                                    "/user/update/${widget.postID}", data);

                                print(response);
                                var decoding = json.decode(response);
                                if (decoding['msg'] == "Successfully Updated") {
                                  print("Job Done");
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Successfully Updated"),
                                        );
                                      });
                                  Timer(Duration(seconds: 1), () {
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
                                  "UPDATE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          InkWell(
                            onTap: () async {
                              print(widget.postID);
                              var response = await deleteHandler
                                  .delete("/user/delete/${widget.postID}");
                              print(json.decode(response));
                              var decoding = json.decode(response);
                              if (decoding['msg'] == "Post deleted") {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Successfully Deleted"),
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
                            },
                            child: Container(
                              height: 60,
                              width: 250,
                              decoration: BoxDecoration(
                                  color: Colors.redAccent[700],
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(50),
                                      right: Radius.circular(50)),
                                  border: Border.all(
                                      color: Colors.black, width: 3)),
                              child: Center(
                                child: Text(
                                  "DELETE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Colors.white),
                                ),
                              ),
                            ),
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
    if (clicked == false) {
      _postController.text = widget.post;
      _postController.selection = TextSelection.fromPosition(
          TextPosition(offset: _postController.text.length));
    } else {
      _postController.text = preText;
    }

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
    if (clicked == false) {
      _imageurlController.text = widget.imageurl;
      _imageurlController.selection = TextSelection.fromPosition(
          TextPosition(offset: _imageurlController.text.length));
    } else {
      _imageurlController.text = preUrl;
    }
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
