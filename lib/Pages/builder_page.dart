import 'package:flutter/material.dart';

class Builder_Page extends StatefulWidget {
  @override
  _Builder_PageState createState() => _Builder_PageState();
}

class _Builder_PageState extends State<Builder_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Builder", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}