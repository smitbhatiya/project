import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePostManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  // final favoritepostList =
  // FirebaseFirestore.instance
  //     .collection('Property Details');
  final Query query = FirebaseFirestore.instance
      .collection('Property Details')
      .where('favorites', arrayContains: FirebaseAuth.instance.currentUser.uid);

  Future getFavoritePostList() async {
    List itemsList = [];

    try {
      await query.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          // if(element.data()['favorites'][0] == FirebaseAuth.instance.currentUser.uid) {
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
