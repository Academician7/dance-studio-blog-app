import './2.Feeds/Feeds.dart';
import './3.Schedule/Schedule.dart';
import './1.StudioProfile/StudioProfile.dart';
import './4.Teachers Profile/TeachersProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Homepage.dart';
import './5.Student Profile/StudentsProfile.dart';

class MyDrawer extends StatefulWidget {
  final username, imgUrl;

  MyDrawer({@required this.username, this.imgUrl});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
    print("This is the reversed list $reversedList");
    setState(() {
      data = reversedList;
    });
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mainUrl;
    if (widget.imgUrl == 'none') {
      mainUrl =
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";
    } else {
      mainUrl = widget.imgUrl;
    }

    return Drawer(
        child: ListView(padding: const EdgeInsets.all(0), children: <Widget>[
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StudioProfile(
                        username: widget.username,
                        imgUrl: widget.imgUrl,
                      )));
        },
        child: UserAccountsDrawerHeader(
          accountName: Text(widget.username),
          accountEmail: Text("This is ${widget.username}'s Account"),
          currentAccountPicture: CircleAvatar(
            backgroundImage: NetworkImage(mainUrl),
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.star),
        title: Text("Feeds"),
        subtitle: Text("News Feeds"),
        trailing: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(feedCounter),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Feeds(
                        username: widget.username,
                        imgUrl: widget.imgUrl,
                      )));
        },
      ),
      ListTile(
        leading: Icon(Icons.backpack),
        title: Text("Classes Schedule"),
        subtitle: Text("Routene and updates"),
        trailing: Icon(Icons.send),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Schedule(
                        username: widget.username,
                        imgUrl: widget.imgUrl,
                      )));
        },
      ),
      ListTile(
        leading: Icon(Icons.color_lens),
        title: Text("Teachers Profile"),
        subtitle: Text("information"),
        trailing: Icon(Icons.send),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TeachersProfile(
                        username: widget.username,
                        imgUrl: widget.imgUrl,
                      )));
        },
      ),
      (widget.username != 'Guest')
          ? ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("Students Profile"),
              subtitle: Text("information"),
              trailing: Icon(Icons.send),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentsProfile(
                              username: widget.username,
                              imgUrl: widget.imgUrl,
                            )));
              },
            )
          : ListTile(
              leading: Icon(Icons.color_lens),
              title: Text("Students Profile"),
              subtitle: Text("information"),
              trailing: Icon(Icons.send),
              onTap: () {},
            ),
      SizedBox(
        height: 120,
      ),
      InkWell(
        onTap: () {
          showDialog(
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
        child: Container(
          child: Icon(Icons.logout),
        ),
      ),
    ]));
  }
}
