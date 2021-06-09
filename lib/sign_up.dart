import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_with_firebase/login_page.dart';

import 'firebase.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<User> users = List();
  User user;
  List<String> lst1 = ['User', 'Builder', 'Broker'];
  int selectedIndex = 0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  TextEditingController email_cont = TextEditingController();
  TextEditingController pass_cont = TextEditingController();
  TextEditingController name_cont = TextEditingController();
  TextEditingController phone_cont = TextEditingController();
  String em;
  List myData1 = [];
  String ok;

  void validate() async {
    await FirebaseFirestore.instance.collection('Users12').getDocuments().then((querySnapshot){
      querySnapshot.documents.forEach((element) {
        myData1.add(element.data()['Email']);
      });
    });
    for(int i=0; i<myData1.length; i++) {
      if(myData1[i] == em) {
        // setState(() {
        //   ok = true;
        // });
        // showSnackBar("User already exist");
        setState(() {
          ok = myData1[i];
        });
      }
    }
    print(myData1);
    print(ok);
    //print(myData);
    myData1.removeRange(0, myData1.length);
    print(myData1);
  }

  void validate1() async {
    if(ok==em) {
      showSnackBar("User already exist");
    }
    else {
      signUp(context);
    }
  }

  void showSnackBar(String value) {
    _scaffoldKey
        .currentState
        .showSnackBar(
        SnackBar(
            content: Text(value)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue.shade50,
      body: ListView(
        children: [
          Form(
              key: _formKey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Register", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.indigo)),
                    SizedBox(height: 55),
                    Text("Register as", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customRadio(lst1[0], 0),
                        SizedBox(width: 15),
                        customRadio(lst1[1], 1),
                        SizedBox(width: 15),
                        customRadio(lst1[2], 2),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.078,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: name_cont,
                            decoration: InputDecoration(
                                hintText: "Name",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.account_circle_outlined)),
                            keyboardType: TextInputType.text,
                            onSaved: (input) => name_cont,
                            validator: (val) => val != ""
                                ? em == ok ? "user already exist" : null
                                : "please enter name",
                          ),
                        )
                    ),
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: phone_cont,
                            decoration: InputDecoration(
                                hintText: "Mobile Number",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.phone)),
                            keyboardType: TextInputType.text,
                            onSaved: (input) => phone_cont,
                            validator: (val) => val != ""
                                ? em == ok ? "user already exist" : null
                                : "please enter mobile number",
                          ),
                        )
                    ),
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: email_cont,
                            onChanged: (value) {
                              setState(() {
                                em = value;
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.email_outlined)),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => email_cont,
                            validator: (val) => val == ok
                                ? "user already exist"
                                // ignore: unrelated_type_equality_checks
                                : val == "" ? "please enter email" : null,
                          ),
                        )
                    ),
                    SizedBox(height: 15),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: pass_cont,
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.lock)),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            onSaved: (input) => pass_cont,
                            validator: (val) => val != ""
                                ? em == ok ? "user already exist" : null
                                : "please enter password",
                          ),
                        ),
                    ),
                    SizedBox(height: 33),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: RaisedButton(
                        onPressed: () {
                          validate();
                          signUp(context);
                          // ignore: unrelated_type_equality_checks
                          // if(em == ok) {
                          //   showSnackBar("User already exist");
                          // }
                          // else {
                          //   signUp(context);
                          // }
                          // if(ok == false) {
                          //   signUp(context);
                          // }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        color: Colors.blue,
                        child: Text("Register", style: TextStyle(fontSize: 22, color: Colors.white)),
                      ),
                    ),
                    // Container(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Navigator.pushReplacement(
                    //           context, MaterialPageRoute(builder: (context) => LogIn_Page()));
                    //     },
                    //     child: Text("Login", style: TextStyle(fontSize: 16, color: Colors.indigo)),
                    //   ),
                    // )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void signUp(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn_Page()));
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email_cont.text, password: pass_cont.text);
        User updateUser = FirebaseAuth.instance.currentUser;
        updateUser.updateProfile(displayName: name_cont.text);
        // updateUser.updateProfile(: email_cont);
        userSetup(name_cont.text, email_cont.text, phone_cont.text, pass_cont.text, lst1[selectedIndex]);
      } catch (e) {
        //print(e.message);
        // if(e is PlatformException) {
        //   if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        //     //showSnackBar("User already exist");
        //   }
        // }
        print(e.message);
        if(e.message == 'The email address is already in use by another account.') {
          print("User already exist");
        }
        else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LogIn_Page()));
        }
      }
    }
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
