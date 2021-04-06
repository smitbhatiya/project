import 'package:flutter/material.dart';

class Post_Property extends StatefulWidget {
  @override
  _Post_PropertyState createState() => _Post_PropertyState();
}

class _Post_PropertyState extends State<Post_Property> {
  int selectedIndex = 0;
  List<String> user_type = ['User', 'Builder', 'Brocker'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15, top: 10),
                alignment: Alignment.topLeft,
                  child: Text("Post Property", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customRadio(user_type[0], 0),
                  SizedBox(width: 15),
                  customRadio(user_type[1], 1),
                  SizedBox(width: 15),
                  customRadio(user_type[2], 2),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget customRadio(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey),),
    );
  }

}
