import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/home_page.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp1());
}


class MyApp1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RestorationScope(
      restorationId: "root",
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // String title = "Title";
  //
  // String helper = "helper";
  //
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //
  //   _firebaseMessaging.configure(
  //     onMessage: (message) async{
  //       setState(() {
  //         title = message["notification"]["title"];
  //         helper = "You have recieved a new notification";
  //       });
  //
  //     },
  //     onResume: (message) async{
  //       setState(() {
  //         title = message["data"]["title"];
  //         helper = "You have open the application from notification";
  //       });
  //
  //     },
  //
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogIn_Page(),
    );
  }
}