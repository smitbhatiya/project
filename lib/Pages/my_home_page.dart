// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:favorite_button/favorite_button.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_with_firebase/Pages/favorite_page.dart';
// import 'package:flutter_app_with_firebase/Pages/my_profile_page.dart';
// import 'package:flutter_app_with_firebase/Pages/post_property_page.dart';
// import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
// import 'package:flutter_app_with_firebase/Pages/search_page.dart';
// import 'package:flutter_app_with_firebase/firebase.dart';
// import 'package:flutter_app_with_firebase/login_page.dart';
//
//
// class My_Home extends StatefulWidget {
//   My_Home({Key key, this.user}) : super(key: key);
//   final FirebaseUser user;
//
//   @override
//   _My_HomeState createState() => _My_HomeState();
// }
//
// class _My_HomeState extends State<My_Home> {
//   final _auth = FirebaseAuth.instance.currentUser;
//   String myEmail;
//
//   String myPhone;
//
//   String myName;
//
//   String myRole;
//   bool f1;
//   Future<QuerySnapshot> getImages() {
//     return FirebaseFirestore.instance.collection("Property Details").get();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade50,
//       body: ListView(
//         // child: Center(child: Text("${_auth.displayName}")),
//         children: [
//           Column(
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     height: MediaQuery
//                         .of(context)
//                         .size
//                         .height * 0.12,
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                             bottomRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30)),
//                         color: Colors.indigo
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 15),
//                     child: FutureBuilder(
//                         future: _fetch(),
//                         builder: (context, snapshot) {
//                           if(snapshot.connectionState != ConnectionState.done) {
//                             return Text("Loading...");
//                           }
//                           return Column(
//                             children: [
//                               Center(child: Text("Hello, ${myName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
//                             ],
//                           );
//                         }
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Page())),
//                     child: Container(
//                       margin: EdgeInsets.only(top: 80, left: 30, right: 30),
//                       height: 50,
//                       width: MediaQuery
//                           .of(context)
//                           .size
//                           .width * 0.9,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(30),
//                         color: Colors.white,
//                       ),
//                       padding: EdgeInsets.only(left: 30, top: 15),
//                       child: Text("Search",
//                           style: TextStyle(color: Colors.grey, fontSize: 16)),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail())),
//                 child: Container(
//                   height: 300,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.9,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             height: 160,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius
//                                   .circular(20), topRight: Radius.circular(20)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20.0),
//                                 topRight: Radius.circular(20.0),
//                               ),
//                               child: FutureBuilder(
//                                 future: getImages(),
//                                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                                   if (snapshot.connectionState == ConnectionState.done) {
//                                     return Image.network(
//                                       snapshot.data.docs[0].data()['url'],
//                                       width: MediaQuery.of(context).size.width,
//                                       fit: BoxFit.fill);
//                                   } else if (snapshot.connectionState == ConnectionState.none) {
//                                     return Text("No data");
//                                   }
//                                   return CircularProgressIndicator();
//                                 },
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.topRight,
//                             margin: EdgeInsets.only(right: 20, top: 20),
//                             child: FavoriteButton(
//                               isFavorite: false,
//                               valueChanged: (_isFavorite) {
//                                 // print('Is Favorite : $_isFavorite');
//                                 f1 = _isFavorite;
//                                 print(f1);
//                                 if(f1 == true){
//                                   FavoriteProperty('Residential', 'Builder', 'Silver Villa', 'Surat', '2,00,000', 'Under Construction', 'URL');
//                                 }
//                                 else {
//                                   FirebaseFirestore.instance.collection('Property Details').get().then((QuerySnapshot snapshot) => {
//                                     doc_id = snapshot.documents[index].documentID
//                                   });
//                                 }
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 13),
//                               height: 20,
//                               width: MediaQuery
//                                   .of(context)
//                                   .size
//                                   .width/2,
//                               child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(right: 13),
//                                 alignment: Alignment.topRight,
//                                 height: 20,
//                                 width: MediaQuery
//                                     .of(context)
//                                     .size
//                                     .width/2,
//                                 child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
//                               )
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Posted by : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                     // text: "Builder",
//                                       text: "Builder",
//                                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Location : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Surat",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Type : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Residential",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Status : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Under Construction",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail()));},
//                 child: Container(
//                   height: 300,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.9,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             height: 160,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius
//                                   .circular(20), topRight: Radius.circular(20)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20.0),
//                                 topRight: Radius.circular(20.0),
//                               ),
//                               child: Image.asset(
//                                   'images/property.jpg',
//                                   width: MediaQuery.of(context).size.width,
//                                   fit:BoxFit.fill
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.topRight,
//                             margin: EdgeInsets.only(right: 20, top: 20),
//                             child: FavoriteButton(
//                               isFavorite: false,
//                               valueChanged: (_isFavorite) {
//                                 print('Is Favorite : $_isFavorite');
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 13),
//                               height: 20,
//                               width: MediaQuery
//                                   .of(context)
//                                   .size
//                                   .width/2,
//                               child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(right: 13),
//                                 alignment: Alignment.topRight,
//                                 height: 20,
//                                 width: MediaQuery
//                                     .of(context)
//                                     .size
//                                     .width/2,
//                                 child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
//                               )
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Posted by : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                     // text: "Builder",
//                                       text: "Builder",
//                                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Location : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Surat",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Type : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Residential",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Status : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Under Construction",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               GestureDetector(
//                 onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail())),
//                 child: Container(
//                   height: 300,
//                   width: MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.9,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)
//                   ),
//                   child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           Container(
//                             height: 160,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.only(topLeft: Radius
//                                   .circular(20), topRight: Radius.circular(20)),
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(20.0),
//                                 topRight: Radius.circular(20.0),
//                               ),
//                               child: Image.asset(
//                                   'images/property.jpg',
//                                   width: MediaQuery.of(context).size.width,
//                                   fit:BoxFit.fill
//                               ),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.topRight,
//                             margin: EdgeInsets.only(right: 20, top: 20),
//                             child: FavoriteButton(
//                               isFavorite: false,
//                               valueChanged: (_isFavorite) {
//                                 print('Is Favorite : $_isFavorite');
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(left: 13),
//                               height: 20,
//                               width: MediaQuery
//                                   .of(context)
//                                   .size
//                                   .width/2,
//                               child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                           Expanded(
//                               child: Container(
//                                 margin: EdgeInsets.only(right: 13),
//                                 alignment: Alignment.topRight,
//                                 height: 20,
//                                 width: MediaQuery
//                                     .of(context)
//                                     .size
//                                     .width/2,
//                                 child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
//                               )
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Posted by : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                     // text: "Builder",
//                                       text: "Builder",
//                                       style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Location : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Surat",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Type : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Residential",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//                       SizedBox(height: 5),
//                       Container(
//                           alignment: Alignment.topLeft,
//                           margin: EdgeInsets.only(left: 13),
//                           child: RichText(
//                             text: TextSpan(
//                                 text: "Status : ",
//                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
//                                 children: [
//                                   TextSpan(
//                                       text: "Under Construction",
//                                       style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
//                                   )
//                                 ]
//                             ),
//                           )
//                       ),
//
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   Future<bool> signOut() async {
//     FirebaseUser user = await FirebaseAuth.instance.currentUser;
//     await FirebaseAuth.instance.signOut();
//   }
//
//   _fetch() async {
//     final firebaseUser = await FirebaseAuth.instance.currentUser;
//     if(firebaseUser != null) {
//       await FirebaseFirestore.instance
//           .collection('Users12')
//           .doc(firebaseUser.uid)
//           .get()
//           .then((ds) {
//         myEmail = ds.data()['Email'];
//         myName = ds.data()['Name'];
//         myPhone = ds.data()['Mobile Number'];
//         myRole = ds.data()['Role'];
//       }).catchError((e) {
//         print(e);
//       });
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/database_manager.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/Pages/sold_property.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:flutter_app_with_firebase/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login_page.dart';

class myHomepage extends StatefulWidget {
  @override
  _myHomepageState createState() => _myHomepageState();
}

class _myHomepageState extends State<myHomepage> with RestorationMixin {
  RestorableBool favalue = RestorableBool(false);

  Future resultsLoaded;

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    fetchDatabaseList1();
    refreshPage();
  }

  @override
  void dispose() {
    favalue.dispose();
    super.dispose();
  }

  bool isAnimate = false;

  final _auth = FirebaseAuth.instance.currentUser;
  String myEmail;
  String myName;
  String myPhone;
  List userProfilesList = [];
  List userProfilesList1 = [];
  String doc_id;
  String doc_id1;
  String f1;
  String seenCount;
  int seenCount1;
  bool _favStatus = false;
  List<String> favoritesList = [];
  String i1;

  //String id;
  var abc;

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  final Query profileList1 = FirebaseFirestore.instance
      .collection('Property Details')
      .where('markAsSold', isEqualTo: 'Available');

  Future getUsersList1() async {
    List itemsList = [];

    try {
      await profileList1.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Null> refreshPage() async {
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return;
    });
  }

  fetchDatabaseList() async {
    dynamic resultant = await DatabaseManager().getUsersList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList = resultant;
      });
    }
  }

  fetchDatabaseList1() async {
    dynamic resultant1 = await getUsersList1();

    if (resultant1 == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        userProfilesList1 = resultant1;
      });
    }
  }

  void setFav(String name, bool _currentFavStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(name, !_currentFavStatus);
    setState(() {});
  }

  int seeByUser = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView(
        children: [
          // Container(
          //   child: Row(
          //     children: [
          //       Expanded(
          //           child: Container(
          //             child: Text("Available(${userProfilesList1.length})"),
          //           )
          //       )
          //     ],
          //   ),
          // ),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.12,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30)),
                    color: Colors.indigo),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // child:
                child: Center(
                    child: Text("Hello, ${_auth.displayName}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Search_Page()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
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
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text("Available property(${userProfilesList1.length})",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 5),
          Container(
            child: RefreshIndicator(
              key: refreshKey,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: userProfilesList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('Property Details')
                            .get()
                            .then(
                              (QuerySnapshot snapshot) => {
                                // snapshot.documents.forEach((f) {
                                //
                                //   print("documentID---- " + f.reference.documentID);
                                //
                                // }),
                                //     snapshot.documents[index].data(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Property_Detail(id: doc_id, u2: i1))),
                                doc_id = snapshot.documents[index].documentID,
                                i1 = snapshot.documents[index].get('postById'),
                                print(i1),
                                //Firestore.instance.collection('Property Details').doc(doc_id).get().then((value) => value.data()['seenByUser']),
                                // seenCount = snapshot.docs[index]['seenByUser'.length],
                                // seenCount1 = seenCount.length,
                                // print('this is $seenCount'),
                                //print(snapshot.documents[index].documentID)
                                print(doc_id),
                              Firestore.instance
                                  .collection('Property Details')
                                  .doc('$doc_id')
                                  .set({
                              'seenByUser': FieldValue.arrayUnion(
                              ['${FirebaseAuth.instance.currentUser.uid}']),
                              }, SetOptions(merge: true)).then((value) => {}),
                              },
                            );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 320,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        userProfilesList[index]['firstImage'],
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 20, top: 20),
                                  child: FavoriteButton(
                                      isFavorite: false,
                                      valueChanged: (_isFavorite) {
                                        if (_isFavorite == true) {
                                          FirebaseFirestore.instance
                                              .collection('Property Details')
                                              .get()
                                              .then(
                                                  (QuerySnapshot snapshot) => {
                                                        // snapshot.documents.forEach((f) {
                                                        //    id = f.reference.documentID;
                                                        //   //print("documentID---- " + f.reference.documentID);
                                                        //
                                                        // }),
                                                        // print(snapshot.docs[index].documentID),
                                                        //snapshot.docs[index].data(),
                                                        f1 = snapshot
                                                            .documents[index]
                                                            .documentID,
                                                        Firestore.instance
                                                            .collection(
                                                                'Property Details')
                                                            .doc(f1)
                                                            .set(
                                                                {
                                                              'favorites':
                                                                  FieldValue
                                                                      .arrayUnion([
                                                                '${FirebaseAuth.instance.currentUser.uid}'
                                                              ]),
                                                              'propertyId':
                                                                  '$f1'
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true)).then(
                                                                (value) => {})
                                                      });
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('Property Details')
                                              .get()
                                              .then(
                                                  (QuerySnapshot snapshot) => {
                                                        f1 = snapshot
                                                            .documents[index]
                                                            .documentID,
                                                        Firestore.instance
                                                            .collection(
                                                                'Property Details')
                                                            .doc(f1)
                                                            .set(
                                                                {
                                                              'favorites':
                                                                  FieldValue
                                                                      .arrayRemove([
                                                                '${FirebaseAuth.instance.currentUser.uid}'
                                                              ])
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true)).then(
                                                                (value) => {})
                                                      });
                                        }
                                      }),
                                )
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 13),
                                    height: 30,
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                        userProfilesList[index]['project name'],
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  margin: EdgeInsets.only(right: 13),
                                  alignment: Alignment.topRight,
                                  height: 20,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(userProfilesList[index]['price'],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo)),
                                ))
                              ],
                            ),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Posted by : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            // text: "Builder",
                                            text: userProfilesList[index]
                                                ['posted by'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
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
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userProfilesList[index]
                                                ['city'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                            SizedBox(height: 7),
                            Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 13),
                                child: RichText(
                                  text: TextSpan(
                                      text: "Type : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: userProfilesList[index]
                                                ['category'],
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400))
                                      ]),
                                )),
                            SizedBox(height: 7),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 13),
                                      child: RichText(
                                        text: TextSpan(
                                            text: "Status : ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                            children: [
                                              TextSpan(
                                                  text: userProfilesList[index]
                                                      ['status'],
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ]),
                                      )),
                                ),
                                Expanded(
                                    child: Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 13),
                                  child: Text(
                                    userProfilesList[index]['markAsSold'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: userProfilesList[index]
                                                    ['markAsSold'] ==
                                                'Sold'
                                            ? Colors.red
                                            : Colors.green),
                                  ),
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              onRefresh: refreshPage,
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    //prefs.remove('phoneNumber');
    await FirebaseAuth.instance.signOut();
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(firebaseUser.uid)
          .get()
          .then((value) {
        myEmail = value.data()['email'];
        myName = value.data()['name'];
        myPhone = value.data()['mobileNumber'];
        // print(myEmail);
        // print(myName);
        // print(myPhone);
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future<void> resetpassword() {
    User _auth = FirebaseAuth.instance.currentUser;
    _auth.sendEmailVerification();
  }

  _handleAnimation(int index) {
    setState(() {
      isAnimate = !isAnimate;
      print(isAnimate);
    });
  }

  @override
  // TODO: implement restorationId
  String get restorationId => "favoritetest";

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    // TODO: implement restoreState
    registerForRestoration(favalue, restorationId);
  }
}
