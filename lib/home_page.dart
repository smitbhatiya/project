import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Pages/post_property_page.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/login_page.dart';

import 'login_page.dart';

class Home extends StatelessWidget {
  Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;
  final _auth = FirebaseAuth.instance.currentUser;
  String myEmail;
  String myPhone;
  String myName;
  String myRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
      ),
      body: ListView(
        // child: Center(child: Text("${_auth.displayName}")),
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.12,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30)),
                        color: Colors.indigo
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState != ConnectionState.done) {
                          return Text("Loading...");
                        }
                        return Column(
                          children: [
                            Center(child: Text("Hello, ${myName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
                            SizedBox(height: 10),
                            Center(child: Text("${myEmail}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
                          ],
                        );
                      }
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Page())),
                    child: Container(
                      margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                      height: 50,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.only(left: 30, top: 15),
                      child: Text("Search",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 280,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade300,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
                      ),
                      Row(
                        children: [
                          Container(color: Colors.yellow,
                              height: 30,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.45),
                          Container(
                              color: Colors.red, height: 30, width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 280,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade300,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
                      ),
                      Row(
                        children: [
                          Container(color: Colors.yellow,
                              height: 30,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.45),
                          Container(
                              color: Colors.red, height: 30, width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 280,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade300,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                            color: Colors.white
                        ),
                        // child: Image(image: AssetImage(""), fit: BoxFit.cover),
                      ),
                      Row(
                        children: [
                          Container(color: Colors.yellow,
                              height: 30,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.45),
                          Container(
                              color: Colors.red, height: 30, width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.45)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 25),
                  Text("Post property")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Post_Property())),
            ),
            ListTile(
                title: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 25),
                    Text("Sign Out", style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () =>
                    signOut().whenComplete(() =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LogIn_Page()), (
                            Route<dynamic> route) => false))
            )
          ],
        ),
      ),
    );
  }

  Future<bool> signOut() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.signOut();
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users12')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
         myEmail = ds.data()['Email'];
         myName = ds.data()['Name'];
         myPhone = ds.data()['Mobile Number'];
         myRole = ds.data()['Role'];
      }).catchError((e) {
        print(e);
      });
    }
  }
}

