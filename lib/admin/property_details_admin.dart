import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                                autoPlayInterval: Duration(seconds: 2),
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                autoPlayAnimationDuration: Duration(milliseconds: 800)
                              ),
                              items: [
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images/property.jpeg",
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images/property.jpg",
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                      "images/property.jpeg",
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance.collection("Property Details").doc(widget.id).get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          return Text("${widget.id}");
                        },
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
}
