import 'package:flutter/material.dart';
import './1.StudioProfile/StudioProfile.dart';

class Management extends StatefulWidget {
  final username, imgUrl;
  Management({@required this.username, this.imgUrl});
  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
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
                height: MediaQuery.of(context).size.height / 10,
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
                        fontSize: MediaQuery.of(context).size.width / 8.5,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height,)
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.6,
                color: Colors.black,
              ),
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 9,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.white)),
                  child: Center(
                    child: Text(
                      'PANEL',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
