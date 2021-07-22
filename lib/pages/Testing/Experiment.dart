// import "package:flutter/material.dart";
// import 'package:http/http.dart' as http;
// import 'package:studio_monitor/pages/Management/Forwarded/MFeeds.dart';
// import 'dart:convert';
// import 'Homepage.dart';
// import 'Drawer.dart';
// import 'Management/Forwarded/Update Page/FeedsUpdate.dart';

// // import 'package:responsive/pages/Myname.dart';

// class Experiment extends StatefulWidget {
//   final username, imgUrl, data;
//   Experiment({@required this.username, this.imgUrl, this.data});
//   @override
//   _ExperimentState createState() => _ExperimentState();
// }

// class _ExperimentState extends State<Experiment> {
//   var feedCounter = "";
//   var gotData;

//   void initState() {
//     super.initState();
//     setState(() {
//       gotData = widget.data;
//       feedCounter = gotData.length.toString();
//       print("I got the data $gotData");
//     });
//   }

//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         return showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text("Do you want to Logout?"),
//                 //   content: Text("do you want to proceed??"),
//                 actions: [
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Homepage()));
//                       },
//                       child: Icon(Icons.check)),
//                   TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                       child: Icon(Icons.cancel)),
//                 ],
//               );
//             });
//       },
//       child: Scaffold(
//         drawer: MyDrawer(
//           username: widget.username,
//           imgUrl: widget.imgUrl,
//         ),
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           title: Text("Feeds: $feedCounter"),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.create),
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text("Create a Post?"),
//                         //   content: Text("do you want to proceed??"),
//                         actions: [
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => MFeeds(
//                                               username: widget.username,
//                                               imgUrl: widget.imgUrl,
//                                             )));
//                               },
//                               child: Icon(Icons.check)),
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Icon(Icons.cancel)),
//                         ],
//                       );
//                     });
//               },
//             )
//           ],
//         ),
//         body: gotData != null
//             ? RefreshIndicator(
//                 onRefresh: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (BuildContext context) => Experiment(
//                                 username: widget.username,
//                                 imgUrl: widget.imgUrl,
//                               )));
//                   setState(() {
//                     feedCounter = gotData.length.toString();
//                   });
//                 },
//                 child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => FeedsUpdate(
//                                       postID: gotData[index]['_id'],
//                                       username: widget.username,
//                                       imgUrl: widget.imgUrl,
//                                       post: gotData[index]['post'],
//                                       imageurl: gotData[index]['imageurl'],
//                                     )));
//                       },
//                       child: Column(
//                         children: [
//                           SizedBox(height: 20),
//                           Text(
//                             "${gotData[index]['postedby']}",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Container(
//                               width: 300,
//                               child: Center(
//                                   child: Text("${gotData[index]['post']}"))),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: MediaQuery.of(context).size.width,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         gotData[index]['imageurl']),
//                                     fit: BoxFit.cover)),
//                           ),
//                           Container(
//                             width: MediaQuery.of(context).size.width,
//                             height: 10,
//                             color: Colors.grey,
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   itemCount: gotData.length,
//                 ),
//               )
//             : Center(
//                 child: CircularProgressIndicator(
//                 backgroundColor: Colors.blue,
//               )),
//         //    : Center(child: CircularProgressIndicator()),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (BuildContext context) => Experiment(
//                           username: widget.username,
//                           imgUrl: widget.imgUrl,
//                         )));
//             setState(() {
//               feedCounter = gotData.length.toString();
//             });
//           },
//           child: Icon(Icons.send),
//           backgroundColor: Colors.blue[900],
//         ),
//       ),
//     );
//   }
// }
