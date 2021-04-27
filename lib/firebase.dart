import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

Future<void> postProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String pro_detail, String area, String price, String description, String con_status, String url_link, String first_image, String user_id) async {
  CollectionReference property = FirebaseFirestore.instance.collection('Property Details');
  // DocumentReference documentReference = FirebaseFirestore.instance.collection('Property Details').doc();
  // pro_id = documentReference.id;
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  property.document().set({
    'category': category,
    'posted by': postBy,
    'sell or rent': sr_radio,
    'property type': pro_type,
    'project name': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'detail': pro_detail,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status,
    'url': url_link,
    'firstImage': first_image,
    'postById': user_id,
    //'propertyId': pro_id
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}

Future<void> postCommProperty(String category, String postBy, String sr_radio, String pro_type, String projectName, String address, String landmark, String city, String state, String area, String price, String description, String con_status) async {
  CollectionReference property = FirebaseFirestore.instance.collection('Property Details');
  //var firebaseUser = await FirebaseAuth.instance.currentUser;
  //FirebaseAuth auth = FirebaseAuth.instance;
  //String uid = auth.currentUser.uid.toString();
  property.document().set({
    'category': category,
    'posted by': postBy,
    'sell or rent': sr_radio,
    'property type': pro_type,
    'project name': projectName,
    'address': address,
    'landmark': landmark,
    'city': city,
    'state': state,
    'area': area,
    'price': price,
    'description': description,
    'status': con_status
  });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}

Future<void> FavoriteProperty(String category, String postBy, String projectName, String city, String price, String con_status, String first_image) async {
  var firebaseUser = await FirebaseAuth.instance.currentUser;
  CollectionReference users2 = FirebaseFirestore.instance.collection('Users12');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  CollectionReference property = FirebaseFirestore.instance.collection('favoriteList');
  users2.document(firebaseUser.uid).collection('favoriteList').document().set({
    'category': category,
    'posted by': postBy,
    'project name': projectName,
    'city': city,
    'price': price,
    'status': con_status,
    'firstImage': first_image
  });

  // property.document().set({
  //   'category': category,
  //   'posted by': postBy,
  //   'project name': projectName,
  //   'city': city,
  //   'price': price,
  //   'status': con_status,
  //   'firstImage': first_image
  // });
  // users1.add({'Name': displayName, 'User Id': uid, 'Email': email, 'Mobile Number': phoneNumber, 'Password': password, 'Role': role});
  return;
}