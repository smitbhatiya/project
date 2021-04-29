// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_app_with_firebase/Model/review_manager.dart';
//
// class review_page extends StatefulWidget {
//   final String id1;
//
//   const review_page({Key key, this.id1}) : super(key: key);
//
//   @override
//   _review_pageState createState() => _review_pageState();
// }
//
// class _review_pageState extends State<review_page> {
//   final TextEditingController _textController = new TextEditingController();
//   final List<ReviewMessage> _messages = <ReviewMessage>[];
//
//   void _handleSubmitted(String text) {
//     //_textController.clear();
//     ReviewMessage message = new ReviewMessage(
//       text: text,
//     );
//     setState(() {
//       _messages.insert(0, message);
//     });
//   }
//
//   //List postReviewList = [];
//
//   // final CollectionReference reviewList = Firestore.instance.collection('Property Details');
//   // Future getReviewList() async {
//   //   List itemsList = [];
//   //   try {
//   //     await reviewList.doc(widget.id1).collection('reviewBox').getDocuments().then((querySnapshot) {
//   //       querySnapshot.documents.forEach((element) {
//   //         // if(element.data()['postById'] == FirebaseAuth.instance.currentUser.uid) {
//   //         //   itemsList.add(element.data());
//   //         // }
//   //         itemsList.add(element.data());
//   //       });
//   //     });
//   //     return itemsList;
//   //   } catch (e) {
//   //     print(e.toString());
//   //     return null;
//   //   }
//   // }
//
//   // fetchReviewList() async {
//   //   dynamic resultant = await ReviewManager().getReviewList();
//   //
//   //   if (resultant == null) {
//   //     print('Unable to retrieve');
//   //   } else {
//   //     setState(() {
//   //       postReviewList = resultant;
//   //     });
//   //   }
//   // }
//
//   Widget _textComposerWidget() {
//     return new IconTheme(
//       data: new IconThemeData(color: Colors.blue),
//       child: new Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: new Row(
//           children: <Widget>[
//             new Flexible(
//               child: new TextField(
//                 decoration:
//                 new InputDecoration.collapsed(hintText: "Send a message"),
//                 controller: _textController,
//                 onSubmitted: _handleSubmitted,
//               ),
//             ),
//             new Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4.0),
//               child: new IconButton(
//                 icon: new Icon(Icons.send),
//                 onPressed: () {
//                   _handleSubmitted(_textController.text);
//                   // Firestore.instance.collection('Property Details').doc(widget.id1).set({
//                   //   'review': FieldValue.arrayUnion([{'${FirebaseAuth.instance.currentUser.uid}':'${_textController.text}'}]),
//                   // },SetOptions(merge: true)).then((value) =>
//                   // {});
//                   //print(widget.id1);
//                   Firestore.instance.collection('Property Details').doc(widget.id1).collection('reviewBox').doc().set({
//                         "userId": '${FirebaseAuth.instance.currentUser.uid}',
//                         "review": '${_textController.text}'
//                       });
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           new Flexible(
//             child: new ListView.builder(
//               padding: new EdgeInsets.all(8.0),
//               reverse: true,
//               itemBuilder: (_, int index) => _messages[index],
//               itemCount: _messages.length,
//             ),
//           ),
//           new Divider(
//             height: 1.0,
//           ),
//           new Container(
//             decoration: new BoxDecoration(
//               color: Theme.of(context).cardColor,
//             ),
//             child: _textComposerWidget(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// final _name = FirebaseAuth.instance.currentUser.displayName;
//
// class ReviewMessage extends StatelessWidget {
//   final String text;
//   ReviewMessage({this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//       margin: const EdgeInsets.symmetric(vertical: 10.0),
//       child: new Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           new Container(
//             margin: const EdgeInsets.only(right: 16.0),
//             child: new CircleAvatar(
//               child: new Text(_name[0]),
//             ),
//           ),
//           new Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               new Text(_name, style: Theme.of(context).textTheme.subhead),
//               new Container(
//                 margin: const EdgeInsets.only(top: 5.0),
//                 child: new Text(text),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Model/database_manager.dart';
import 'package:flutter_app_with_firebase/Model/favorite_post_manager.dart';
import 'package:flutter_app_with_firebase/Model/review_manager.dart';
import 'package:flutter_app_with_firebase/Model/userpost_manager.dart';
import 'package:flutter_app_with_firebase/Pages/property_detail.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:shared_preferences/shared_preferences.dart';

class review_page extends StatefulWidget {
  final String id1;

  const review_page({Key key, this.id1}) : super(key: key);
  @override
  _review_pageState createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  bool isAnimate = false;

  //final _auth= FirebaseAuth.instance.currentUser;
  List postReviewList = [];
  String doc_id;
  String doc_id1;
  //bool f1;
  //String id;
  //var abc;

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    refreshPage();
  }
  Future<Null> refreshPage() async{
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return ;
    });
  }
  fetchDatabaseList() async {
    dynamic resultant = await ReviewManager().getReviewList();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        postReviewList = resultant;
      });
    }
  }

  CollectionReference _n1 = Firestore.instance.collection('Property Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Reviews'),
          backgroundColor: Colors.indigo,
        ),
        // ignore: unrelated_type_equality_checks
        body: postReviewList == 0 ? Container() : StreamBuilder<QuerySnapshot> (
          stream: FirebaseFirestore.instance.collection('Property Details').doc(widget.id1).collection('reviewBox').snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: postReviewList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot data = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: new CircleAvatar(
                            child: new Text('A'),
                          ),
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text('Abc',
                                style: Theme.of(context).textTheme.subhead),
                            new Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: new Text(postReviewList[index]['review']),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                });
          },
        )
    );
  }
}