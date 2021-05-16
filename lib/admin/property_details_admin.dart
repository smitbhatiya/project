import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Admin_Property_Details extends StatefulWidget {
  final String id;
  const Admin_Property_Details({Key key, this.id}) : super(key: key);

  @override
  _Admin_Property_DetailsState createState() => _Admin_Property_DetailsState();
}

class _Admin_Property_DetailsState extends State<Admin_Property_Details> {
  CollectionReference data1 = FirebaseFirestore.instance.collection('Property Details');
  CollectionReference data2 = FirebaseFirestore.instance.collection('Users12');
  String view;
  String uName;
  String cate;
  String poB;
  String ci;
  String sta;
  String proN;
  String pri;
  String fiI;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: Container(
          child: Text("Property Details")
        ),
      )
    );
  }
}
