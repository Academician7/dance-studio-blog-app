import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'MSchedule.dart';
import 'dart:convert';
import '../Homepage.dart';
import '../Drawer.dart';

// import 'package:responsive/pages/Myname.dart';

class Schedule extends StatefulWidget {
  final username, imgUrl;
  Schedule({@required this.username, this.imgUrl});
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  var url = "https://peaceful-ravine-35848.herokuapp.com/user";
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("Schedule"),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Want to update the schedule?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MSchedule(
                                            id: data[0]['_id'],
                                            imgUrl: widget.imgUrl,
                                            studioname: widget.username,
                                            saturday3: data[0]['saturday3'],
                                            saturday4: data[0]['saturday4'],
                                            saturday5: data[0]['saturday5'],
                                            saturday6: data[0]['saturday6'],
                                            saturday7: data[0]['saturday7'],
                                            sunday3: data[0]['sunday3'],
                                            sunday4: data[0]['sunday4'],
                                            sunday5: data[0]['sunday5'],
                                            sunday6: data[0]['sunday6'],
                                            sunday7: data[0]['sunday7'])));
                                print(data[0]['saturday3']);
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 5,
                        color: Colors.white,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(color: Colors.white, width: 4)),
                        height: 110,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            data[index]['studioname'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold),
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
                            "Saturday Schedule",
                            style: TextStyle(color: Colors.white, fontSize: 30),
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
                            "3 pm - 4 pm:         ${data[index]['saturday3']}",
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
                            "4 pm - 5 pm:         ${data[index]['saturday4']}",
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
                            "5 pm - 6 pm:         ${data[index]['saturday5']}",
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
                            "6 pm - 7 pm:         ${data[index]['saturday6']}",
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
                            "7 pm - 8 pm:         ${data[index]['saturday7']}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 5,
                        color: Colors.white,
                      ),
                      SizedBox(height: 50),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 5,
                        color: Colors.white,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4)),
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Sunday Schedule",
                            style: TextStyle(color: Colors.white, fontSize: 30),
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
                            "3 pm - 4 pm:         ${data[index]['sunday3']}",
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
                            "4 pm - 5 pm:         ${data[index]['sunday4']}",
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
                            "5 pm - 6 pm:         ${data[index]['sunday5']}",
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
                            "6 pm - 7 pm:         ${data[index]['sunday6']}",
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
                            "7 pm - 8 pm:         ${data[index]['sunday7']}",
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
