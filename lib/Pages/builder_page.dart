import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/login_page.dart';

class Builder_Page extends StatefulWidget {
  @override
  _Builder_PageState createState() => _Builder_PageState();
}

class _Builder_PageState extends State<Builder_Page> {

  String myEmail;
  String myPhone;
  String myName;
  String myRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
                child: FutureBuilder(
                    future: _fetch(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState != ConnectionState.done) {
                        return Text("Loading...");
                      }
                      return Column(
                        children: [
                          Center(child: Text("Hello, $myName", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                          SizedBox(height: 10),
                          Center(child: Text("$myRole", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                        ],
                      );
                    }
                ),
              ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
                title: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 25),
                    Text("Sign Out", style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () =>
                    signOut().whenComplete(() =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LogIn_Page()), (
                            Route<dynamic> route) => false))
            )
          ],
        ),
      ),
    );
  }
  // ignore: missing_return
  Future<bool> signOut() async {
    FirebaseUser user = FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.signOut();
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users12')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()['Email'];
        myName = ds.data()['Name'];
        myPhone = ds.data()['Mobile Number'];
        myRole = ds.data()['Role'];
      }).catchError((e) {
        print(e);
      });
    }
  }

}