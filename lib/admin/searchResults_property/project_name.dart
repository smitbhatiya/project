import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/admin/admin_search.dart';

class Project_Name_Search extends StatefulWidget {
  const Project_Name_Search({Key key}) : super(key: key);

  @override
  _Project_Name_SearchState createState() => _Project_Name_SearchState();
}

class _Project_Name_SearchState extends State<Project_Name_Search> {

  List projectnameListResult = [];

  final Query query1 = FirebaseFirestore.instance
      .collection("Property Details")
      .where("project name", isEqualTo: "Hemilton");

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

  fetchProjectnameList() async {
    dynamic projectnameResult = await getProjectnameWithSearch();

    if(projectnameResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        projectnameListResult = projectnameResult;
      });
    }
  }

  @override
  // ignore: must_call_super
  void initState() {
    super.initState();
    fetchProjectnameList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: projectnameListResult.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
            height: 320,
            width: MediaQuery.of(context).size.width * 0.9,
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
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20)
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                        ),
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
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
                            fontSize: 25,
                            fontWeight: FontWeight.bold
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
                      text: "Posted by : ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                      ),
                      children: [
                        TextSpan(
                          text: projectnameListResult[index]['posted by'],
                          style: TextStyle(
                            fontSize: 16,
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
                      text: "Location : ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                      ),
                      children: [
                        TextSpan(
                          text: projectnameListResult[index]['city'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
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
                      text: "Type : ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                      ),
                      children: [
                        TextSpan(
                          text: projectnameListResult[index]['category'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                          ),
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
                      text: "Status : ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700
                      ),
                      children: [
                        TextSpan(
                          text: projectnameListResult[index]['status'],
                          style: TextStyle(
                            fontSize: 18,
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
          );
        },
      ),
    );
  }
}
