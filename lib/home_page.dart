import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Pages/favorite_page.dart';
import 'package:flutter_app_with_firebase/Pages/my_profile_page.dart';
import 'package:flutter_app_with_firebase/Pages/post_property_page.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
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
      backgroundColor: Colors.grey.shade50,
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
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail())),
                child: Container(
                      height: 300,
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
                                    borderRadius: BorderRadius.only(topLeft: Radius
                                        .circular(20), topRight: Radius.circular(20)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  child: Image.asset(
                                      'images/property.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                margin: EdgeInsets.only(right: 20, top: 20),
                                child: FavoriteButton(
                                  isFavorite: false,
                                  valueChanged: (_isFavorite) {
                                    print('Is Favorite : $_isFavorite');
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: 13),
                                    height: 20,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width/2,
                                  child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                                    .width/2,
                                      child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
                                  )
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                  text: TextSpan(
                                    text: "Posted by : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                        // text: "Builder",
                                        text: "Builder",
                                        style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
                                      )
                                    ]
                                  ),
                              )
                          ),
                          SizedBox(height: 5),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Location : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: "Surat",
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),
                          SizedBox(height: 5),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Type : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: "Residential",
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),
                          SizedBox(height: 5),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 13),
                              child: RichText(
                                text: TextSpan(
                                    text: "Status : ",
                                    style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                    children: [
                                      TextSpan(
                                          text: "Under Construction",
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                      )
                                    ]
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
              ),
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
                  Icon(Icons.account_circle),
                  SizedBox(width: 25),
                  Text("My Profile")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => My_Profile_Page())),
            ),
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
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: 25),
                  Text("Favorites", style: TextStyle(fontSize: 16))
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite_Page())),
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

