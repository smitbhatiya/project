import 'package:flutter/material.dart';

class review_page extends StatefulWidget {
  final String id1;

  const review_page({Key key, this.id1}) : super(key: key);

  @override
  _review_pageState createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  // ignore: non_constant_identifier_names
  TextEditingController review_controller = TextEditingController();

  // ignore: non_constant_identifier_names
  List<String> review_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.76,
                      child: TextField(
                        controller: review_controller,
                        decoration: InputDecoration(
                          hintText: "Review",
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          setState(() {
                            review_list.add(review_controller.text);
                          });
                        },
                      ),
                    ),
                  ],
                ),
            ),
            Container(
              child: Text('$review_list')
            )
          ],
        ),
      ),
    );
  }
}
