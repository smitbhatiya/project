import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/Notification/FirebaseMessaging.dart';
import 'package:flutter_app_with_firebase/Pages/favorites_list_page.dart';
import 'package:flutter_app_with_firebase/Pages/filter_data.dart';
import 'package:flutter_app_with_firebase/Pages/my_home_page.dart';
import 'package:flutter_app_with_firebase/Pages/my_post.dart';
import 'package:flutter_app_with_firebase/Pages/my_profile_page.dart';
import 'package:flutter_app_with_firebase/Pages/post_property_page.dart';
import 'package:flutter_app_with_firebase/Pages/search_page.dart';
import 'package:flutter_app_with_firebase/Search_Function/search_list.dart';
import 'package:flutter_app_with_firebase/login_page.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Pages/sold_property.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  bool auth;
  int view1;

  Home({Key key, this.user, this.auth, this.view1}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomeState createState() => _HomeState(auth);
}

class _HomeState extends State<Home> {
  bool auth;
  _HomeState(this.auth);


  static Future openEmail({
    @required String toEmail,
    @required String subject,
    @required String body,
  }) async {
    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(body)}';

    await _launchUrl(url);
  }

  static Future openPhoneCall({@required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';

    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  int _selectedIndex = 0;
  String myEmail;

  String myPhone;

  String myName;

  String myRole;

  final List<Widget> _widgetOptions = <Widget>[
    myHomepage(),
    MyPost(),
    PostProperty(),
    Search_Page(),
    My_Profile_Page()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 0,
    minLaunches: 2,
    remindDays: 0,
    remindLaunches: 3,
    // appStoreIdentifier: '',
    // googlePlayIdentifier: '',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rateMyApp.init().then((_) {
      if (rateMyApp.shouldOpenDialog) {
        rateMyApp.showRateDialog(
          context,
          title: 'Rate this app', // The dialog title.
          message: 'Help us to improve our app.', // The dialog message.
          rateButton: 'RATE', // The dialog "rate" button text.
          noButton: 'NO THANKS', // The dialog "no" button text.
          laterButton: 'MAYBE LATER', // The dialog "later" button text.
          listener: (button) { // The button click listener (useful if you want to cancel the click event).
            switch(button) {
              case RateMyAppDialogButton.rate:
                print('Clicked on "Rate".');
                break;
              case RateMyAppDialogButton.later:
                print('Clicked on "Later".');
                break;
              case RateMyAppDialogButton.no:
                print('Clicked on "No".');
                break;
            }

            return true; // Return false if you want to cancel the click event.
          },
          dialogStyle: const DialogStyle(), // Custom dialog styles.
          onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          // actionsBuilder: (context) => [], // This one allows you to use your own buttons.
        );
        // Or if you prefer to show a star rating bar (powered by `flutter_rating_bar`) :

        // rateMyApp.showStarRateDialog(
        //   context,
        //   title: 'Rate this app', // The dialog title.
        //   message: 'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
        //   // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
        //   actionsBuilder: (context, stars) { // Triggered when the user updates the star rating.
        //     return [ // Return a list of actions (that will be shown at the bottom of the dialog).
        //       FlatButton(
        //         child: Text('OK'),
        //         onPressed: () async {
        //           print('Thanks for the ' + (stars == null ? '0' : stars.round().toString()) + ' star(s) !');
        //           // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
        //           // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
        //           await rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
        //           Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
        //         },
        //       ),
        //     ];
        //   },
        // //Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
        // dialogStyle: const DialogStyle( // Custom dialog styles.
        //   titleAlign: TextAlign.center,
        //   messageAlign: TextAlign.center,
        //   messagePadding: EdgeInsets.only(bottom: 20),
        // ),
        // starRatingOptions: const StarRatingOptions(), // Custom star bar rating options.
        // onDismissed: () => rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
        // );
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        actions: [
          IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FirebaseMessagingDemo()));
              }
          )
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==0?Icons.home_filled:Icons.home_outlined, color: Colors.indigo),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==1?Icons.photo_library:Icons.photo_library_outlined, color: Colors.indigo),
            label: 'My post',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==2?Icons.add_box_rounded:Icons.add_box_outlined, color: Colors.indigo),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.indigo),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex==4?Icons.account_circle:Icons.account_circle_outlined, color: Colors.indigo),
            label: 'My Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.contact_support),
                  SizedBox(width: 25),
                  Text("Complaint via email")
                ],
              ),
              onTap: () {
                openEmail(toEmail: 'smitbhatiya05999@gmail.com', subject: '', body: '');
              }
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.call),
                  SizedBox(width: 25),
                  Text("Contact us"),
                ],
              ),
              onTap: () {
                openPhoneCall(phoneNumber: '(+91)9106612550');
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.filter),
                  SizedBox(width: 25),
                  Text("Filteration")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Filteration_Page())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.filter_alt),
                  SizedBox(width: 25),
                  Text("Filtered data")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Filter_Data())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.post_add),
                  SizedBox(width: 25),
                  Text("Users Post")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyPost())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.account_circle),
                  SizedBox(width: 25),
                  Text("My Profile")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => My_Profile_Page())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 25),
                  Text("Post property")
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostProperty())),
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.open_in_browser_outlined),
                  SizedBox(width: 25),
                  Text("Any RoR")
                ],
              ),
              onTap: () {
                openUrl();
              },
            ),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.favorite_outline),
                  SizedBox(width: 25),
                  Text("Favorites", style: TextStyle(fontSize: 16))
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyFavoritePost())),
            ),
            ListTile(
                title: Row(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 25),
                    Text("Sign Out", style: TextStyle(fontSize: 20)),
                  ],
                ),
                onTap: () =>
                    signOut().whenComplete(() =>
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LogIn_Page()), (
                            Route<dynamic> route) => false))
            ),
            ListTile(
              title: Row(
                children: [
                  Text("Sold property", style: TextStyle(fontSize: 20))
                ],
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Sold_Property())),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> signOut() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser;
    await FirebaseAuth.instance.signOut();
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if(firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('Users12')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
         myEmail = ds.data()['Email'];
         myName = ds.data()['Name'];
         myPhone = ds.data()['Mobile Number'];
         myRole = ds.data()['Role'];
      }).catchError((e) {
        print(e);
      });
    }
  }

  openUrl() {
    String url = "https://anyror.gujarat.gov.in/";
    _launchUrl(url);
  }

}