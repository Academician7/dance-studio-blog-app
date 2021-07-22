import "package:flutter/material.dart";
import 'package:studio_monitor/pages/Drawer.dart';

import './TeacherPortfolio.dart';
import 'dart:convert';
import 'dart:async';
import './TeacherProfile Routes/LoginHandler.dart';
// import 'package:responsive/pages/Myname.dart';

class UpdateTeacherProfile extends StatefulWidget {
  final managementUser,
      managementImgUrl,
      id,
      teachername,
      url,
      phone,
      address,
      password;
  UpdateTeacherProfile(
      {@required this.managementUser,
      this.managementImgUrl,
      this.id,
      this.teachername,
      this.url,
      this.phone,
      this.address,
      this.password});
  @override
  _UpdateTeacherProfileState createState() => _UpdateTeacherProfileState();
}

class _UpdateTeacherProfileState extends State<UpdateTeacherProfile> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  bool clicked = false;
  var preTeachername;
  var prePhone;
  var preAddress;
  var prePassword;
  var preImageUrl;

  final _globalkey = GlobalKey<FormState>();

  LoginHandler loginHandler = LoginHandler();

  TextEditingController _teachernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
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
                title: Text("Go back to Portfolio?"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.pop(context);
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
          username: widget.managementUser,
          imgUrl: widget.managementImgUrl,
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
                        title: Text("Go back to Portfolio?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pop(context);
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
                        studionameTextField("Teacher Name"),
                        contactTextField("Phone Number"),
                        addressTextField("Address"),
                        ownerTextField("Password"),
                        imageurlTextField("ImageUrl"),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              clicked = true;
                              preTeachername = _teachernameController.text;
                              prePhone = _phoneController.text;
                              preAddress = _addressController.text;
                              prePassword = _passwordController.text;
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
                                "username": _teachernameController.text,
                                "phone": _phoneController.text,
                                "address": _addressController.text,
                                "password": _passwordController.text,
                                "url": _imageurlController.text
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
                                          builder: (context) =>
                                              TeacherPortfolio(
                                                  managementUser:
                                                      widget.managementUser,
                                                  managementImgUrl:
                                                      widget.managementImgUrl,
                                                  id: widget.id,
                                                  username: data['username'],
                                                  url: data['url'],
                                                  phone: data['phone'],
                                                  address: data['address'],
                                                  password: data['password'])));
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
      _teachernameController.text = widget.teachername;
      _teachernameController.selection = TextSelection.fromPosition(
          TextPosition(offset: _teachernameController.text.length));
    } else {
      _teachernameController.text = preTeachername;
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
          controller: _teachernameController,
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
      _phoneController.text = widget.phone;
      _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length));
    } else {
      _phoneController.text = prePhone;
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
          controller: _phoneController,
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
      _passwordController.text = widget.password;
      _passwordController.selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length));
    } else {
      _passwordController.text = prePassword;
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
          controller: _passwordController,
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
      _imageurlController.text = widget.url;
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
