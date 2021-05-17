import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Report_Property_Details extends StatefulWidget {
  final String id;
  final String user;
  const Report_Property_Details({Key key, this.id, this.user}) : super(key: key);

  @override
  _Report_Property_DetailsState createState() => _Report_Property_DetailsState();
}

class _Report_Property_DetailsState extends State<Report_Property_Details> {
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                        "images/property.jpeg",
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        "images/property.jpg",
                                        width: MediaQuery.of(context).size.width,
                                        height: MediaQuery.of(context).size.height,
                                        fit:BoxFit.fill
                                    ),
                                  ),
                                ),
                                Container(
                                  child: ClipRRect(
                                    child: Image.asset(
                                        "images/property.jpeg",
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
                      future: FirebaseFirestore.instance.collection("Property Details").doc("${widget.id}").get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        return Text("${widget.id}");
                      },
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  FirebaseFirestore.instance.collection("Users12").doc(widget.user).get().then((value) => {
                                    email = value.get('Email'),
                                    print("Send notice through the email on $email"),
                                  });
                                },
                                child: Text("Notice", style: TextStyle(fontSize: 18, color: Colors.red)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  print("Delete this property ${widget.id}");
                                },
                                child: Text("Delete", style: TextStyle(fontSize: 18, color: Colors.red)),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
