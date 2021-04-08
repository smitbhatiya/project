import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/login_page.dart';

class Brocker_Page extends StatefulWidget {
  @override
  _Brocker_PageState createState() => _Brocker_PageState();
}

class _Brocker_PageState extends State<Brocker_Page> {

  String myEmail;
  String myPhone;
  String myName;
  String myRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                if(snapshot.connectionState != ConnectionState.done) {
                  return Text("Loading...");
                }
                return Column(
                  children: [
                    Center(child: Text("Hello, ${myName}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    SizedBox(height: 10),
                    Center(child: Text("${myEmail}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                );
              }
          ),
        ),
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

  Future<bool> signOut() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.signOut();
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
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
