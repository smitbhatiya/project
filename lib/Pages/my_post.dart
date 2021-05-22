import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/database_manager.dart';
import 'package:flutter_app_with_firebase/Model/userpost_manager.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class MyPost extends StatefulWidget {
  @override
  _MyPostState createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  bool isAnimate = false;
  List userPostList = [];
  int v1;

  // ignore: non_constant_identifier_names
  String doc_id;

  // ignore: non_constant_identifier_names
  String doc_id1;
  String myRole;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    refreshPage();
  }

  Future<Null> refreshPage() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return;
    });
  }

  fetchDatabaseList() async {
    dynamic resultant = await UserpostManager().getUsersPostList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userPostList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: StreamBuilder<QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection('Property Details').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: userPostList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot data = snapshot.data.docs[index];
                return GestureDetector(
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('Property Details')
                        .get()
                        .then(
                          (QuerySnapshot snapshot) =>
                      {
                        // snapshot.documents.forEach((f) {
                        //
                        //   print("documentID---- " + f.reference.documentID);
                        //
                        // }),
                        //     snapshot.documents[index].data(),
                        //v1 = userPostList[index].get('view'),
                        v1 = snapshot.docs[index].get('view'),
                        doc_id = userPostList[index]['propertyId'],
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                Property_Detail(id: doc_id, v1: v1))),
                        //doc_id = snapshot.documents[index].documentID,
                        //print(snapshot.documents[index].documentID)
                        print(doc_id)
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    height: 320,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius
                                        .circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                                child: Image.network(
                                    userPostList[index]['firstImage'],
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    fit: BoxFit.fill
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 13),
                                height: 30,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 2,
                                child: Text(
                                    userPostList[index]['project name'],
                                    style: TextStyle(fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: 13),
                                  alignment: Alignment.topRight,
                                  height: 20,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  child: Text(userPostList[index]['price'],
                                      style: TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo)),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 7),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 13),
                            child: RichText(
                              text: TextSpan(
                                  text: "Posted by : ",
                                  style: TextStyle(fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                      // text: "Builder",
                                        text: userPostList[index]['posted by'],
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w400)
                                    )
                                  ]
                              ),
                            )
                        ),
                        SizedBox(height: 7),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 13),
                            child: RichText(
                              text: TextSpan(
                                  text: "Location : ",
                                  style: TextStyle(fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: userPostList[index]['city'],
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)
                                    )
                                  ]
                              ),
                            )
                        ),
                        SizedBox(height: 7),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 13),
                            child: RichText(
                              text: TextSpan(
                                  text: "Type : ",
                                  style: TextStyle(fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: userPostList[index]['category'],
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)
                                    )
                                  ]
                              ),
                            )
                        ),
                        SizedBox(height: 7),
                        Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(left: 13),
                            child: RichText(
                              text: TextSpan(
                                  text: "Status : ",
                                  style: TextStyle(fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                        text: userPostList[index]['status'],
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400)
                                    )
                                  ]
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                );
              });
        },
      )
    );
  }
}

