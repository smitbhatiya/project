import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/area.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/city.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_property/project_name.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/email_search.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/mobile_search.dart';
import 'package:flutter_app_with_firebase/admin/searchResults_user/name_search.dart';

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
                      value: Items1[_value1] == "User" ? _value2_1 : _value2_2,
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
                      fontWeight: FontWeight.w500
                    ),
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
            if(Items2_2[_value2_2] == "Project name")
              Project_Name_Search(pn: name)
              else if(Items2_2[_value2_2] == "Landmark")
                Area_Search(as: name)
                else if (Items2_2[_value2_2] == "City")
                  City_Search(cs: name)
                    else
                      Container()
        else
              if(Items2_1[_value2_1] == "Name")
                Name_Search(ns: name)
                  else if(Items2_1[_value2_1] == "Email")
                    Email_Search(es: name)
                      else if(Items2_1[_value2_1] == "Mobile Number")
                        Mobile_Search(ms: name)
                          else
                            Container()
      ],
    )
    )
    );
  }
}
