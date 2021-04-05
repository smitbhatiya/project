import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Pages/brocker_page.dart';
import 'package:flutter_app_with_firebase/Pages/builder_page.dart';
import 'package:flutter_app_with_firebase/sign_up.dart';

import 'home_page.dart';

class LogIn_Page extends StatefulWidget {
  @override
  _LogIn_PageState createState() => _LogIn_PageState();
}

class _LogIn_PageState extends State<LogIn_Page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController e1_cont = TextEditingController();
  TextEditingController p1_cont = TextEditingController();
  String _email, _password;
  String myRole;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Login",style: TextStyle(fontSize: 40.0,fontWeight: FontWeight.bold,color: Colors.indigo),),
                    SizedBox(height: 100.0,),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.email_outlined)
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value)
                            {
                              if(value.isEmpty || !value.contains('@'))
                              {
                                return 'invalid email';
                              }
                              return null;
                            },
                            onSaved: (value) => _email = value,
                          ),
                        )
                    ),

                    SizedBox(height: 15.0,),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.068,
                        padding: EdgeInsets.only(left: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(fontSize: 18),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                prefixIcon: Icon(Icons.lock_outlined)
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            validator: (value)
                            {
                              if(value.isEmpty || value.length<=5)
                              {
                                return 'invalid password';
                              }
                              return null;
                            },
                            onSaved: (value) => _password = value,
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Row(
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(width: 20.0,),
                        Spacer(),
                        GestureDetector(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.blue, fontWeight: FontWeight.bold),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0,),
                    Container(
                      height:MediaQuery.of(context).size.height*0.07,
                      width: MediaQuery.of(context).size.width*0.6  ,
                      child: RaisedButton(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35.0)
                        ),
                        child: Text("Login",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),),
                        onPressed:(){
                          signIn();
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>drawer()));
                        },
                      ),
                    ),
                    SizedBox(height:20.0,),
                    GestureDetector(
                      child: Text("Don't have acoount? Sign up here",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 15.0),),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  void signIn() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        UserCredential user =await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print(user.additionalUserInfo);
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }catch(e){
        print(e.message);
      }
    }
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users12')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myRole = ds.data()['Role'];
        print(myRole);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
