import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class review_page extends StatefulWidget {
  final String id1;

  const review_page({Key key, this.id1}) : super(key: key);
  @override
  _review_pageState createState() => _review_pageState();
}

class _review_pageState extends State<review_page> {
  bool isAnimate = false;

  final CollectionReference reviewList =
  FirebaseFirestore.instance
      .collection('Property Details');

  List postReviewList = [];
  String doc_id;
  String doc_id1;
  TextEditingController _textController = TextEditingController();
  Stream<QuerySnapshot> reviews;

  getReview() async {
    return reviewList.doc(widget.id1).collection('reviewBox').snapshots();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    getReview().then((val) {
      setState(() {
        reviews = val;
      });
    });
    refreshPage();
  }
  Future<Null> refreshPage() async{
    refreshKey.currentState?.show();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      return ;
    });
  }
  final username = FirebaseAuth.instance.currentUser;

  Widget _textComposerWidget() {
    return new IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
                controller: _textController,
                //onSubmitted: _handleSubmitted,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  Firestore.instance.collection('Property Details').doc(widget.id1).collection('reviewBox').doc().set({
                        "userId": '${FirebaseAuth.instance.currentUser.uid}',
                        "review": '${_textController.text}',
                        "name": '${FirebaseAuth.instance.currentUser.displayName}',
                        "firstChar": '${FirebaseAuth.instance.currentUser.displayName[0]}',
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  final _n1 = Firestore.instance.collection('Property Details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Reviews'),
          backgroundColor: Colors.indigo,
        ),
        // ignore: unrelated_type_equality_checks
        body: StreamBuilder<QuerySnapshot> (
          stream: reviews,
          builder: (context, snapshot) {
            return ListView(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                  ),
                  child: _textComposerWidget(),
                ),
                Divider(height: 1.0),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                  //DocumentSnapshot data = snapshot.data.docs[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          margin: const EdgeInsets.only(right: 16.0),
                          child: new CircleAvatar(
                            child: new Text(snapshot.data.documents[index].data()['firstChar']),
                          ),
                        ),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(snapshot.data.documents[index].data()['name'],
                                style: Theme.of(context).textTheme.subhead),
                            new Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: new Text(snapshot.data.documents[index].data()['review']),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
              ],
            );
          },
        )
    );
  }
}