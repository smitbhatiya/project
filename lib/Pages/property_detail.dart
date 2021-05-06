import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Chatroom/chat_messages.dart';
import 'package:flutter_app_with_firebase/Pages/review_page.dart';

class Property_Detail extends StatefulWidget {
  final String id;

  const Property_Detail({Key key, this.id}) : super(key: key);
  @override
  _Property_DetailState createState() => _Property_DetailState();
}

class _Property_DetailState extends State<Property_Detail> {
  CollectionReference data1 = FirebaseFirestore.instance.collection('Property Details');
  //String u2 = FirebaseFirestore.instance.doc(widget.id).get().then((value) => value.data()['postById']) as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      child: Stack(
                        children: [
                          CarouselSlider(
                              options: CarouselOptions(
                                height: 300.0,
                                enlargeCenterPage: true,
                                autoPlayInterval: Duration(seconds: 2),
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlayAnimationDuration: Duration(milliseconds: 800),
                              ),
                            items: [
                              Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                      'images/property.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                      'images/property.jpeg',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                      'images/property.jpg',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                              Container(
                                child: ClipRRect(
                                  child: Image.asset(
                                      'images/property.jpeg',
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit:BoxFit.fill
                                  ),
                                ),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder<DocumentSnapshot>(
                      future: data1.doc("${widget.id}").get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        return Text("${widget.id}");
                        },
                    ),
                    IconButton(
                      icon: Icon(Icons.message),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => review_page(id1: widget.id)));
                      },
                    ),
                    RaisedButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('Property Details').doc(widget.id).updateData({
                          'markAsSold': 'Sold'
                        });
                      },
                      child: Text("Mark as sold"),
                    ),
                    Row(
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Firestore.instance
                                .collection("chatRoom")
                                .doc("${FirebaseAuth.instance.currentUser.uid}")
                                .set({
                              "users" : "${FirebaseAuth.instance.currentUser.uid} with",
                              "chatRoomId": "id",
                            });
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Messages()));
                          },
                          child: Text("Chat")
                        ),
                        SizedBox(width: 200),
                        Row(
                          children: [
                            Container(
                              child: Icon(Icons.remove_red_eye),
                            ),
                            SizedBox(width: 20),
                            Container(
                              child: Text("2"),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  final CollectionReference countList =
  FirebaseFirestore.instance
      .collection('Property Details');
  getCount() {
    countList.doc(widget.id).get().then((value) => value.data()['seenByUser'].length);
  }
}
