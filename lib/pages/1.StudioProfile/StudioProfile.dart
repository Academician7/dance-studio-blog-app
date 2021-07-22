import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import '../Management.dart';
import 'dart:convert';
import '../Drawer.dart';
import './UpdateStudioProfile.dart';

// import 'package:responsive/pages/Myname.dart';

class StudioProfile extends StatefulWidget {
  final username, imgUrl;
  StudioProfile({@required this.username, this.imgUrl});
  @override
  _StudioProfileState createState() => _StudioProfileState();
}

class _StudioProfileState extends State<StudioProfile> {
  var url = "https://whispering-taiga-05909.herokuapp.com/user";
  var data;
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    print(data);
    // print(data[1]['username']);
    setState(() {});
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you want to Logout?"),
                //   content: Text("do you want to proceed??"),
                actions: [
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
        drawer: MyDrawer(username: widget.username, imgUrl: widget.imgUrl),
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("The Dance Tribe"),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Want to Update Details?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateStudioProfile(
                                              id: data[0]['_id'],
                                              username: widget.username,
                                              imgUrl: widget.imgUrl,
                                              contact: data[0]['contact'],
                                              address: data[0]['address'],
                                              owner: data[0]['owner'],
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
        body: data != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 11,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: MediaQuery.of(context).size.width / 3,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.imgUrl),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 15,
                        color: Colors.black,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            widget.username,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 8.5,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4)),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Contact : ${data[index]['contact']}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4)),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Address : ${data[index]['address']}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4)),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Owner : ${data[index]['owner']}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 5,
                        color: Colors.white,
                      ),
                    ],
                  );
                },
                itemCount: data.length,
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
      ),
    );
  }
}
