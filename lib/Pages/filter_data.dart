import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Filter_Data extends StatelessWidget {
//   final CollectionReference cityCollection = Firestore.instance.collection('Property Details');
//   final Query city = FirebaseFirestore.instance.collection('Property Details').where("city", isEqualTo: "Surat");
//   final CollectionReference noticeCollection=Firestore.instance.collection('Property Details');
// //notice list from snapshot
//   List<Notice>_noticeListFromSnapshot(QuerySnapshot snapshot){
//     return snapshot.documents.map((doc){
//       return Notice(
//           title:doc.data['title'] ?? '',
//           url: doc.data['url'] ?? '',
//           category: doc.data['noticecategory'] ?? 'General',
//           status: doc.data['status'] ?? 'unapproved',
//           dateTime: doc.data['dateTime'] ?? '',
//           noticeId: doc.data['noticeId'] ?? ''
//
//       );
//     }).toList();
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('city')),
    );
  }
}
