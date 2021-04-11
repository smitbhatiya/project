import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class My_Profile_Page extends StatefulWidget {
  @override
  _My_Profile_PageState createState() => _My_Profile_PageState();
}

class _My_Profile_PageState extends State<My_Profile_Page> {

  String myName;
  String myEmail;
  String myPhone;
  String myRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/profile_image.png'),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState != ConnectionState.done) {
                          return Text("Loading...");
                        }
                        return Column(
                          children: [
                            Center(child: Text("$myName", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo))),
                            SizedBox(height: 7),
                            Center(child: Text("$myEmail", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo)))
                          ],
                        );
                      }
                  ),
                )
              ],
            ),
            SizedBox(height: 25),
            Divider(),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Mobile Number", style: TextStyle(fontSize: 22))
                ),
                Spacer(),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 10),
                  child: FutureBuilder(
                      future: _fetch(),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState != ConnectionState.done) {
                          return Text("Loading...");
                        }
                        return Center(child: Text("$myPhone", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)));
                      }
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Change Password", style: TextStyle(fontSize: 22))
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text("Click here", style: TextStyle(fontSize: 16, color: Colors.blue)),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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
