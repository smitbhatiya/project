import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_mailer/flutter_mailer.dart';
import 'dart:async';

class Complaint_Box_Page extends StatefulWidget {
  @override
  _Complaint_Box_PageState createState() => _Complaint_Box_PageState();
}

class _Complaint_Box_PageState extends State<Complaint_Box_Page> {

  // ignore: non_constant_identifier_names
  final TextEditingController complainController = TextEditingController();
  Future<void> send() async {
    final Email email = Email(
      body: complainController.text,
      subject: 'Fake User',
      recipients: ['smitbhatiya05999@gmail.com'],
      // attachmentPaths: attachments,
      // isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
    SnackBar(
      content: Text(platformResponse),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(style: BorderStyle.solid, color: Colors.grey)
                ),
                child: TextField(
                  controller: complainController,
                  minLines: 1,
                  maxLines: 20,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                   // border: OutlineInputBorder(),
                    hintText: 'Write your complaint',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18
                    ),
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none
                  ),
                ),
              ),
              SizedBox(height: 15),
              RaisedButton(
                onPressed: send,
                child: Text("Send"),
              )
            ],
          )
        ),
      ),
    );
  }
}
