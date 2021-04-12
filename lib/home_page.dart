import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/call_images.dart';
import 'package:flutter_app_with_firebase/Pages/favorite_page.dart';
import 'package:flutter_app_with_firebase/Pages/my_home_page.dart';
import 'package:flutter_app_with_firebase/Pages/my_profile_page.dart';
import 'package:flutter_app_with_firebase/Pages/post_property_page.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/login_page.dart';

import 'login_page.dart';

class Home extends StatefulWidget {
  Home({Key key, this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = FirebaseAuth.instance.currentUser;
  int _selectedIndex = 0;
  String myEmail;

  String myPhone;

  String myName;

  String myRole;

  final List<Widget> _widgetOptions = <Widget>[
    My_Home(),
    Favorite_Page(),
    PostProperty(),
    Search_Page(),
    My_Profile_Page()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==0?Icons.home_filled:Icons.home_outlined, color: Colors.indigo),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==1?Icons.favorite_rounded:Icons.favorite_outline_rounded, color: Colors.indigo),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==2?Icons.add_box_rounded:Icons.add_box_outlined, color: Colors.indigo),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.indigo),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==4?Icons.account_circle:Icons.account_circle_outlined, color: Colors.indigo),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.image),
                  SizedBox(width: 25),
                  Text("Get Images")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Call_Images())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 25),
                  Text("My Profile")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => My_Profile_Page())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 25),
                  Text("Post property")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostProperty())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: 25),
                  Text("Favorites", style: TextStyle(fontSize: 16))
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Favorite_Page())),
            ),
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