import "package:flutter/material.dart";
import 'package:studio_monitor/pages/Drawer.dart';
import 'Schedule.dart';
import 'dart:convert';
import '../Management.dart';
import 'dart:async';
import './Schedule Routes/LoginHandler.dart';
// import 'package:responsive/pages/Myname.dart';

class MSchedule extends StatefulWidget {
  final id,
      imgUrl,
      studioname,
      saturday3,
      saturday4,
      saturday5,
      saturday6,
      saturday7,
      sunday3,
      sunday4,
      sunday5,
      sunday6,
      sunday7;
  MSchedule(
      {@required this.id,
      this.imgUrl,
      this.studioname,
      this.saturday3,
      this.saturday4,
      this.saturday5,
      this.saturday6,
      this.saturday7,
      this.sunday3,
      this.sunday4,
      this.sunday5,
      this.sunday6,
      this.sunday7});
  @override
  _MScheduleState createState() => _MScheduleState();
}

class _MScheduleState extends State<MSchedule> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  bool clicked = false;
  var preSaturday3;
  var preSaturday4;
  var preSaturday5;
  var preSaturday6;
  var preSaturday7;
  var preSunday3;
  var preSunday4;
  var preSunday5;
  var preSunday6;
  var preSunday7;

  final _globalkey = GlobalKey<FormState>();

  LoginHandler loginHandler = LoginHandler();

  TextEditingController _saturday3Controller = TextEditingController();
  TextEditingController _saturday4Controller = TextEditingController();
  TextEditingController _saturday5Controller = TextEditingController();
  TextEditingController _saturday6Controller = TextEditingController();
  TextEditingController _saturday7Controller = TextEditingController();
  TextEditingController _sunday3Controller = TextEditingController();
  TextEditingController _sunday4Controller = TextEditingController();
  TextEditingController _sunday5Controller = TextEditingController();
  TextEditingController _sunday6Controller = TextEditingController();
  TextEditingController _sunday7Controller = TextEditingController();

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
                title: Text("Go back to Schedule?"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedule(
                                      username: widget.studioname,
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
          username: widget.studioname,
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
                        title: Text("Go back to Schedule?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Schedule(
                                              username: widget.studioname,
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
                                              username: widget.studioname,
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
                  height: 1200,
                  width: MediaQuery.of(context).size.width,
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Saturday",
                          style: TextStyle(fontSize: 40),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        saturday3TextField("3-4 PM"),
                        saturday4TextField("4-5 PM"),
                        saturday5TextField("5-6 PM"),
                        saturday6TextField("6-7 PM"),
                        saturday7TextField("7-8 PM"),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sunday",
                          style: TextStyle(fontSize: 40),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        sunday3TextField("3-4 PM"),
                        sunday4TextField("4-5 PM"),
                        sunday5TextField("5-6 PM"),
                        sunday6TextField("6-7 PM"),
                        sunday7TextField("7-8 PM"),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              clicked = true;
                              preSaturday3 = _saturday3Controller.text;
                              preSaturday4 = _saturday4Controller.text;
                              preSaturday5 = _saturday5Controller.text;
                              preSaturday6 = _saturday6Controller.text;
                              preSaturday7 = _saturday7Controller.text;
                              preSunday3 = _sunday3Controller.text;
                              preSunday4 = _sunday4Controller.text;
                              preSunday5 = _sunday5Controller.text;
                              preSunday6 = _sunday6Controller.text;
                              preSunday7 = _sunday7Controller.text;
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
                                "saturday3": _saturday3Controller.text,
                                "saturday4": _saturday4Controller.text,
                                "saturday5": _saturday5Controller.text,
                                "saturday6": _saturday6Controller.text,
                                "saturday7": _saturday7Controller.text,
                                "sunday3": _sunday3Controller.text,
                                "sunday4": _sunday4Controller.text,
                                "sunday5": _sunday5Controller.text,
                                "sunday6": _sunday6Controller.text,
                                "sunday7": _sunday7Controller.text,
                              };
                              print(widget.id);
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
                                          builder: (context) => Schedule(
                                                username: widget.studioname,
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

  Widget saturday3TextField(String label) {
    if (clicked == false) {
      _saturday3Controller.text = widget.saturday3;
      _saturday3Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _saturday3Controller.text.length));
    } else {
      _saturday3Controller.text = preSaturday3;
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
          controller: _saturday3Controller,
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

  Widget saturday4TextField(String label) {
    if (clicked == false) {
      _saturday4Controller.text = widget.saturday4;
      _saturday4Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _saturday4Controller.text.length));
    } else {
      _saturday4Controller.text = preSaturday4;
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
          controller: _saturday4Controller,
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

  Widget saturday5TextField(String label) {
    if (clicked == false) {
      _saturday5Controller.text = widget.saturday5;
      _saturday5Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _saturday5Controller.text.length));
    } else {
      _saturday5Controller.text = preSaturday5;
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
          controller: _saturday5Controller,
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

  Widget saturday6TextField(String label) {
    if (clicked == false) {
      _saturday6Controller.text = widget.saturday6;
      _saturday6Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _saturday6Controller.text.length));
    } else {
      _saturday6Controller.text = preSaturday6;
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
          controller: _saturday6Controller,
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

  Widget saturday7TextField(String label) {
    if (clicked == false) {
      _saturday7Controller.text = widget.saturday7;
      _saturday7Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _saturday7Controller.text.length));
    } else {
      _saturday7Controller.text = preSaturday7;
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
          controller: _saturday7Controller,
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

  Widget sunday3TextField(String label) {
    if (clicked == false) {
      _sunday3Controller.text = widget.sunday3;
      _sunday3Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _sunday3Controller.text.length));
    } else {
      _sunday3Controller.text = preSunday3;
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
          controller: _sunday3Controller,
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

  Widget sunday4TextField(String label) {
    if (clicked == false) {
      _sunday4Controller.text = widget.sunday4;
      _sunday4Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _sunday4Controller.text.length));
    } else {
      _sunday4Controller.text = preSunday4;
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
          controller: _sunday4Controller,
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

  Widget sunday5TextField(String label) {
    if (clicked == false) {
      _sunday5Controller.text = widget.sunday5;
      _sunday5Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _sunday5Controller.text.length));
    } else {
      _sunday5Controller.text = preSunday5;
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
          controller: _sunday5Controller,
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

  Widget sunday6TextField(String label) {
    if (clicked == false) {
      _sunday6Controller.text = widget.sunday6;
      _sunday6Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _sunday6Controller.text.length));
    } else {
      _sunday6Controller.text = preSunday6;
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
          controller: _sunday6Controller,
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

  Widget sunday7TextField(String label) {
    if (clicked == false) {
      _sunday7Controller.text = widget.sunday7;
      _sunday7Controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _sunday7Controller.text.length));
    } else {
      _sunday7Controller.text = preSunday7;
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
          controller: _sunday7Controller,
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
