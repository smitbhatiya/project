import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String displayName, String email, String phoneNumber, String password, String role) async {
  CollectionReference users1 = FirebaseFirestore.instance.collection('Users12');
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  users1.document(firebaseUser.uid).set({
    'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}