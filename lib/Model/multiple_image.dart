// import 'package:flutter/material.dart';
// import 'dart:async';
//
// import 'package:multi_image_picker/multi_image_picker.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<Asset> images = <Asset>[];
//   String _error = 'No Error Dectected';
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   Widget buildGridView() {
//     return GridView.count(
//       crossAxisCount: 3,
//       children: List.generate(images.length, (index) {
//         Asset asset = images[index];
//         return AssetThumb(
//           asset: asset,
//           width: 300,
//           height: 300,
//         );
//       }),
//     );
//   }
//
//   Future<void> loadAssets() async {
//     List<Asset> resultList = <Asset>[];
//     String error = 'No Error Detected';
//
//     try {
//       resultList = await MultiImagePicker.pickImages(
//         maxImages: 4,
//         enableCamera: true,
//         selectedAssets: images,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//     } on Exception catch (e) {
//       error = e.toString();
//     }
//
//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;
//
//     setState(() {
//       images = resultList;
//       _error = error;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Column(
//           children: <Widget>[
//             Center(child: Text('Error: $_error')),
//             ElevatedButton(
//               child: Text("Pick images"),
//               onPressed: loadAssets,
//             ),
//             Expanded(
//               child: buildGridView(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:image_picker/image_picker.dart';

class Multiple_Image_Upload extends StatefulWidget {
  @override
  _Multiple_Image_UploadState createState() => _Multiple_Image_UploadState();
}

class _Multiple_Image_UploadState extends State<Multiple_Image_Upload> {
  File _image1;
  File _image2;
  File _image3;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _retrievedImageUrl;

  Future getImage1() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image1 = image;
      });
    } catch (e) {
      print(e);
    }
  }
  Future getImage2() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image2 = image;
      });
    } catch (e) {
      print(e);
    }
  }

  Future getImage3() async {
    try {
      File image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image3 = image;
      });
    } catch (e) {
      print(e);
    }
  }

  // Future uploadImage() async {
  //   try {
  //     final StorageReference storageReference = FirebaseStorage().ref().child("profilePicture");
  //
  //     final StorageUploadTask uploadTask = storageReference.putFile(_image);
  //
  //     final StreamSubscription<StorageTaskEvent> streamSubscription =
  //     uploadTask.events.listen((event) {
  //       // You can use this to notify yourself or your user in any kind of way.
  //       // For example: you could use the uploadTask.events stream in a StreamBuilder instead
  //       // to show your user what the current status is. In that case, you would not need to cancel any
  //       // subscription as StreamBuilder handles this automatically.
  //
  //       // Here, every StorageTaskEvent concerning the upload is printed to the logs.
  //       print('EVENT ${event.type}');
  //     });
  //
  //     // Cancel your subscription when done.
  //     await uploadTask.onComplete;
  //     streamSubscription.cancel();
  //
  //     String imageUrl = await storageReference.getDownloadURL();
  //     await _firestore.collection("Users").document().setData({
  //       "email": imageUrl,
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future retrieveImage() async {
  //   DocumentSnapshot documentSnapshot;
  //   try {
  //     documentSnapshot = await _firestore.collection("Users").document().get();
  //     setState(() {
  //       _retrievedImageUrl = documentSnapshot.data()['email'];
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future uploadMultipleImages() async {
    List<File> _imageList = List();
    List<String> _imageUrls = List();

    _imageList.add(_image1);
    _imageList.add(_image2);
    _imageList.add(_image3);

    try {
      for (int i = 0; i < _imageList.length; i++) {

        // if(_imageList[i] == null) {
        //
        // }
        final StorageReference storageReference = FirebaseStorage().ref().child("multiple2/$i");

        final StorageUploadTask uploadTask = storageReference.putFile(_imageList[i]);

        final StreamSubscription<StorageTaskEvent> streamSubscription =
        uploadTask.events.listen((event) {
          // You can use this to notify yourself or your user in any kind of way.
          // For example: you could use the uploadTask.events stream in a StreamBuilder instead
          // to show your user what the current status is. In that case, you would not need to cancel any
          // subscription as StreamBuilder handles this automatically.

          // Here, every StorageTaskEvent concerning the upload is printed to the logs.
          print('EVENT ${event.type}');
        });

        // Cancel your subscription when done.
        await uploadTask.onComplete;
        streamSubscription.cancel();

        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl); //all all the urls to the list
      }
      //upload the list of imageUrls to firebase as an array
      await _firestore.collection("users").document().setData({
        "arrayOfImages": _imageUrls,
      });
      //postProperty(category, postBy, sr_radio, pro_type, projectName, address, landmark, city, state, pro_detail, area, price, description, con_status, url_link)
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Storage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    child: ClipRRect(
                      child: _image1 != null
                          ? Image.file(_image1)
                          : FlatButton(
                        child: Icon(
                          Icons.add,
                          size: 50,
                        ),
                        onPressed: () {
                          getImage1();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: ClipRRect(
                      child: _image2 != null
                          ? Image.file(_image2)
                          : FlatButton(
                        child: Icon(
                          Icons.add,
                          size: 50,
                        ),
                        onPressed: () {
                          getImage2();
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    child: ClipRRect(
                      child: _image3 != null
                          ? Image.file(_image3)
                          : FlatButton(
                        child: Icon(
                          Icons.add,
                          size: 50,
                        ),
                        onPressed: () {
                          getImage3();
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
            RaisedButton(
              child: Text("Upload"),
              onPressed: () {
                //uploadImage();
              },
            ),
            RaisedButton(
              child: Text("Retrieve Image"),
              onPressed: () {
                //retrieveImage();
              },
            ),
            RaisedButton(
              child: Text("Upload List"),
              onPressed: () {
                uploadMultipleImages();
              },
            ),
          ],
        ),
      ),
    );
  }
}