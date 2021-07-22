import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import './TeacherPortfolio.dart';
import 'dart:convert';
import '../Homepage.dart';
import '../Drawer.dart';

// import 'package:responsive/pages/Myname.dart';

class TeachersProfile extends StatefulWidget {
  final username, imgUrl;
  TeachersProfile({@required this.username, this.imgUrl});
  @override
  _TeachersProfileState createState() => _TeachersProfileState();
}

class _TeachersProfileState extends State<TeachersProfile> {
  var url = "https://salty-wildwood-57210.herokuapp.com/user";
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
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("dow you want to Logout"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Instructors Profile"),
        ),
        body: data != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Name: ${data[index]['username']}",
                    ),
                    subtitle: Text("Address: ${data[index]['address']}"),
                    leading: Image.network(data[index]['url']),
                    trailing: Icon(Icons.ac_unit),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(data[index]['username']),
                              content: Text("do you want to proceed??"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TeacherPortfolio(
                                                      managementUser:
                                                          widget.username,
                                                      managementImgUrl:
                                                          widget.imgUrl,
                                                      username: data[index]
                                                          ['username'],
                                                      phone: data[index]
                                                          ['phone'],
                                                      address: data[index]
                                                          ['address'],
                                                      password: data[index]
                                                          ['password'],
                                                      url: data[index]['url'],
                                                      id: data[index]['_id'])));
                                    },
                                    child: Icon(Icons.radio)),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(Icons.cancel)),
                              ],
                            );
                          });
                    },
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
