// import 'dart:convert';

import '../Management.dart';
import 'package:flutter/material.dart';
// import './NetworkHandler.dart';
import 'Routes/SignupHandler.dart';
// import './Welcome.dart';
import 'Routes/LoginHandler.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool vis = true;

  void toggle() {
    setState(() {
      vis = !vis;
    });
  }

  final _globalkey = GlobalKey<FormState>();

  NetworkHandler networkHandler = NetworkHandler();

  LoginHandler loginHandler = LoginHandler();

  TextEditingController _studionameController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  String errorText;
  bool validate = false;
  // bool circular = false;

  bool authenticated = false;

  dynamic globaldata;

  String profilebuddyname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.pink[600]),
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://i.pinimg.com/originals/cc/4c/ec/cc4cec2d63f978b4f7e5dbfc59cc85b9.png"),
                          fit: BoxFit.cover))),
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
                        studionameTextField("Studio Name"),
                        //     emailTextField("Email"),
                        contactTextField("Contact Number"),
                        SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            //  await checkUser();
                            //      if (_globalkey.currentState.validate() && validate) {
                            if (_globalkey.currentState.validate()) {
                              // send the data to API
                              Map<String, String> data = {
                                "studioname": _studionameController.text,
                                "contact": _contactController.text
                              };
                              print(data);
                              await loginHandler.post("/user/login", data);
                              globaldata = data;
                              print("This is to print global data $globaldata");

                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              //////  the way of accessing object variable dynamicallly inside of the data object
                              /////  and showing it in log.i using response.body

                              // this is a way of of doing async thing with if else
                              // if (data["data"] == null) {
                              //   networkHandler.post("/user/register", data);
                              //   networkHandler.get("/user/${data["username"]}");
                              // } else {
                              //   networkHandler.get("/user/${data["username"]}");
                              //   networkHandler.post("/user/register", data);
                              // }

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (BuildContext context) =>
                              //             WelcomePage()));
                              // setState(() {
                              //   circular = false;
                              // });
                            } else {
                              // setState(() {
                              //   circular = false;
                              // });
                            }
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
                                "SIGN IN",
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
                        Container(
                          child: (loginHandler.messege == "success")
                              ? FloatingActionButton(
                                  child: Icon(Icons.send),
                                  onPressed: () async {
                                    if (loginHandler.messege == "success") {
                                      //  print(globaldata["studioname"]);
                                      String studioNayme =
                                          globaldata["studioname"];
                                      //    passUserData(studioNayme);
                                      passUserData(studioNayme);
                                    }
                                  },
                                )
                              : Container(
                                  child: Text("User not Authenticated"),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  passUserData(String studioname) async {
    var response = await networkHandler.get("/user/$studioname");
    // print(response['studioname']);
    // print(response['imageurl']);
    // print(response['_id']);
    var name = response['studioname'];
    var imageurl = response['imageurl'];
    var profileID = response['_id'];

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Management(username: name, imgUrl: imageurl)));
  }

  // checkUser() async {
  //   if (_usernameController.text.length == 0) {
  //     setState(() {
  //       // circular = false;
  //       validate = false;
  //       errorText = "Username can't be empty";
  //     });
  //   } else {
  //     var response =
  //         await networkHandler.get("/user/checkusername/$_usernameController");
  //     if (response['Status']) {
  //       setState(() {
  //         // circular = false;
  //         validate = false;
  //         errorText = "Username already taken";
  //       });
  //     } else {
  //       setState(() {
  //         // circular = false;
  //         validate = true;
  //       });
  //     }
  //   }
  // }

  Widget studionameTextField(String label) {
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
              return "Username cant be empty";
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
      child: Column(children: [
        Text(
          "$label",
          style: TextStyle(color: Colors.black),
        ),
        TextFormField(
          controller: _contactController,
          validator: (value) {
            if (value.isEmpty) return "Password cant be empty";
            if (value.length < 1)
              return "Password length must be of 8 or more letter";
            return null;
          },
          obscureText: vis,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility_off),
                onPressed: toggle,
              ),
              helperText: "",
              helperStyle: TextStyle(fontSize: 16),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ))),
        )
      ]),
    );
  }

//   Widget emailTextField(String label) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
//       child: Column(children: [
//         Text(label),
//         TextFormField(
//           controller: _emailController,
//           validator: (value) {
//             if (value.isEmpty) return "Email cant be empty";
//             if (!value.contains("@")) return "Email is invalid";
//             return null;
//           },
//           decoration: InputDecoration(
//               focusedBorder: UnderlineInputBorder(
//                   borderSide: BorderSide(
//             color: Colors.black,
//             width: 2,
//           ))),
//         )
//       ]),
//     );
//   }

}
