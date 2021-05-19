import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Admin_Property_Details extends StatefulWidget {
  final String id;
  const Admin_Property_Details({Key key, this.id}) : super(key: key);

  @override
  _Admin_Property_DetailsState createState() => _Admin_Property_DetailsState();
}

class _Admin_Property_DetailsState extends State<Admin_Property_Details> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSnackBar(String value) {
    _scaffoldKey
        .currentState
        .showSnackBar(
        SnackBar(
            content: Text(value)
        )
    );
  }

  CollectionReference data1 = FirebaseFirestore.instance.collection('Property Details');
  CollectionReference data2 = FirebaseFirestore.instance.collection('Users12');
  bool rBool;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Property Details").doc(widget.id).snapshots(),
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width/2,
                                        child: Text(
                                            userData["project name"],
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo
                                            )
                                        ),
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
                                          child: Text(
                                              userData["price"] + "/sq ft",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.indigo
                                              )
                                          ),
                                        )
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
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                              // text: "Builder",
                                                text: userData["posted by"],
                                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
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
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text: userData["city"],
                                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
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
                                          text: "Address : ",
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text:userData["address"],
                                                style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400)
                                            )
                                          ]
                                      ),
                                    )
                                ),
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width/2,
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width/2,
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
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text: userData["price"],
                                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
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
                                          text: "Area : ",
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text: userData["area"] +" SQ.FT",
                                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
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
                                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                          children: [
                                            TextSpan(
                                                text: userData["status"],
                                                style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                            )
                                          ]
                                      ),
                                    )
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width/2,
                                        child: Text("Project Detail", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.teal)),
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
                                          child: Text("", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                        text: userData["description"],
                                        style: TextStyle(fontSize: 18, color: Colors.black,),
                                      ),
                                    )
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          RaisedButton(
                            onPressed: () {
                              showSnackBar("Delete property successfully.");
                              FirebaseFirestore
                                  .instance
                                  .collection("Property Details")
                                  .doc(widget.id)
                                  .delete();
                              FirebaseFirestore
                                  .instance
                                  .collection("Property Details")
                                  .doc(widget.id)
                                  .get().then((value) => {
                                rBool = value.get('report'),
                                if(rBool == true) {
                                  FirebaseFirestore
                                      .instance
                                      .collection("Report Property")
                                      .doc(widget.id)
                                      .delete()
                                }
                              });
                            },
                            color: Colors.red.shade300,
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ),
          )
        );
      }
    );
  }
}
