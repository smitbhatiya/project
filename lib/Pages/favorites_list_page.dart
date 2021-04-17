import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/database_manager.dart';
import 'package:flutter_app_with_firebase/Model/favorite_post_List.dart';
import 'package:flutter_app_with_firebase/Model/userpost_manager.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavoritePost extends StatefulWidget {
  @override
  _MyFavoritePostState createState() => _MyFavoritePostState();
}

class _MyFavoritePostState extends State<MyFavoritePost> {
  bool isAnimate = false;

  //final _auth= FirebaseAuth.instance.currentUser;
  List FavoritePostList = [];
  String doc_id;
  String doc_id1;
  //bool f1;
  //String id;
  //var abc;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    refreshPage();
  }
  Future<Null> refreshPage() async{
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return ;
    });
  }
  fetchDatabaseList() async {
    dynamic resultant = await FavoritePostManager().getFavoritePostList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        FavoritePostList = resultant;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body:ListView(
        children: [
          SizedBox(height: 15),
          Container(
            child: RefreshIndicator(
              key: refreshKey,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: FavoritePostList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        //   var uid =FirebaseAuth.instance.currentUser.uid;
                        //   var _randomId = FirebaseFirestore.instance.collection('propertyDetails').document(uid);
                        //   print(_randomId);
                        // var firebaseUser =  FirebaseAuth.instance.currentUser;
                        // FirebaseFirestore.instance.collection("propertyDetails").doc(firebaseUser.uid).get().then((value){
                        //   print(value.data());
                        // });
                        FirebaseFirestore.instance
                            .collection('Users12')
                            .document(FirebaseAuth.instance.currentUser.uid)
                            .collection('favoriteList')
                            .get()
                            .then(
                              (QuerySnapshot snapshot) => {
                            // snapshot.documents.forEach((f) {
                            //
                            //   print("documentID---- " + f.reference.documentID);
                            //
                            // }),
                            //     snapshot.documents[index].data(),
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail(id:doc_id))),
                            doc_id = snapshot.documents[index].documentID,
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
                                    borderRadius: BorderRadius.only(topLeft: Radius
                                        .circular(20), topRight: Radius.circular(20)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                    child: Image.network(
                                        FavoritePostList[index]['firstImage'],
                                        width: MediaQuery.of(context).size.width,
                                        fit:BoxFit.fill
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
                                        .width/2,
                                    child: Text(FavoritePostList[index]['project name'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                                      child: Text(FavoritePostList[index]['price'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                          // text: "Builder",
                                            text: FavoritePostList[index]['posted by'],
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
                                            text: FavoritePostList[index]['city'],
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
                                      text: "Type : ",
                                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: FavoritePostList[index]['category'],
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
                                      text: "Status : ",
                                      style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
                                      children: [
                                        TextSpan(
                                            text: FavoritePostList[index]['status'],
                                            style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
                                        )
                                      ]
                                  ),
                                )
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

    // ListView(
    //   // child: Center(child: Text("${_auth.displayName}")),
    //   children: [
    //     Column(
    //       children: [
    //         Stack(
    //           children: [
    //             Container(
    //               height: MediaQuery
    //                   .of(context)
    //                   .size
    //                   .height * 0.12,
    //               width: MediaQuery
    //                   .of(context)
    //                   .size
    //                   .width,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.only(
    //                       bottomRight: Radius.circular(30),
    //                       bottomLeft: Radius.circular(30)),
    //                   color: Colors.indigo
    //               ),
    //             ),
    //             Container(
    //               margin: EdgeInsets.only(top: 15),
    //               // child:
    //               child: Center(child: Text("Hello, ${_auth.displayName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
    //             ),
    //             GestureDetector(
    //               onTap: () {
    //                 Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Search_Page()));
    //               },
    //               child: Container(
    //                 margin: EdgeInsets.only(top: 80, left: 30, right: 30),
    //                 height: 50,
    //                 width: MediaQuery
    //                     .of(context)
    //                     .size
    //                     .width * 0.9,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(30),
    //                   color: Colors.white,
    //                 ),
    //                 padding: EdgeInsets.only(left: 30, top: 15),
    //                 child: Text("Search",
    //                     style: TextStyle(color: Colors.grey, fontSize: 16)),
    //               ),
    //             )
    //           ],
    //         ),
    //         SizedBox(height: 30),
    //         // GestureDetector(
    //         //   onTap: () {
    //         //     Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
    //         //   },
    //         //   child: Container(
    //         //     height: 280,
    //         //     width: MediaQuery
    //         //         .of(context)
    //         //         .size
    //         //         .width * 0.9,
    //         //     decoration: BoxDecoration(
    //         //         color: Colors.indigo.shade300,
    //         //         borderRadius: BorderRadius.circular(20)
    //         //     ),
    //         //     child: Column(
    //         //       children: [
    //         //         Stack(
    //         //           children: [
    //         //             Container(
    //         //               height: 140,
    //         //               decoration: BoxDecoration(
    //         //                   borderRadius: BorderRadius.only(topLeft: Radius
    //         //                       .circular(20), topRight: Radius.circular(20)),
    //         //                   color: Colors.white
    //         //               ),
    //         //               // child: Image(image: AssetImage(""), fit: BoxFit.cover),
    //         //             ),
    //         //             Container(
    //         //               alignment: Alignment.topRight,
    //         //               margin: EdgeInsets.only(right: 20, top: 20),
    //         //               child: FavoriteButton(
    //         //                 isFavorite: false,
    //         //                 valueChanged: (_isFavorite) {
    //         //                   print('Is Favorite : $_isFavorite');
    //         //                 },
    //         //               ),
    //         //             ),
    //         //           ],
    //         //         ),
    //         //         Row(
    //         //           children: [
    //         //             Container(color: Colors.yellow,
    //         //                 height: 30,
    //         //                 width: MediaQuery
    //         //                     .of(context)
    //         //                     .size
    //         //                     .width * 0.45),
    //         //             Container(
    //         //                 color: Colors.red, height: 30, width: MediaQuery
    //         //                 .of(context)
    //         //                 .size
    //         //                 .width * 0.45)
    //         //           ],
    //         //         )
    //         //       ],
    //         //     ),
    //         //   ),
    //         // ),
    //         GestureDetector(
    //           onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => propertyDetail())),
    //           child: Container(
    //             height: 300,
    //             width: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .width * 0.9,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(20)
    //             ),
    //             child: Column(
    //               children: [
    //                 Stack(
    //                   children: [
    //                     Container(
    //                       height: 160,
    //                       decoration: BoxDecoration(
    //                         borderRadius: BorderRadius.only(topLeft: Radius
    //                             .circular(20), topRight: Radius.circular(20)),
    //                       ),
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.only(
    //                           topLeft: Radius.circular(20.0),
    //                           topRight: Radius.circular(20.0),
    //                         ),
    //                         child: Image.asset(
    //                             'image/home.jpg',
    //                             width: MediaQuery.of(context).size.width,
    //                             fit:BoxFit.fill
    //                         ),
    //                       ),
    //                     ),
    //                     Container(
    //                       alignment: Alignment.topRight,
    //                       margin: EdgeInsets.only(right: 20, top: 20),
    //                       child: FavoriteButton(
    //                         isFavorite: false,
    //                         valueChanged: (_isFavorite) {
    //                           print('Is Favorite : $_isFavorite');
    //                         },
    //                       ),
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(height: 5),
    //                 Row(
    //                   children: [
    //                     Expanded(
    //                       child: Container(
    //                         margin: EdgeInsets.only(left: 13),
    //                         height: 20,
    //                         width: MediaQuery
    //                             .of(context)
    //                             .size
    //                             .width/2,
    //                         child: Text("Silver Villa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //                       ),
    //                     ),
    //                     Expanded(
    //                         child: Container(
    //                           margin: EdgeInsets.only(right: 13),
    //                           alignment: Alignment.topRight,
    //                           height: 20,
    //                           width: MediaQuery
    //                               .of(context)
    //                               .size
    //                               .width/2,
    //                           child: Text("2,00,000 per month", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
    //                         )
    //                     )
    //                   ],
    //                 ),
    //                 SizedBox(height: 5),
    //                 Container(
    //                     alignment: Alignment.topLeft,
    //                     margin: EdgeInsets.only(left: 13),
    //                     child: RichText(
    //                       text: TextSpan(
    //                           text: "Posted by : ",
    //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
    //                           children: [
    //                             TextSpan(
    //                               // text: "Builder",
    //                                 text: "Builder",
    //                                 style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400)
    //                             )
    //                           ]
    //                       ),
    //                     )
    //                 ),
    //                 SizedBox(height: 5),
    //                 Container(
    //                     alignment: Alignment.topLeft,
    //                     margin: EdgeInsets.only(left: 13),
    //                     child: RichText(
    //                       text: TextSpan(
    //                           text: "Location : ",
    //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
    //                           children: [
    //                             TextSpan(
    //                                 text: "Surat",
    //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
    //                             )
    //                           ]
    //                       ),
    //                     )
    //                 ),
    //                 SizedBox(height: 5),
    //                 Container(
    //                     alignment: Alignment.topLeft,
    //                     margin: EdgeInsets.only(left: 13),
    //                     child: RichText(
    //                       text: TextSpan(
    //                           text: "Type : ",
    //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
    //                           children: [
    //                             TextSpan(
    //                                 text: "Residential",
    //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
    //                             )
    //                           ]
    //                       ),
    //                     )
    //                 ),
    //                 SizedBox(height: 5),
    //                 Container(
    //                     alignment: Alignment.topLeft,
    //                     margin: EdgeInsets.only(left: 13),
    //                     child: RichText(
    //                       text: TextSpan(
    //                           text: "Status : ",
    //                           style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
    //                           children: [
    //                             TextSpan(
    //                                 text: "Under Construction",
    //                                 style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400)
    //                             )
    //                           ]
    //                       ),
    //                     )
    //                 ),
    //
    //               ],
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 30),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
    //           },
    //           child: Container(
    //             height: 280,
    //             width: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .width * 0.9,
    //             decoration: BoxDecoration(
    //                 color: Colors.indigo.shade300,
    //                 borderRadius: BorderRadius.circular(20)
    //             ),
    //             child: Column(
    //               children: [
    //                 Stack(
    //                   children: [
    //                     Container(
    //                       height: 140,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(topLeft: Radius
    //                               .circular(20), topRight: Radius.circular(20)),
    //                           color: Colors.white
    //                       ),
    //                       // child: Image(image: AssetImage(""), fit: BoxFit.cover),
    //                     ),
    //                     Container(
    //                       alignment: Alignment.topRight,
    //                       margin: EdgeInsets.only(right: 20, top: 20),
    //                       child: FavoriteButton(
    //                         isFavorite: false,
    //                         valueChanged: (_isFavorite) {
    //                           print('Is Favorite : $_isFavorite');
    //                         },
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(color: Colors.yellow,
    //                         height: 30,
    //                         width: MediaQuery
    //                             .of(context)
    //                             .size
    //                             .width * 0.45),
    //                     Container(
    //                         color: Colors.red, height: 30, width: MediaQuery
    //                         .of(context)
    //                         .size
    //                         .width * 0.45)
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //         SizedBox(height: 30),
    //         GestureDetector(
    //           onTap: () {
    //             Navigator.of(context).push(MaterialPageRoute(builder: (context)=>propertyDetail()));
    //           },
    //           child: Container(
    //             height: 280,
    //             width: MediaQuery
    //                 .of(context)
    //                 .size
    //                 .width * 0.9,
    //             decoration: BoxDecoration(
    //                 color: Colors.indigo.shade300,
    //                 borderRadius: BorderRadius.circular(20)
    //             ),
    //             child: Column(
    //               children: [
    //                 Stack(
    //                   children: [
    //                     Container(
    //                       height: 140,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.only(topLeft: Radius
    //                               .circular(20), topRight: Radius.circular(20)),
    //                           color: Colors.white
    //                       ),
    //                       // child: Image(image: AssetImage(""), fit: BoxFit.cover),
    //                     ),
    //                     Container(
    //                       alignment: Alignment.topRight,
    //                       margin: EdgeInsets.only(right: 20, top: 20),
    //                       child: FavoriteButton(
    //                         isFavorite: false,
    //                         valueChanged: (_isFavorite) {
    //                           print('Is Favorite : $_isFavorite');
    //                         },
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(
    //                   children: [
    //                     Container(color: Colors.yellow,
    //                         height: 30,
    //                         width: MediaQuery
    //                             .of(context)
    //                             .size
    //                             .width * 0.45),
    //                     Container(
    //                         color: Colors.red, height: 30, width: MediaQuery
    //                         .of(context)
    //                         .size
    //                         .width * 0.45)
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         )
    //       ],
    //     )
    //   ],
    // ),
  }
// Future<bool> signOut() async {
//   SharedPreferences prefs=await SharedPreferences.getInstance();
//   prefs.remove('email');
//   //prefs.remove('phoneNumber');
//   await FirebaseAuth.instance.signOut();
// }
// _fetch() async {
//   final firebaseUser = await FirebaseAuth.instance.currentUser;
//   if(firebaseUser!=null){
//     await FirebaseFirestore.instance
//         .collection('Users')
//         .doc(firebaseUser.uid)
//         .get()
//         .then((value){
//       myEmail=value.data()['email'];
//       myName=value.data()['name'];
//       myPhone=value.data()['mobileNumber'];
//     }).catchError((e){
//       print(e);
//     });
//   }
// }
// Future<void> resetpassword(){
//   User _auth = FirebaseAuth.instance.currentUser;
//   _auth.sendEmailVerification();
//
// }
// _handleAnimation(int index) {
//   setState(() {
//     isAnimate = !isAnimate;
//     print(isAnimate);
//   });
}