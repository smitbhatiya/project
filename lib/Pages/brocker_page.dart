import 'package:flutter/material.dart';

class Brocker_Page extends StatefulWidget {
  @override
  _Brocker_PageState createState() => _Brocker_PageState();
}

class _Brocker_PageState extends State<Brocker_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Brocker", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
