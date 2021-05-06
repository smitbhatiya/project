import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Sold_Property extends StatefulWidget {

  @override
  _Sold_PropertyState createState() => _Sold_PropertyState();
}

class _Sold_PropertyState extends State<Sold_Property> {

  List soldList = [];

  fetchSoldList() async {
    dynamic resultant = await getSoldList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        soldList = resultant;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSoldList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot> (
        stream: FirebaseFirestore.instance.collection('Property Details').snapshots(),
        builder: (context, snapshot) {
          return ListView(
            children: [
              SizedBox(height: 8),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text("Sold property(${soldList.length})", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              Container(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: soldList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data.docs[index];
                      return Container(
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
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius
                                              .circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                      ),
                                      child: Image.network(
                                          soldList[index]['firstImage'],
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          fit: BoxFit.fill
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
                                          .width / 2,
                                      child: Text(
                                          soldList[index]['project name'],
                                          style: TextStyle(fontSize: 25,
                                              fontWeight: FontWeight.bold)),
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
                                            .width / 2,
                                        child: Text(soldList[index]['price'],
                                            style: TextStyle(fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.indigo)),
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
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                            // text: "Builder",
                                              text: soldList[index]['posted by'],
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w400)
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
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: soldList[index]['city'],
                                              style: TextStyle(fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)
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
                                        style: TextStyle(fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700),
                                        children: [
                                          TextSpan(
                                              text: soldList[index]['category'],
                                              style: TextStyle(fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)
                                          )
                                        ]
                                    ),
                                  )
                              ),
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
                                              style: TextStyle(fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700),
                                              children: [
                                                TextSpan(
                                                    text: soldList[index]['status'],
                                                    style: TextStyle(fontSize: 18,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w400)
                                                )
                                              ]
                                          ),
                                        )
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(right: 13),
                                        child: Text(soldList[index]['markAsSold'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
                                      )
                                  )
                                ],
                              ),
                            ],
                          ),
                        );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
  final Query query = FirebaseFirestore.instance
      .collection('Property Details')
      .where('markAsSold', isEqualTo: 'Sold');

  Future getSoldList() async {
    List soldItemsList = [];

    try {
      await query.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          // if(element.data()['favorites'][0] == FirebaseAuth.instance.currentUser.uid) {
          //   itemsList.add(element.data());
          // }
          soldItemsList.add(element.data());
        });
      });
      return soldItemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
