import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart' as property;
import 'review_page.dart' as review_manage;


class ReviewManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  //final String review_1 = review_manage.id1;
  //String id2 = property.widget.id;
  final CollectionReference reviewList =
  FirebaseFirestore.instance
      .collection('Property Details');


  Future getReviewList() async {
    List itemsList = [];
    try {
      await reviewList.doc('eEty6OuU1NazQC4fZMnp').collection('reviewBox').getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          // if(element.data()['postById'] == FirebaseAuth.instance.currentUser.uid) {
          //   itemsList.add(element.data());
          // }
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}