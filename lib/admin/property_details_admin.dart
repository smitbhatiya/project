import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/area.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/city.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/project_name.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/email_search.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/mobile_search.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/name_search.dart';

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
                                              userData["price"],
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

class Admin_Search extends StatefulWidget {
  const Admin_Search({Key key}) : super(key: key);

  @override
  _Admin_SearchState createState() => _Admin_SearchState();
}

class _Admin_SearchState extends State<Admin_Search> {
  int _value1 = 0;
  int _value2_1 = 0;
  int _value2_2 = 0;
  List Items1 = ["User", "Property"];
  List Items2_1 = ["Name", "Email", "Mobile Number"];
  List Items2_2 = ["Project name", "City", "Landmark"];

  List projectnameListResult = [];
  List cityListResult = [];
  List areaListResult = [];
  String name = "";

  @override
  void initState() {
    super.initState();
    fetchProjectnameList();
    fetchAreaList();
    fetchCityList();
  }

  final Query query1 = FirebaseFirestore.instance
      .collection("Property Details")
      .where('project name', isEqualTo: "Hemilton");

  final Query query2 = FirebaseFirestore.instance
      .collection("Property Details")
      .where("landmark", isEqualTo: "Katargam");

  final Query query3 = FirebaseFirestore.instance
      .collection("Property Details")
      .where("city", isEqualTo: "Surat");

  Future getProjectnameWithSearch() async {
    List projectnameList = [];
    try {
      await query1.getDocuments().then((querySnapshot) => {
            querySnapshot.documents.forEach((element) {
              projectnameList.add(element.data());
            })
          });
      return projectnameList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getCityWithSearch() async {
    List cityList = [];
    try {
      await query3.getDocuments().then((querySnapshot) => {
            querySnapshot.documents.forEach((element) {
              cityList.add(element.data());
            })
          });
      return cityList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getAreaWithSearch() async {
    List areaList = [];
    try {
      await query2.getDocuments().then((querySnapshot) => {
            querySnapshot.documents.forEach((element) {
              areaList.add(element.data());
            })
          });
      return areaList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchProjectnameList() async {
    dynamic projectnameResult = await getProjectnameWithSearch();

    if (projectnameResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        projectnameListResult = projectnameResult;
      });
    }
  }

  fetchAreaList() async {
    dynamic areaResult = await getAreaWithSearch();

    if (areaResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        areaListResult = areaResult;
      });
    }
  }

  fetchCityList() async {
    dynamic cityResult = await getCityWithSearch();

    if (cityResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        cityListResult = cityResult;
      });
    }
  }

  TextEditingController adminSearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButton(
                          value: _value1,
                          items: [
                            DropdownMenuItem(
                              child: Text("User"),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Text("Property"),
                              value: 1,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _value1 = value;
                            });
                            print(Items1[_value1]);
                          }),
                    ),
                    SizedBox(width: 8),
                    DropdownButton(
                        value:
                            Items1[_value1] == "User" ? _value2_1 : _value2_2,
                        items: Items1[_value1] == "User"
                            ? [
                                DropdownMenuItem(
                                  child: Text("Name"),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("Email"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Mobile Number"),
                                  value: 2,
                                )
                              ]
                            : [
                                DropdownMenuItem(
                                  child: Text("Project name"),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("City"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Landmark"),
                                  value: 2,
                                )
                              ],
                        onChanged: (value) {
                          setState(() {
                            Items1[_value1] == "User"
                                ? _value2_1 = value
                                : _value2_2 = value;
                          });
                          print(Items1[_value1] == "User"
                              ? Items2_1[_value2_1]
                              : Items2_2[_value2_2]);
                        }),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                width: MediaQuery.of(context).size.width * 0.92,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        if (Items1[_value1] == "Property")
          if (Items2_2[_value2_2] == "Project name")
            Project_Name_Search(pn: name)
          else if (Items2_2[_value2_2] == "Landmark")
            Area_Search(as: name)
          else if (Items2_2[_value2_2] == "City")
            City_Search(cs: name)
          else
            Container()
        else if (Items2_1[_value2_1] == "Name")
          Name_Search(ns: name)
        else if (Items2_1[_value2_1] == "Email")
          Email_Search(es: name)
        else if (Items2_1[_value2_1] == "Mobile Number")
          Mobile_Search(ms: name)
        else
          Container()
      ],
    )));
  }
}
