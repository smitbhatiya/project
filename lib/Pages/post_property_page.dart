import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_with_firebase/firebase.dart';
import 'package:flutter_app_with_firebase/home_page.dart';
import 'package:image_picker/image_picker.dart';

class ResidentialFilterEntry1 {
  const ResidentialFilterEntry1(this.name1);
  final String name1;
}

class CommercialFilterEntry1 {
  const CommercialFilterEntry1(this.cname1);
  final String cname1;
}

class PostProperty extends StatefulWidget {
  @override
  _PostPropertyState createState() => _PostPropertyState();
}

class _PostPropertyState extends State<PostProperty> {

  final List<ResidentialFilterEntry1> residential1_cast = <ResidentialFilterEntry1>[
    const ResidentialFilterEntry1('Apartment'),
    const ResidentialFilterEntry1('Villa/House'),
    const ResidentialFilterEntry1('Row House'),
    const ResidentialFilterEntry1('Farm House'),
    const ResidentialFilterEntry1('Plot'),
    const ResidentialFilterEntry1('Pent House'),
    const ResidentialFilterEntry1('Others'),
  ];
  List<String> _filters1 = <String>[];

  Iterable<Widget> get residentialWidgets sync* {
    for (final ResidentialFilterEntry1 residential in residential1_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(residential.name1),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: _filters1.contains(residential.name1),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  _filters1.add(residential.name1);
                } else {
                  _filters1.removeWhere((String name) {
                    return name == residential.name1;
                  });
                }
                print('${_filters1.join(',  ')}');
              });
            },
          ),
        ),
      );
    }
  }

  final List<CommercialFilterEntry1> commercial1_cast = <CommercialFilterEntry1>[
    const CommercialFilterEntry1('Office Space'),
    const CommercialFilterEntry1('Shop'),
    const CommercialFilterEntry1('Ware House'),
    const CommercialFilterEntry1('Commercial Land'),
    const CommercialFilterEntry1('Hotel'),
    const CommercialFilterEntry1('Showroom'),
    const CommercialFilterEntry1('Others'),
  ];
  // ignore: non_constant_identifier_names
  List<String> commercial1_filters = <String>[];

  Iterable<Widget> get commercialWidgets sync* {
    for (final CommercialFilterEntry1 commercial1 in commercial1_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(commercial1.cname1),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: commercial1_filters.contains(commercial1.cname1),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  commercial1_filters.add(commercial1.cname1);
                } else {
                  commercial1_filters.removeWhere((String name) {
                    return name == commercial1.cname1;
                  });
                }
                print('${commercial1_filters.join(',  ')}');
              });
            },
          ),
        ),
      );
    }
  }

  File _imageFile;
  File _imageFile1;
  final picker = ImagePicker();

  _openCamera() async {
    // var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    // this.setState(() {
    //   imageFile = picture;
    // });
    // Navigator.of(context).pop();
  }

  _openGallery() async {
    // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    // this.setState(() {
    //   imageFile = picture;
    // });
    // Navigator.pop(context);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile.path);
    });
    uploadImageToFirebase(context);
    Navigator.of(context).pop();
  }

  _openGallery1() async {
    // var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    // this.setState(() {
    //   imageFile = picture;
    // });
    // Navigator.pop(context);
    final pickedFile1 = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile1 = File(pickedFile1.path);
    });
    uploadImageToFirebase1(context);
    Navigator.of(context).pop();
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = _imageFile.path;
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('property_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }

  Future uploadImageToFirebase1(BuildContext context) async {
    String fileName = _imageFile1.path;
    StorageReference firebaseStorageRef =
    FirebaseStorage.instance.ref().child('property_images/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile1);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );
  }

  Future<void> _optionsDialogBox1(BuildContext context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () {
                      _openCamera();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: () {
                      _openGallery1();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _optionsDialogBox(BuildContext context) {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Make a Choice"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: () {
                      _openCamera();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<String> sell_and_rent=["Sell","Rent"];
  List<String> sell_and_rent_1c=["Sell","Rent"];
  List<String> owner_builder_broker=["Owner","Builder","Broker"];
  List<String> bhk=["1BHK","2BHK","3BHK","4BHK"];
  List<String> construction_status=["Completed","Under Construction"];
  List<String> construction_status_4c=["Completed","Under Construction"];
  int selectedIndex=0;
  int selectedIndex1=0;
  int selectedIndex1c=0;
  int selectedIndex2=0;
  int selectedIndex3=0;
  int selectedIndex4c=0;
  TextEditingController project_name_controller_r = TextEditingController();
  TextEditingController address_controller_r = TextEditingController();
  TextEditingController landmark_controller_r = TextEditingController();
  TextEditingController state_controller_r = TextEditingController();
  TextEditingController city_controller_r = TextEditingController();
  TextEditingController area_controller_r = TextEditingController();
  TextEditingController price_controller_r = TextEditingController();
  TextEditingController project_description_controller_r = TextEditingController();
  TextEditingController project_name_controller_c = TextEditingController();
  TextEditingController address_controller_c = TextEditingController();
  TextEditingController landmark_controller_c = TextEditingController();
  TextEditingController state_controller_c = TextEditingController();
  TextEditingController city_controller_c = TextEditingController();
  TextEditingController area_controller_c = TextEditingController();
  TextEditingController price_controller_c = TextEditingController();
  TextEditingController project_description_controller_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(height: 10.0,),
                Text("Post As",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.bold),),
                SizedBox(height: 10.0,),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      customRadio_2(owner_builder_broker[0], 0),
                      SizedBox(width: 20),
                      customRadio_2(owner_builder_broker[1], 1),
                      SizedBox(width: 20),
                      customRadio_2(owner_builder_broker[2], 2),
                    ],
                  ),
                ), //Row of radiobutton
                Divider(),
                SizedBox(
                  height: 50 ,
                  child: AppBar(
                    backgroundColor: Colors.grey.shade50,
                    elevation: 0,
                    bottom: TabBar(
                      tabs: [
                        Tab(
                          icon: Text("Residential",style: TextStyle(fontSize: 18,color: Colors.indigo,fontWeight: FontWeight.bold),),
                        ),
                        Tab(
                          icon: Text("Commercial",style: TextStyle(fontSize: 18,color: Colors.indigo,fontWeight: FontWeight.bold),),
                        )
                      ],
                    ),
                  ),
                ), //nav bar
                Expanded(
                  flex:1,
                  child: TabBarView(
                    children: [
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 7,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          customRadio_1(sell_and_rent[0], 0),
                                          SizedBox(width: 20),
                                          customRadio_1(sell_and_rent[1], 1),
                                        ],
                                      ),
                                    ), //Radio button sell and rent
                                    SizedBox(height: 10.0,),
                                    Divider(),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left:20),
                                      child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                    ), //Property type container
                                    SizedBox(height: 10.0,),
                                    Container(
                                        child: Wrap(
                                          spacing: 10.0,
                                          runSpacing: 3.0,
                                          children: residentialWidgets.toList(),
                                        )
                                    ), //Filterchip for residential
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ), //Add location Container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_name_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Name",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Project Name
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: address_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Address
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: landmark_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Landmark",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Landmark
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width ,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: state_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "State",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //State
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: city_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "City",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //City
                              SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Upload Photos",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//upload photo container
                              SizedBox(height: 10.0,),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _imageFile != null
                                              ? Image.file(_imageFile)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              _optionsDialogBox(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _imageFile1 != null
                                              ? Image.file(_imageFile1)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              _optionsDialogBox1(context);
                                            },
                                          ),
                                        ),
                                    ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        child: ClipRRect(
                                          child: _imageFile != null
                                              ? Image.file(_imageFile)
                                              : FlatButton(
                                            child: Icon(
                                              Icons.add,
                                              size: 50,
                                            ),
                                            onPressed: () {
                                              _optionsDialogBox(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),//Choose photo
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Property Detail",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//property details
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    customRadio_3(bhk[0], 0),
                                    SizedBox(width: 10),
                                    customRadio_3(bhk[1], 1),
                                    SizedBox(width: 10),
                                    customRadio_3(bhk[2], 2),
                                    SizedBox(width: 10),
                                    customRadio_3(bhk[3], 3),
                                  ],
                                ),
                              ),//bhk detail
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: area_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Area",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Area
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: price_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Price",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Price
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_description_controller_r,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Description",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ), //Project Description
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Construction Status",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//Construction status container
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    customRadio_4(construction_status[0], 0),
                                    SizedBox(width: 20),
                                    customRadio_4(construction_status[1], 1),
                                  ],
                                ),
                              ),//construction status button
                              SizedBox(height: 30.0,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    postProperty(
                                        'Residential',
                                        '${owner_builder_broker[selectedIndex]}',
                                        '${sell_and_rent[selectedIndex1]}',
                                         '$_filters1',
                                        '${project_name_controller_r.text}',
                                        '${address_controller_r.text}, ${landmark_controller_r.text}, ${city_controller_r.text},  ${state_controller_r.text}',
                                        '${landmark_controller_r.text}',
                                        '${city_controller_r.text}',
                                        '${state_controller_r.text}',
                                        '${bhk[selectedIndex2]}',
                                        '${area_controller_r.text}',
                                        '${price_controller_r.text}',
                                        '${project_description_controller_r.text}',
                                        '${construction_status[selectedIndex3]}'
                                    );
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => Home()));
                                  },
                                  color: Colors.indigo,
                                  child: Center(child: Text("POST", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),//post button container

                              SizedBox(height: 30.0,)
                            ],
                          ),
                        ],
                      ), //residential
                      ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 7,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          customRadio_1c(sell_and_rent_1c[0], 0),
                                          SizedBox(width: 20),
                                          customRadio_1c(sell_and_rent_1c[1], 1),
                                        ],
                                      ),
                                    ),//sell rent radio button
                                    SizedBox(height: 10,),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left:20),
                                      child:Text("Property Type",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),),
                                    ),//property type container
                                    SizedBox(height: 10.0,),
                                    Container(
                                        child: Wrap(
                                          spacing: 10.0,
                                          runSpacing: 3.0,
                                          children: commercialWidgets.toList(),
                                        )
                                    ),//Filter chip buttons
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Add Location",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//add location container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_name_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Name",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//project name commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: address_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Address",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//address commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: landmark_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Landmark",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//landmark container commercial
                              SizedBox(height: 10.0),
                              Container(
                                width: MediaQuery.of(context).size.width ,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: state_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "State",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//state container commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: city_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "City",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//city container commercial
                              SizedBox(height: 10.0,),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Upload Photos",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//upload photo container
                              SizedBox(height: 10.0,),
                              Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _optionsDialogBox(context);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/2,
                                          color: Colors.white,
                                          child: Center(
                                            child: Icon(Icons.photo_library_outlined,size: 40.0,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _optionsDialogBox(context);
                                        },
                                        child: Container(
                                          color: Colors.white,
                                          width: MediaQuery.of(context).size.width/2,
                                          child: Center(
                                            child: Icon(Icons.photo_camera_outlined,size: 40.0,),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Property Detail",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//property detail container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: area_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Area",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//area container commercial
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: price_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Price",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//price container
                              SizedBox(height: 10.0,),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 100,
                                padding: EdgeInsets.only(left: 15),
                                margin: EdgeInsets.only(left: 20, top: 10,right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                                ),
                                child: TextFormField(
                                  controller: project_description_controller_c,
                                  decoration: InputDecoration(
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "Project Description",
                                      hintStyle: TextStyle(fontSize: 18)
                                  ),
                                ),
                              ),//project description container
                              SizedBox(height: 10.0,),
                              Divider(),
                              Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left:20),
                                  child: Text("Construction Status",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)
                              ),//construction status container
                              SizedBox(height: 10.0,),
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    customRadio_4c(construction_status_4c[0], 0),
                                    SizedBox(width: 20),
                                    customRadio_4c(construction_status_4c[1], 1),
                                  ],
                                ),
                              ),//construction status buttons
                              SizedBox(height: 30.0,),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 50,
                                child: RaisedButton(
                                  onPressed: () {
                                    postCommProperty(
                                        'Commercial',
                                        '${owner_builder_broker[selectedIndex]}',
                                        '${sell_and_rent_1c[selectedIndex1c]}',
                                        '$commercial1_filters',
                                        '${project_name_controller_c.text}',
                                        '${address_controller_c.text}, ${landmark_controller_c.text}, ${city_controller_c.text}, ${state_controller_c.text}',
                                        '${landmark_controller_c.text}',
                                        '${city_controller_c.text}',
                                        '${state_controller_c.text}',
                                        '${area_controller_c.text}',
                                        '${price_controller_c.text}',
                                        '${project_description_controller_c.text}',
                                        '${construction_status_4c[selectedIndex4c]}'
                                    );
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => Home()));
                                  },
                                  color: Colors.indigo,
                                  child: Center(child: Text("POST", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),//post button
                              SizedBox(height: 30.0,)
                            ],
                          ),
                        ],
                      ), //commercial
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void changeIndex_sell_rent_1(int index){
    setState(() {
      selectedIndex1=index;
    });
  }
  void changeIndex_sell_rent_1c(int index){
    setState(() {
      selectedIndex1c=index;
    });
  }
  void changeIndex_sell_rent_2(int index){
    setState(() {
      selectedIndex=index;
    });
  }
  void changeIndex_sell_rent_3(int index){
    setState(() {
      selectedIndex2=index;
    });
  }
  void changeIndex_sell_rent_4(int index){
    setState(() {
      selectedIndex3=index;
    });
  }
  void changeIndex_sell_rent_4c(int index){
    setState(() {
      selectedIndex4c=index;
    });
  }

  Widget customRadio_4(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_4(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex3 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex3 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_3(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_3(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex2 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex2 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_2(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_2(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
  Widget customRadio_1(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_1(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex1 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex1 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Widget customRadio_1c(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_1c(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex1c == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex1c == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Widget customRadio_4c(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_4c(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex4c == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex4c == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }
}

