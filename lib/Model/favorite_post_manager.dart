import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritePostManager {
  final Query query = FirebaseFirestore.instance
      .collection('Property Details')
      .where('favorites', arrayContains: FirebaseAuth.instance.currentUser.uid);

  Future getFavoritePostList() async {
    List itemsList = [];

    try {
      await query.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
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
