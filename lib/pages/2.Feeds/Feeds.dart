import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'MFeeds.dart';
import 'dart:convert';
import '../Homepage.dart';
import '../Drawer.dart';
import './FeedsUpdate.dart';

// import 'package:responsive/pages/Myname.dart';

class Feeds extends StatefulWidget {
  final username, imgUrl;
  Feeds({@required this.username, this.imgUrl});
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  var url = "https://warm-ridge-34462.herokuapp.com/user";
  var data;
  // var reverseData;
  dynamic feedCounter = "";
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    setState(() {
      feedCounter = data.length.toString();
    });
    var x = data.length - 1;
    var reversedList = new List(data.length);
    var i;
    for (var y = x, i = 0; y >= 0; i++, y--) {
      reversedList[i] = data[y];
    }

    setState(() {
      data = reversedList;
    });
    print("This is the data i have been looking for ${data[1]['post']}");
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
        drawer: MyDrawer(
          username: widget.username,
          imgUrl: widget.imgUrl,
        ),
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text("Feeds: $feedCounter"),
          actions: [
            IconButton(
              icon: Icon(Icons.create),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Create a Post?"),
                        //   content: Text("do you want to proceed??"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MFeeds(
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
        body: data != null
            ? RefreshIndicator(
                onRefresh: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Feeds(
                                username: widget.username,
                                imgUrl: widget.imgUrl,
                              )));
                  setState(() {
                    feedCounter = data.length.toString();
                  });
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FeedsUpdate(
                                      postID: data[index]['_id'],
                                      username: widget.username,
                                      imgUrl: widget.imgUrl,
                                      post: data[index]['post'],
                                      imageurl: data[index]['imageurl'],
                                    )));
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "${data[index]['postedby']}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                              width: 300,
                              child: Center(
                                  child: Text("${data[index]['post']}"))),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        NetworkImage(data[index]['imageurl']),
                                    fit: BoxFit.cover)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                            color: Colors.grey,
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: data.length,
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              )),
        //    : Center(child: CircularProgressIndicator()),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Feeds(
                          username: widget.username,
                          imgUrl: widget.imgUrl,
                        )));
            setState(() {
              feedCounter = data.length.toString();
            });
          },
          child: Icon(Icons.send),
          backgroundColor: Colors.blue[900],
        ),
      ),
    );
  }
}
