import "package:flutter/material.dart";
import 'package:studio_monitor/pages/Drawer.dart';
import './StudioProfile.dart';
import 'dart:convert';
import '../Management.dart';
import 'dart:async';
import './StudioProfile Routes/LoginHandler.dart';
// import 'package:responsive/pages/Myname.dart';

class UpdateStudioProfile extends StatefulWidget {
  final id, username, imgUrl, contact, address, owner;
  UpdateStudioProfile(
      {@required this.id,
      this.username,
      this.imgUrl,
      this.contact,
      this.address,
      this.owner});
  @override
  _UpdateStudioProfileState createState() => _UpdateStudioProfileState();
}

class _UpdateStudioProfileState extends State<UpdateStudioProfile> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  bool clicked = false;
  var preStudioname;
  var preContact;
  var preAddress;
  var preOwner;
  var preImageUrl;

  final _globalkey = GlobalKey<FormState>();

  LoginHandler loginHandler = LoginHandler();

  TextEditingController _studionameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _ownerController = TextEditingController();
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
                title: Text("Go back to Studio Profile?"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudioProfile(
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
                        title: Text("Go back to Studio Profile?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StudioProfile(
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 800,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        studionameTextField("Studioname"),
                        contactTextField("Contact"),
                        addressTextField("Address"),
                        ownerTextField("Owner Name"),
                        imageurlTextField("ImageUrl"),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              clicked = true;
                              preStudioname = _studionameController.text;
                              preContact = _contactController.text;
                              preAddress = _addressController.text;
                              preOwner = _ownerController.text;
                              preImageUrl = _imageurlController.text;
                            });
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            if (_globalkey.currentState.validate()) {
                              print(widget.id);
                              // send the data to API
                              Map<String, String> data = {
                                "studioname": _studionameController.text,
                                "contact": _contactController.text,
                                "address": _addressController.text,
                                "owner": _ownerController.text,
                                "imageurl": _imageurlController.text
                              };

                              var response = await loginHandler.update(
                                  "/user/update/${widget.id}", data);

                              var decoding = json.decode(response);
                              if (decoding['msg'] == "Successfully Updated") {
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
                                          builder: (context) => StudioProfile(
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
                                border:
                                    Border.all(color: Colors.black, width: 3)),
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
                      ],
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

  Widget studionameTextField(String label) {
    if (clicked == false) {
      _studionameController.text = widget.username;
      _studionameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _studionameController.text.length));
    } else {
      _studionameController.text = preStudioname;
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
          controller: _studionameController,
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

  Widget contactTextField(String label) {
    if (clicked == false) {
      _contactController.text = widget.contact;
      _contactController.selection = TextSelection.fromPosition(
          TextPosition(offset: _contactController.text.length));
    } else {
      _contactController.text = preContact;
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
          controller: _contactController,
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

  Widget addressTextField(String label) {
    if (clicked == false) {
      _addressController.text = widget.address;
      _addressController.selection = TextSelection.fromPosition(
          TextPosition(offset: _addressController.text.length));
    } else {
      _addressController.text = preAddress;
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
          controller: _addressController,
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

  Widget ownerTextField(String label) {
    if (clicked == false) {
      _ownerController.text = widget.owner;
      _ownerController.selection = TextSelection.fromPosition(
          TextPosition(offset: _ownerController.text.length));
    } else {
      _ownerController.text = preOwner;
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
          controller: _ownerController,
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
      _imageurlController.text = widget.imgUrl;
      _imageurlController.selection = TextSelection.fromPosition(
          TextPosition(offset: _imageurlController.text.length));
    } else {
      _imageurlController.text = preImageUrl;
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
