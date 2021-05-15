import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  List Items2_2 = ["Project name", "City", "Area"];

  List projectnameListResult = [];
  List cityListResult = [];
  List areaListResult = [];

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
                              child: Text("Area"),
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
              // RaisedButton(
              //   onPressed: () {},
              //
              // ),
            ],
          ),
        ),
        if (Items1[_value1] == "Property")
            if(Items2_2[_value2_2] == "Project name")
                Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: projectnameListResult.length,
                    itemBuilder: (context, index) {
                    return Container(
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
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                                  child: Image.network(
                                    projectnameListResult[index]['firstImage'],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.fill,
                                  ),
                                ),
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
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text(
                                    projectnameListResult[index]['project name'],
                                    style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(right: 13),
                                alignment: Alignment.topRight,
                                height: 30,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  projectnameListResult[index]['price'],
                                  style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
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
                              text: "Posted by : ",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w700),
                              children: [
                              TextSpan(
                                text: projectnameListResult[index]
                                ['posted by'],
                                style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400))
                              ]),
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
                                fontWeight: FontWeight.w700),
                              children: [
                              TextSpan(
                                text: projectnameListResult[index]['city'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              )
                              ])),
                          ),
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
                                text: projectnameListResult[index]['category'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                                )
                              ]),
                            ),
                          ),
                          SizedBox(height: 7),
                          Container(
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
                              text: projectnameListResult[index]['status'],
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w400))
                              ]),
                            ),
                          )
                        ],
                      ),
                    );
                    },
                    ),
                ) else if(Items2_2[_value2_2] == "Area") Container(
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemCount: areaListResult.length,
    itemBuilder: (context, index) {
    return Container(
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
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20)),
    child: Image.network(
    areaListResult[index]['firstImage'],
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.fill,
    ),
    ),
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
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
    areaListResult[index]['project name'],
    style: TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold),
    ),
    ),
    ),
    Expanded(
    child: Container(
    margin: EdgeInsets.only(right: 13),
    alignment: Alignment.topRight,
    height: 30,
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
    areaListResult[index]['price'],
    style: TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold),
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
    text: "Posted by : ",
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700),
    children: [
    TextSpan(
    text: areaListResult[index]
    ['posted by'],
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400))
    ]),
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
    fontWeight: FontWeight.w700),
    children: [
    TextSpan(
    text: areaListResult[index]['city'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400),
    )
    ])),
    ),
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
    text: areaListResult[index]['category'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400),
    )
    ]),
    ),
    ),
    SizedBox(height: 7),
    Container(
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
    text: areaListResult[index]['status'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400))
    ]),
    ),
    )
    ],
    ),
    );
    },
    ),
    ) else if (Items2_2[_value2_2] == "City")
    Container(
    child: ListView.builder(
    scrollDirection: Axis.vertical,
    shrinkWrap: true,
    physics: ScrollPhysics(),
    itemCount: cityListResult.length,
    itemBuilder: (context, index) {
    return Container(
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
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20)),
    child: Image.network(
    cityListResult[index]['firstImage'],
    width: MediaQuery.of(context).size.width,
    fit: BoxFit.fill,
    ),
    ),
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
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
    cityListResult[index]['project name'],
    style: TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold),
    ),
    ),
    ),
    Expanded(
    child: Container(
    margin: EdgeInsets.only(right: 13),
    alignment: Alignment.topRight,
    height: 30,
    width: MediaQuery.of(context).size.width / 2,
    child: Text(
    cityListResult[index]['price'],
    style: TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold),
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
    text: "Posted by : ",
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w700),
    children: [
    TextSpan(
    text: cityListResult[index]
    ['posted by'],
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400))
    ]),
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
    fontWeight: FontWeight.w700),
    children: [
    TextSpan(
    text: cityListResult[index]['city'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400),
    )
    ])),
    ),
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
    text: cityListResult[index]['category'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400),
    )
    ]),
    ),
    ),
    SizedBox(height: 7),
    Container(
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
    text: cityListResult[index]['status'],
    style: TextStyle(
    fontSize: 18,
    color: Colors.black,
    fontWeight: FontWeight.w400))
    ]),
    ),
    )
    ],
    ),
    );
    },
    ),
    )
    else Container()
    else
      if(Items2_1[_value2_1] == "Name") Container()
      ],
    )
    )
    );
  }
}
