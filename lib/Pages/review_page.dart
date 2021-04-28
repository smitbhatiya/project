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
  final TextEditingController _textController = new TextEditingController();
  final List<ReviewMessage> _messages = <ReviewMessage>[];

  void _handleSubmitted(String text) {
    //_textController.clear();
    ReviewMessage message = new ReviewMessage(
      text: text,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

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
                onSubmitted: _handleSubmitted,
              ),
            ),
            new Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                icon: new Icon(Icons.send),
                onPressed: () {
                  _handleSubmitted(_textController.text);
                  Firestore.instance.collection('Property Details').doc(widget.id1).set({
                    'review': FieldValue.arrayUnion([{'${FirebaseAuth.instance.currentUser.uid}':'${_textController.text}'}]),
                  },SetOptions(merge: true)).then((value) =>
                  {});
                  //print(widget.id1);
                  Firestore.instance.collection('Property Details').doc(widget.id1).collection('reviewBox').doc().set({
                        "userId": '${FirebaseAuth.instance.currentUser.uid}',
                        "review": '${_textController.text}'
                      });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              padding: new EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          new Divider(
            height: 1.0,
          ),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _textComposerWidget(),
          ),
        ],
      ),
    );
  }
}

final _name = FirebaseAuth.instance.currentUser.displayName;

class ReviewMessage extends StatelessWidget {
  final String text;
  ReviewMessage({this.text});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: new CircleAvatar(
              child: new Text(_name[0]),
            ),
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text(_name, style: Theme.of(context).textTheme.subhead),
              new Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Text(text),
              )
            ],
          )
        ],
      ),
    );
  }
}