import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class Property_Detail extends StatefulWidget {
  @override
  _Property_DetailState createState() => _Property_DetailState();
}

class _Property_DetailState extends State<Property_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey.shade50,
      body: Container(
        child: ListView(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 300,
                      color: Colors.grey.shade100,
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade200,
                      child: Row(
                        children: [],
                      ),
                    ),
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.grey.shade300,
                      child: Row(
                        children: [],
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 20, top: 20),
                  child: FavoriteButton(
                    isFavorite: false,
                    valueChanged: (_isFavorite) {
                      print('Is Favorite : $_isFavorite');
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
