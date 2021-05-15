import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/database_manager.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/admin/admin_search.dart';
import 'package:flutter_app_with_firebase/admin/report_property.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Admin_Page extends StatefulWidget {
  const Admin_Page({Key key}) : super(key: key);

  @override
  _Admin_PageState createState() => _Admin_PageState();
}

class _Admin_PageState extends State<Admin_Page> {
  RestorableBool favalue = RestorableBool(false);
  Future resultsLoaded;
  int view2;

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
  String i2;
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

  void viewCount() {
    view2 = view2++;
  }

  int seeByUser = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                title: Row(
                  children: [
                    Icon(Icons.report),
                    SizedBox(width: 25),
                    Text("Report Property")
                  ],
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Report_Property_Page()));
                }
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
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
                    child: Text("Hello, Admin",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Admin_Search()));
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
                            view2 = snapshot.docs[index].get('view'),
                            if(snapshot.docs[index].get('postById') == FirebaseAuth.instance.currentUser.uid) {
                              view2 = view2
                            } else {
                              view2 = view2+1
                            },
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Property_Detail(id: doc_id, u2: i1, v1: view2))),
                            doc_id = snapshot.documents[index].documentID,
                            i1 = snapshot.documents[index].get('postById'),
                            print(i1),
                            print(doc_id),
                            print(view2),
                            FirebaseFirestore.instance.collection('Property Details').doc(doc_id).updateData({
                              'view': view2
                            }),
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        height: 340,
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
                                // Container(
                                //   alignment: Alignment.topRight,
                                //   margin: EdgeInsets.only(right: 20, top: 20),
                                //   child: FavoriteButton(
                                //       isFavorite: false,
                                //       valueChanged: (_isFavorite) {
                                //         if (_isFavorite == true) {
                                //           FirebaseFirestore.instance
                                //               .collection('Property Details')
                                //               .get()
                                //               .then(
                                //                   (QuerySnapshot snapshot) => {
                                //                 // snapshot.documents.forEach((f) {
                                //                 //    id = f.reference.documentID;
                                //                 //   //print("documentID---- " + f.reference.documentID);
                                //                 //
                                //                 // }),
                                //                 // print(snapshot.docs[index].documentID),
                                //                 //snapshot.docs[index].data(),
                                //                 f1 = snapshot
                                //                     .documents[index]
                                //                     .documentID,
                                //                 Firestore.instance
                                //                     .collection(
                                //                     'Property Details')
                                //                     .doc(f1)
                                //                     .set(
                                //                     {
                                //                       'favorites':
                                //                       FieldValue
                                //                           .arrayUnion([
                                //                         '${FirebaseAuth.instance.currentUser.uid}'
                                //                       ]),
                                //                       'propertyId':
                                //                       '$f1'
                                //                     },
                                //                     SetOptions(
                                //                         merge:
                                //                         true)).then(
                                //                         (value) => {})
                                //               });
                                //         } else {
                                //           FirebaseFirestore.instance
                                //               .collection('Property Details')
                                //               .get()
                                //               .then(
                                //                   (QuerySnapshot snapshot) => {
                                //                 f1 = snapshot
                                //                     .documents[index]
                                //                     .documentID,
                                //                 Firestore.instance
                                //                     .collection(
                                //                     'Property Details')
                                //                     .doc(f1)
                                //                     .set(
                                //                     {
                                //                       'favorites':
                                //                       FieldValue
                                //                           .arrayRemove([
                                //                         '${FirebaseAuth.instance.currentUser.uid}'
                                //                       ])
                                //                     },
                                //                     SetOptions(
                                //                         merge:
                                //                         true)).then(
                                //                         (value) => {})
                                //               });
                                //         }
                                //       }),
                                // )
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
}
