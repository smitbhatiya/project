import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';

class Favorite_Page extends StatefulWidget {
  @override
  _Favorite_PageState createState() => _Favorite_PageState();
}

class _Favorite_PageState extends State<Favorite_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: ListView(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Property_Detail())),
              child: Container(
                height: 300,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius
                                .circular(20), topRight: Radius.circular(20)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            child: Image.asset(
                                'images/property.jpg',
                                width: MediaQuery.of(context).size.width,
                                fit:BoxFit.fill
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 20, top: 20),
                          child: FavoriteButton(
                            isFavorite: true,
                            valueChanged: (_isFavorite) {
                              print('Is Favorite : $_isFavorite');
                            },
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(color: Colors.yellow,
                              height: 30,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width/2),
                        ),
                        Expanded(
                          child: Container(
                              color: Colors.red, height: 30, width: MediaQuery
                              .of(context)
                              .size
                              .width/2),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
