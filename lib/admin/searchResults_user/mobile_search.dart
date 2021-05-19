import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Mobile_Search extends StatefulWidget {
  final String ms;
  const Mobile_Search({Key key, this.ms}) : super(key: key);

  @override
  _Mobile_SearchState createState() => _Mobile_SearchState();
}

class _Mobile_SearchState extends State<Mobile_Search> {

  List mobileListResult = [];
  final Query query3 = FirebaseFirestore
      .instance
      .collection("Users12")
      .where("Mobile Number", isEqualTo: "2516256511");

  Future getMobileWithSearch() async {
    List mobileList = [];
    try {
      await query3.getDocuments().then((querySnapshot) => {
        querySnapshot.docs.forEach((element) {
          mobileList.add(element.data());
        })
      });
      return mobileList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchMobileList() async {
    dynamic mobileResult = await getMobileWithSearch();

    if(mobileResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        mobileListResult = mobileResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMobileList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: (widget.ms != "" && widget.ms != null)
            ? FirebaseFirestore
            .instance
            .collection("Users12")
            .where('Mobile Number', isEqualTo: widget.ms)
            .snapshots()
            : FirebaseFirestore
            .instance
            .collection("Users12")
            .where('Role', isNotEqualTo: 'Admin')
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.docs[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: CircleAvatar(
                              radius: 30,
                              child: Text(
                                data['Name'][0],
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    data['Name'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: Text(
                                    data['Email'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  child: Text(
                                    data['Role'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
          );
        }
      ),
    );
  }
}
