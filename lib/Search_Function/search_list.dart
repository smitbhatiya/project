import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Filteration_Page extends StatefulWidget {
  @override
  _Filteration_PageState createState() => _Filteration_PageState();
}

class _Filteration_PageState extends State<Filteration_Page> {
  getSearchResult() {
    return Firestore.instance
        .collection('Property Details')
        .where('favorites', arrayContains: FirebaseAuth.instance.currentUser.uid)
        .get().then((value) => {
          Text("$value"),
      print(value)
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: getSearchResult(),
        ),
      ),
    );
  }
}
