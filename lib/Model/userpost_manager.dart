import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserpostManager {
  // var firebaseUser = FirebaseAuth.instance.currentUser;
  // FirebaseAuth auth = FirebaseAuth.instance;
  //FirebaseFirestore.instance.collection('Users12').document(firebaseUser.uid).collection('usersPost');
  final CollectionReference postList =
  FirebaseFirestore.instance
      .collection('Property Details');


  Future getUsersPostList() async {
    List itemsList = [];
    try {
      await postList.getDocuments().then((querySnapshot) {
        querySnapshot.documents.forEach((element) {
          if(element.data()['postById'] == FirebaseAuth.instance.currentUser.uid) {
            itemsList.add(element.data());
          }
        });
      });
      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}