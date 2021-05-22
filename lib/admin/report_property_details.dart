import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Report_Property_Details extends StatefulWidget {
  final String id;
  final String user;
  const Report_Property_Details({Key key, this.id, this.user}) : super(key: key);

  @override
  _Report_Property_DetailsState createState() => _Report_Property_DetailsState();
}

class _Report_Property_DetailsState extends State<Report_Property_Details> {
  String email;

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

  static Future openEmail({
    @required String toEmail,
    @required String subject,
    @required String body,
  }) async {
    final url = 'mailto: $toEmail ? subject= ${Uri.encodeFull(subject)} &body= ${Uri.encodeFull(body)}';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
  bool rBool;

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
                                    autoPlay: false,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                  ),
                                  items: [
                                    GestureDetector(
                                      onTap: () {
                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                              userData['firstImage'],
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              fit:BoxFit.fill
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                              userData['secondImage'],
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              fit:BoxFit.fill
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Container(
                                        child: ClipRRect(
                                          child: Image.network(
                                              userData['thirdImage'],
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              fit:BoxFit.fill
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
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
                                      width: MediaQuery.of(context).size.width/2,
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
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
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
                                    text: "Location : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                    ),
                                    children: [
                                      TextSpan(
                                        text: userData["city"],
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
                                    text: "Address : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700
                                    ),
                                    children: [
                                      TextSpan(
                                        text: userData["address"],
                                        style: TextStyle(
                                          fontSize: 15,
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
                                              text: userData["area"],
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
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance.collection("Users12")
                                  .doc(widget.user).get()
                                  .then((value) =>
                              {
                                email = value.get('Email'),
                                openEmail(toEmail: '$email',
                                    subject: "Notice from Construction app",
                                    body: ''),
                                showSnackBar(
                                    "Send notice successfully to $email"),
                                print(
                                    "Send notice through the email on $email"),
                              });
                            },
                            child: Container(
                              child: Text("Notice", style: TextStyle(
                                  fontSize: 18, color: Colors.red)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                showSnackBar("Delete property successfully");
                                FirebaseFirestore
                                    .instance
                                    .collection("Property Details")
                                    .doc(widget.id)
                                    .updateData({
                                  'report': false,
                                });
                                FirebaseFirestore
                                    .instance
                                    .collection("Report Property")
                                    .doc(widget.id)
                                    .delete();
                                FirebaseFirestore
                                    .instance
                                    .collection("Property Details")
                                    .doc(widget.id)
                                    .delete();
                                print("Delete this property ${widget.id}");
                              },
                              child: Text("Delete", style: TextStyle(fontSize: 18, color: Colors.red)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

// class _Report_Property_DetailsState extends State<Report_Property_Details> {
//   String email;
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   void showSnackBar(String value) {
//     _scaffoldKey
//         .currentState
//         .showSnackBar(
//         SnackBar(
//             content: Text(value)
//         )
//     );
//   }
//
//   static Future openEmail({
//     @required String toEmail,
//     @required String subject,
//     @required String body,
//   }) async {
//     final url = 'mailto: $toEmail ? subject= ${Uri.encodeFull(subject)} &body= ${Uri.encodeFull(body)}';
//     await _launchUrl(url);
//   }
//
//   static Future _launchUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         child: ListView(
//           children: [
//             Stack(
//               children: [
//                 Column(
//                   children: [
//                     Container(
//                       height: 300,
//                       child: Stack(
//                         children: [
//                           CarouselSlider(
//                               options: CarouselOptions(
//                                 height: 300.0,
//                                 enlargeCenterPage: true,
//                                 autoPlayInterval: Duration(seconds: 2),
//                                 autoPlay: true,
//                                 autoPlayCurve: Curves.fastOutSlowIn,
//                                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                               ),
//                               items: [
//                                 Container(
//                                   child: ClipRRect(
//                                     child: Image.asset(
//                                         "images/property.jpeg",
//                                         width: MediaQuery.of(context).size.width,
//                                         height: MediaQuery.of(context).size.height,
//                                         fit:BoxFit.fill
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: ClipRRect(
//                                     child: Image.asset(
//                                         "images/property.jpg",
//                                         width: MediaQuery.of(context).size.width,
//                                         height: MediaQuery.of(context).size.height,
//                                         fit:BoxFit.fill
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   child: ClipRRect(
//                                     child: Image.asset(
//                                         "images/property.jpeg",
//                                         width: MediaQuery.of(context).size.width,
//                                         height: MediaQuery.of(context).size.height,
//                                         fit:BoxFit.fill
//                                     ),
//                                   ),
//                                 ),
//                               ]
//                           ),
//                         ],
//                       ),
//                     ),
//                     FutureBuilder<DocumentSnapshot>(
//                       future: FirebaseFirestore.instance.collection("Property Details").doc("${widget.id}").get(),
//                       builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//                         if (snapshot.hasError) {
//                           return Text("Something went wrong");
//                         }
//                         return Text("${widget.id}");
//                       },
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             child: Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   FirebaseFirestore.instance.collection("Users12").doc(widget.user).get().then((value) => {
//                                     email = value.get('Email'),
//                                     openEmail(toEmail: '$email', subject: "Notice from Construction app", body: ''),
//                                     showSnackBar("Send notice successfully to $email"),
//                                     print("Send notice through the email on $email"),
//                                   });
//                                 },
//                                 child: Text("Notice", style: TextStyle(fontSize: 18, color: Colors.red)),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           child: Container(
//                             child: Center(
//                               child: GestureDetector(
//                                 onTap: () {
//                                   showSnackBar("Delete property successfully");
//                                   FirebaseFirestore
//                                       .instance
//                                       .collection("Property Details")
//                                       .doc(widget.id)
//                                       .updateData({
//                                     'report': false,
//                                   });
//                                   FirebaseFirestore
//                                       .instance
//                                       .collection("Report Property")
//                                       .doc(widget.id)
//                                       .delete();
//                                   FirebaseFirestore
//                                       .instance
//                                       .collection("Property Details")
//                                       .doc(widget.id)
//                                       .delete();
//                                   print("Delete this property ${widget.id}");
//                                 },
//                                 child: Text("Delete", style: TextStyle(fontSize: 18, color: Colors.red)),
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
