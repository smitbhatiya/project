import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Search_Function/search_list.dart';

class SearchResultList extends StatefulWidget {
  @override
  _SearchResultListState createState() => _SearchResultListState();
}

class _SearchResultListState extends State<SearchResultList> {
  bool resultFlag = false;
  var results;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchService().getSearchResult('Samarthya', '1400').then((QuerySnapshot docs) {
      if(docs.documents.isNotEmpty) {
        resultFlag = true;
        results = docs.documents[0].data();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Results',
            style: TextStyle(fontSize: 17),
          ),
          SizedBox(height: 10),
          Container(
            height: 0.5,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
