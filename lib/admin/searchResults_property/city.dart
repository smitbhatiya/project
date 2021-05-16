import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class City_Search extends StatefulWidget {
  const City_Search({Key key}) : super(key: key);

  @override
  _City_SearchState createState() => _City_SearchState();
}

class _City_SearchState extends State<City_Search> {

  List cityListResult = [];

  final Query query3 = FirebaseFirestore.instance
      .collection("Property Details")
      .where("city", isEqualTo: "Surat");

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

  fetchCityList() async {
    dynamic cityResult = await getCityWithSearch();
    if(cityResult == null) {
      print("Unable to retrieve");
    } else {
      setState(() {
        cityListResult = cityResult;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCityList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: cityListResult.length,
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
                          cityListResult[index]['price'],
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
                              text: cityListResult[index]['posted by'],
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
                            text: cityListResult[index]['city'],
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
                            text: cityListResult[index]['category'],
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
                              text: cityListResult[index]['status'],
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
