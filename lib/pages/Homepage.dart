import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import './0. Login Routes/Login.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var data;
  var url1 = "https://warm-ridge-34462.herokuapp.com/user";
  var url2 = "https://peaceful-everglades-79678.herokuapp.com/user";
  var url3 = "https://salty-wildwood-57210.herokuapp.com/user";
  var url4 = "https://whispering-taiga-05909.herokuapp.com/user";
  var url5 = "https://peaceful-ravine-35848.herokuapp.com/user";
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await http.get(url1);
    await http.get(url2);
    await http.get(url3);
    await http.get(url4);
    await http.get(url5);
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
                title: Text("Do you want to Exit"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        SystemNavigator.pop();
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Management's Panel",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.pink[600]),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://i.pinimg.com/originals/cc/4c/ec/cc4cec2d63f978b4f7e5dbfc59cc85b9.png"),
                            fit: BoxFit.cover))),
                SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  },
                  child: Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50)),
                        border: Border.all(color: Colors.black, width: 3)),
                    child: Center(
                      child: Text(
                        "MANAGE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
