import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  getSearchResult(String projectName, String price) {
    return Firestore.instance
        .collection('Property Details')
        .where('project name', isEqualTo: projectName)
        .where('price', isEqualTo: price)
        .getDocuments();
  }
}