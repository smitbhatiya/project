import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  final String u2;
  final String id;
  const Messages({Key key, this.u2, this.id}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController msgController = TextEditingController();
  Stream<QuerySnapshot> chats;

  getChats() async{
    return FirebaseFirestore.instance
        .collection('Property Details')
        .doc('${widget.id}')
        .collection('chatRoom')
        .doc(getChatRoomId(FirebaseAuth.instance.currentUser.uid, widget.u2))
        .collection('chat')
        .orderBy('time')
        .snapshots();
  }

  @override
  void initState() {
    // TODO: implement initState
    getChats().then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  final Query query = FirebaseFirestore.instance
      .collection('chatRoom')
  .doc('${FirebaseAuth.instance.currentUser.uid}')
  .collection('chat')
  .where('sendBy', isEqualTo: "${FirebaseAuth.instance.currentUser.uid}");

  Widget chatMessages(){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              return MessageTile(
                message: snapshot.data.documents[index].data()["message"],
                sendByMe: snapshot.data.documents[index].data()["sendBy"] == FirebaseAuth.instance.currentUser.uid,
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
                Container(
                  padding: EdgeInsets.only(bottom: 70),
                  child: chatMessages()
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.86,
                        padding: EdgeInsets.only(left: 20),
                        margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white
                        ),
                        child: TextField(
                          controller: msgController,
                          decoration: InputDecoration(
                            hintText: "Type message..",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance.collection('Property Details')
                              .doc('${widget.id}')
                              .collection('chatRoom')
                              .doc(getChatRoomId(FirebaseAuth.instance.currentUser.uid, widget.u2))
                              .collection('chat')
                              .doc()
                              .set({
                            "message" : "${msgController.text}",
                            "sendBy" : "${FirebaseAuth.instance.currentUser.uid}",
                            "time" : DateTime.now().microsecondsSinceEpoch
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                            child: Icon(Icons.send, color: Colors.blue)
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
          margin: sendByMe
              ? EdgeInsets.only(left: 30)
              : EdgeInsets.only(right: 30),
          padding: EdgeInsets.only(
              top: 17, bottom: 17, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
                colors: sendByMe ? [
                const Color(0xff007EF4),
                const Color(0xff2A75BC)
                ]
                : [
                const Color(0xff324F17),
            const Color(0xff7F8778)
            ],
          )
      ),
      child: Text(message,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              //fontFamily: 'OverpassRegular',
              fontWeight: FontWeight.w300)),
    ),
    );
  }
}
