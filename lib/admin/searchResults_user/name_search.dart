import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Name_Search extends StatefulWidget {
  const Name_Search({Key key}) : super(key: key);

  @override
  _Name_SearchState createState() => _Name_SearchState();
}

class _Name_SearchState extends State<Name_Search> {
  
  List nameListResult = [];
  final Query query1 = FirebaseFirestore.instance
      .collection("Users12")
      .where("Name", isEqualTo: "smit");

  Future getNameWithSearch() async {
    List nameList = [];
    try {
      await query1.getDocuments().then((querySnapshot) => {
        querySnapshot.documents.forEach((element) {
          nameList.add(element.data());
        })
      });
      return nameList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchNameList() async {
    dynamic nameResult = await getNameWithSearch();

    if(nameResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        nameListResult = nameResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNameList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: nameListResult.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10),
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
                      nameListResult[index]['Name'][0],
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
                          nameListResult[index]['Name'],
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
                          nameListResult[index]['Email'],
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
                          nameListResult[index]['Role'],
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          );
        },
      ),
    );
  }
}
