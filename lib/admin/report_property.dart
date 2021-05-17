import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/admin/report_property_details.dart';

class Report_Property_Page extends StatefulWidget {
  const Report_Property_Page({Key key}) : super(key: key);

  @override
  _Report_Property_PageState createState() => _Report_Property_PageState();
}

class _Report_Property_PageState extends State<Report_Property_Page> {
  List reportPropertyList = [];
  String doc_id;
  String postedUser;

  final Query query = FirebaseFirestore.instance
      .collection('Property Details')
      .where('report', isEqualTo: true);

  Future getReportPropertyList() async {
    List reportPropertyList = [];

    try {
      await query.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          reportPropertyList.add(element.data());
        });
      });
      return reportPropertyList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchReportProperty() async {
    dynamic resultant = await getReportPropertyList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        reportPropertyList = resultant;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReportProperty();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Reports'),
          backgroundColor: Colors.indigo,
        ),
        body: StreamBuilder<QuerySnapshot> (
          stream: FirebaseFirestore.instance.collection('Report Property').snapshots(),
          builder: (context, snapshot) {
            return ListView(
              children: [
                SizedBox(height: 5),
                Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: reportPropertyList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance.collection("Report Property").get().then((QuerySnapshot snapshot) => {
                              doc_id = snapshot.documents[index].documentID,
                              postedUser = snapshot.docs[index].get('postedUser'),
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Report_Property_Details(id: doc_id, user: postedUser))),
                              print(doc_id),
                              print(postedUser),
                            });
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
                                              reportPropertyList[index]['firstImage'],
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
                                          child: Text(reportPropertyList[index]['project name'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
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
                                            child: Text(reportPropertyList[index]['price'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo)),
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
                                                  text: reportPropertyList[index]['posted by'],
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
                                                  text: reportPropertyList[index]['city'],
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
                                                  text: reportPropertyList[index]['category'],
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
                                                  text: reportPropertyList[index]['status'],
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
                ),
              ],
            );
          },
        )
    );
  }
}
