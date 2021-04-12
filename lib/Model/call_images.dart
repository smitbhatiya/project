import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Call_Images extends StatefulWidget {
  @override
  _Call_ImagesState createState() => _Call_ImagesState();
}

class _Call_ImagesState extends State<Call_Images> {
  Future<QuerySnapshot> getImages() {
    return FirebaseFirestore.instance.collection("propertyImages").get();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: getImages(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(snapshot.data.docs[index].data()["projectName"]),
                      leading: Image.network(
                          snapshot.data.docs[index].data()["url"],
                          fit: BoxFit.fill),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}