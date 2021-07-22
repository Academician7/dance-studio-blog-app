import "package:flutter/material.dart";
import './UpdateStudent.dart';
import './StudentsProfile.dart';
import '../Drawer.dart';

// import 'package:responsive/pages/Myname.dart';

class StudentsPortfolio extends StatefulWidget {
  final managementUser,
      managementImgUrl,
      username,
      phone,
      address,
      url,
      password,
      id;
  StudentsPortfolio(
      {@required this.managementUser,
      this.managementImgUrl,
      this.username,
      this.phone,
      this.address,
      this.url,
      this.password,
      this.id});
  @override
  _StudentsPortfolioState createState() => _StudentsPortfolioState();
}

class _StudentsPortfolioState extends State<StudentsPortfolio> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Go back to Students profile?"),
                //   content: Text("do you want to proceed??"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentsProfile(
                                      username: widget.managementUser,
                                      imgUrl: widget.managementImgUrl,
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
        drawer: MyDrawer(
            username: widget.managementUser, imgUrl: widget.managementImgUrl),
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("${widget.username}'s PortFolio"),
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
                                            UpdateStudentProfile(
                                                managementUser:
                                                    widget.managementUser,
                                                managementImgUrl:
                                                    widget.managementImgUrl,
                                                id: widget.id,
                                                studentname: widget.username,
                                                url: widget.url,
                                                phone: widget.phone,
                                                address: widget.address,
                                                password: widget.password)));
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
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 11,
            ),
            Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.url),
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
                      fontSize: MediaQuery.of(context).size.width / 8.5,
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
                  "Contact : ${widget.phone}",
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
                  "Address : ${widget.address}",
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
                  "Password : ${widget.password}",
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
        ),
      ),
    );
  }
}
