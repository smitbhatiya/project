import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Chatroom/chat_messages.dart';
import 'package:flutter_app_with_firebase/Pages/review_page.dart';

class Property_Detail extends StatefulWidget {
  final String id;
  final String u2;
  final int v1;

  const Property_Detail({Key key, this.id, this.u2, this.v1}) : super(key: key);
  @override
  _Property_DetailState createState() => _Property_DetailState();
}

class _Property_DetailState extends State<Property_Detail> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void showSnackBar(String value) {
    _scaffoldKey
        .currentState
        .showSnackBar(
          SnackBar(
            content: Text(value),
          )
    );
  }

  CollectionReference data1 = FirebaseFirestore.instance.collection('Property Details');
  CollectionReference data2 = FirebaseFirestore.instance.collection('Users12');
  String view;
  String uName;
  String cate;
  String poB;
  String ci;
  String sta;
  String proN;
  String pri;
  String fiI;
  String poI;
  bool reportV;
  String img1;
  String img2;
  String img3;

  Future getImage() async{
    await FirebaseFirestore.instance.collection("Property Details").doc(widget.id).get().then(
            (value) => {
          setState(() {
            img1 = value.get('firstImage');
            img2 = value.get('secondImage');
            img3 = value.get('thirdImage');
          }),
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore
          .instance
          .collection("Property Details")
          .doc(widget.id)
          .snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var userData = snapshot.data;
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.grey.shade50,
          body: SafeArea(
            child: Container(
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
                                    height: 300,
                                    enlargeCenterPage: true,
                                    autoPlayInterval: Duration(milliseconds: 200),
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayAnimationDuration: Duration(seconds: 2)
                                  ),
                                  items: [
                                    GestureDetector(
                                      onTap: () {
                                        print("first image click");
                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                            userData['firstImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("second image click");
                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                            userData['secondImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print("third image click");
                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                            userData['thirdImage'],
                                            width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  child: RaisedButton(
                                      //shape:
                                      onPressed: () {
                                        Firestore.instance.collection("Property Details")
                                            .doc('${widget.id}')
                                            .collection("chatRoom")
                                            .doc("${FirebaseAuth.instance.currentUser.uid}_${widget.u2}")
                                            .set({
                                          "users" : FieldValue.arrayUnion(['${FirebaseAuth.instance.currentUser.uid}', '${widget.u2}']),
                                          "chatRoomId": "${FirebaseAuth.instance.currentUser.uid}_${widget.u2}",
                                        });
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Messages(u2: widget.u2, id: widget.id)));
                                      },
                                      color: Colors.green,
                                      child: Text("Chat", style: TextStyle(fontSize: 16))
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => review_page(id1: widget.id)));
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.message),
                                          SizedBox(width: 10),
                                          Text("Reviews", style: TextStyle(fontSize: 16))
                                        ]
                                      ),
                                    )
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.15),
                                Expanded(
                                  child: Container (
                                    margin: EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Icon(Icons.remove_red_eye),
                                        ),
                                        SizedBox(width: 20),
                                        Container(
                                          child: Text("${widget.v1}", style: TextStyle(fontSize: 16)),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 160,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 13),
                                        height: 30,
                                        width: MediaQuery.of(context).size.width,
                                        child: Text(
                                          userData["project name"],
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 13),
                                        alignment: Alignment.topRight,
                                        height: 20,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          userData["price"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Posted by : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData["posted by"],
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Location : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData["city"],
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Address : ",
                                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          text: userData["address"],
                                          style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)
                                        )
                                      ]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 157,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: 7),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 13),
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          "Overview",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right: 13),
                                        alignment: Alignment.topRight,
                                        height: 20,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Detail/Maintenance : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData['detail'],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                          )
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Price : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData["price"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                          )
                                        )
                                      ]
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Area : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData["area"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                          )
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
                                      text: "Construction Status : ",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700
                                      ),
                                      children: [
                                        TextSpan(
                                          text: userData["status"],
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400
                                          )
                                        )
                                      ]
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                            child: Column(
                              children: [
                                SizedBox(height: 7),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(left: 13),
                                        height: 30,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          "Project Detail",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.teal
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(right:13),
                                        alignment: Alignment.topRight,
                                        height: 20,
                                        width: MediaQuery.of(context).size.width/2,
                                        child: Text(
                                          "",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 7),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 13),
                                  child: RichText(
                                    text: TextSpan(
                                      text: userData["description"],
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black
                                      )
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  (widget.u2 == FirebaseAuth.instance.currentUser.uid)
                      ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: RaisedButton(
                          color: Colors.red.shade500,
                    onPressed: () {
                        showSnackBar("Successfully labeled 'Sold'");
                        FirebaseFirestore.instance.collection('Property Details').doc(widget.id).updateData({
                          'markAsSold': 'Sold'
                        });
                        FirebaseFirestore.instance.collection('Property Details').doc(widget.id).get().then((value) => {
                          cate = value.get('category'),
                          poB = value.get('posted by'),
                          proN = value.get('project name'),
                          ci = value.get('city'),
                          pri = value.get('price'),
                          sta = value.get('status'),
                          fiI = value.get('firstImage'),
                          FirebaseFirestore.instance.collection('soldProperties').doc(widget.id).set({
                            'category': cate,
                            'posted by': poB,
                            'project name': proN,
                            'city': ci,
                            'price': pri,
                            'status': sta,
                            'firstImage': fiI
                          }),
                          FirebaseFirestore
                              .instance
                              .collection('Property Details')
                              .doc(widget.id)
                              .delete(),
                          FirebaseFirestore
                              .instance
                              .collection("Property Details")
                              .doc(widget.id)
                              .get()
                              .then((value) => {
                            reportV = value.get('report'),
                            if(reportV == true) {
                              FirebaseFirestore
                                  .instance
                                  .collection('Report Property')
                                  .doc(widget.id)
                                  .delete()
                            }
                          })
                        });
                    },
                    child: Text("Mark as sold", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                      )
                      : GestureDetector(
                    onTap: () {
                      showSnackBar("This property report Successfully");
                      FirebaseFirestore.instance.collection('Property Details').doc(widget.id).updateData({
                        'report': true,
                      });
                      FirebaseFirestore.instance.collection("Property Details").doc(widget.id).get().then((value) => {
                        poI = value.get('postById'),
                        reportV = value.get('report'),
                        print(reportV),
                        FirebaseFirestore.instance.collection("Report Property").doc(widget.id).set({
                          'propertyId': widget.id,
                          'postedUser': poI
                        })
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Center(
                        child: Text(
                          "Report property",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  // getSoldListIn() {
  //   FirebaseFirestore.instance.collection('Property Details').doc(widget.id).updateData({
  //     'markAsSold': 'Sold'
  //   });
  //   FirebaseFirestore.instance.collection('Property Details').doc(widget.id).get().then((value) => {
  //     cate = value.get('category'),
  //     poB = value.get('posted by'),
  //     proN = value.get('project name'),
  //     ci = value.get('city'),
  //     pri = value.get('price'),
  //     sta = value.get('status'),
  //     fiI = value.get('firstImage'),
  //     FirebaseFirestore.instance.collection('soldProperties').doc(widget.id).set({
  //       'category': cate,
  //       'posted by': poB,
  //       'project name': proN,
  //       'city': ci,
  //       'price': pri,
  //       'status': sta,
  //       'firstImage': fiI
  //     }),
  //     FirebaseFirestore.instance.collection('Property Details').doc(widget.id).delete(),
  //   });
  // }
  getSoldListIn1() {
    FirebaseFirestore.instance.collection('Property Details').doc(widget.id).updateData({
      'markAsSold': 'Sold'
    });
    Firestore.instance.collection('Property Details').doc(widget.id).get().then((value) => {
      cate = value.get('category'),
      poB = value.get('posted by'),
      proN = value.get('project name'),
      ci = value.get('city'),
      pri = value.get('price'),
      sta = value.get('status'),
      fiI = value.get('firstImage'),
      FirebaseFirestore.instance.collection('soldProperties').doc(widget.id).set({
        'category': cate,
        'posted by': poB,
        'project name': proN,
        'city': ci,
        'price': pri,
        'status': sta,
        'firstImage': fiI
      }),
      FirebaseFirestore.instance.collection('Property Details').doc(widget.id).delete(),
    });
  }
}

