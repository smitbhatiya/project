import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search_Page extends StatefulWidget {
  @override
  _Search_PageState createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
  bool _isSelected=false;
  int _value1 = 100000;
  int _value2 = 100;
  int _value3 = 100000;
  int _value4 = 100;
  List<String> sale_type_list = ['New', 'Resale'];
  List<String> select_checkbox = ['User', 'Builder', 'Brocker'];
  List<String> sell_and_rent = ['Sell', 'Rent'];
  List<String> sell_and_rent1 = ['Sell', 'Rent'];
  int selectedIndex1 = 0;
  int selectedIndex2 = 0;
  int selectedIndex3 = 0;
  int selectedIndex4 = 0;

  bool apartment = false;
  bool villa=false;
  bool rowhouse=false;
  bool farmhouse=false;
  bool plot=false;
  bool pentahouse=false;
  bool other=false;
  bool officespace=false;
  bool shop=false;
  bool warehouse=false;
  bool commercialland=false;
  bool hotel=false;
  bool showroom=false;
  bool usr1=false;
  bool usr2=false;
  bool builder1=false;
  bool builder2=false;
  bool broker1=false;
  bool broker2=false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        body: SafeArea(
          child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 20, top: 15),
                    child: Text("Location", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 50,
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.only(left: 20, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "State",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.44,
                        height: 50,
                        padding: EdgeInsets.only(left: 15),
                        margin: EdgeInsets.only(left: 10, right: 20, top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(style: BorderStyle.solid, color: Colors.grey),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "City",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.0),),
                  SizedBox(
                    height: 50 ,
                    child: AppBar(
                      backgroundColor: Colors.grey.shade50,
                      elevation: 0,
                      //backgroundColor: Colors.white70,
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            icon: Text("Residential", style: TextStyle(fontSize: 18, color: Colors.indigo, fontWeight: FontWeight.bold)),
                          ),
                          Tab(
                            icon: Text("Commercial", style: TextStyle(fontSize: 18, color: Colors.indigo, fontWeight: FontWeight.bold)),
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
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    alignment: Alignment.topLeft,
                                      child: Text(
                                        "Property Type",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                      )
                                  ),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: apartment,
                                          onChanged:(bool value){
                                            setState(() {
                                              apartment=value;
                                            });
                                          }
                                      ),
                                      Text("Apartment", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: villa,
                                          onChanged:(bool value){
                                            setState(() {
                                              villa=value;
                                            });
                                          }
                                      ),
                                      Text("Villa/House", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: rowhouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              rowhouse=value;
                                            });
                                          }
                                      ),
                                      Text("Row House", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: farmhouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              farmhouse=value;
                                            });
                                          }
                                      ),
                                      Text("Farm House", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: plot,
                                          onChanged:(bool value){
                                            setState(() {
                                              plot=value;
                                            });
                                          }
                                      ),
                                      Text("Plot", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: pentahouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              pentahouse=value;
                                            });
                                          }
                                      ),
                                      Text("Penta House", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: other,
                                          onChanged:(bool value){
                                            setState(() {
                                              other=value;
                                            });
                                          }
                                      ),
                                      Text("Others", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Budget", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(_value1.toString())
                                  ),
                                  Container(
                                    child: Slider(
                                      value: _value1.toDouble(),
                                      min: 100000.0,
                                      max: 3000000.0,
                                      divisions: 100,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      label: _value1.toString(),
                                      onChanged: (double newValue) {
                                        setState(() {
                                          _value1 = newValue.round();
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 5),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Sale Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        customRadio_3(sale_type_list[0], 0),
                                        SizedBox(width: 15),
                                        customRadio_3(sale_type_list[1], 1),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Area (Sq. ft)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(_value2.toString())
                                  ),
                                  Container(
                                    child: Slider(
                                      value: _value2.toDouble(),
                                      min: 100.0,
                                      max: 10000.0,
                                      divisions: 100,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      label: _value2.toString(),
                                      onChanged: (double newValue) {
                                        setState(() {
                                          _value2 = newValue.round();
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text("Posted by", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: usr1,
                                            onChanged:(bool value){
                                              setState(() {
                                                usr1=value;
                                              });
                                            }
                                        ),
                                        Text("User", style: TextStyle(fontSize: 16.0)),
                                        Checkbox(
                                            value: builder1,
                                            onChanged:(bool value){
                                              setState(() {
                                                builder1=value;
                                              });
                                            }
                                        ),
                                        Text("Builder", style: TextStyle(fontSize: 16.0)),
                                        Checkbox(
                                            value: broker1,
                                            onChanged:(bool value){
                                              setState(() {
                                                broker1=value;
                                              });
                                            }
                                        ),
                                        Text("Broker", style: TextStyle(fontSize: 16.0)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    height: 50,
                                    child: RaisedButton(
                                      onPressed: () {},
                                      color: Colors.indigo,
                                      child: Center(child: Text("Apply", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ],
                        ), //residential
                        ListView(
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
                                        customRadio_2(sell_and_rent1[0], 0),
                                        SizedBox(width: 20),
                                        customRadio_2(sell_and_rent1[1], 1),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Property Type",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                      )
                                  ),
                                  SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: officespace,
                                          onChanged:(bool value){
                                            setState(() {
                                              officespace=value;
                                            });
                                          }
                                      ),
                                      Text("Office Space", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: shop,
                                          onChanged:(bool value){
                                            setState(() {
                                              shop=value;
                                            });
                                          }
                                      ),
                                      Text("Shop", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: warehouse,
                                          onChanged:(bool value){
                                            setState(() {
                                              warehouse=value;
                                            });
                                          }
                                      ),
                                      Text("Ware House", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: commercialland,
                                          onChanged:(bool value){
                                            setState(() {
                                              commercialland=value;
                                            });
                                          }
                                      ),
                                      Text("Commercial Land", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: hotel,
                                          onChanged:(bool value){
                                            setState(() {
                                              hotel=value;
                                            });
                                          }
                                      ),
                                      Text("Hotel", style: TextStyle(fontSize: 16.0)),
                                      Checkbox(
                                          value: showroom,
                                          onChanged:(bool value){
                                            setState(() {
                                              showroom=value;
                                            });
                                          }
                                      ),
                                      Text("Show Room", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                          value: other,
                                          onChanged:(bool value){
                                            setState(() {
                                              other=value;
                                            });
                                          }
                                      ),
                                      Text("Others", style: TextStyle(fontSize: 16.0)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Divider(),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Budget", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(_value3.toString())
                                  ),
                                  Container(
                                    child: Slider(
                                      value: _value3.toDouble(),
                                      min: 100000.0,
                                      max: 3000000.0,
                                      divisions: 100,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      label: _value3.toString(),
                                      onChanged: (double newValue) {
                                        setState(() {
                                          _value3 = newValue.round();
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 5),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Sale Type", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      children: [
                                        customRadio_4(sale_type_list[0], 0),
                                        SizedBox(width: 15),
                                        customRadio_4(sale_type_list[1], 1),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20),
                                    child: Text("Area (Sq. ft)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                  ),
                                  Container(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(right: 20),
                                      child: Text(_value4.toString())
                                  ),
                                  Container(
                                    child: Slider(
                                      value: _value4.toDouble(),
                                      min: 100.0,
                                      max: 10000.0,
                                      divisions: 100,
                                      activeColor: Colors.blue,
                                      inactiveColor: Colors.grey,
                                      label: _value4.toString(),
                                      onChanged: (double newValue) {
                                        setState(() {
                                          _value4 = newValue.round();
                                        });
                                      },
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text("Posted by", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 8),
                                    child: Row(
                                      children: [
                                        Checkbox(
                                            value: usr2,
                                            onChanged:(bool value){
                                              setState(() {
                                                usr2=value;
                                              });
                                            }
                                        ),
                                        Text("User", style: TextStyle(fontSize: 16.0)),
                                        Checkbox(
                                            value: builder2,
                                            onChanged:(bool value){
                                              setState(() {
                                                builder2=value;
                                              });
                                            }
                                        ),
                                        Text("Builder", style: TextStyle(fontSize: 16.0)),
                                        Checkbox(
                                            value: broker2,
                                            onChanged:(bool value){
                                              setState(() {
                                                broker2=value;
                                              });
                                            }
                                        ),
                                        Text("Broker", style: TextStyle(fontSize: 16.0)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: 50,
                              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.3, left: MediaQuery.of(context).size.width * 0.3),
                              child: RaisedButton(
                                onPressed: () {},
                                color: Colors.indigo,
                                child: Center(child: Text("Apply", style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold))),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            SizedBox(height: 10)
                          ],
                        ), //commercial
                      ],
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }

  void changeIndex_sell_rent_1(int index) {
    setState(() {
      selectedIndex1 = index;
    });
  }

  void changeIndex_sell_rent_2(int index) {
    setState(() {
      selectedIndex2 = index;
    });
  }

  void changeIndex_new_resale_1(int index) {
    setState(() {
      selectedIndex3 = index;
    });
  }

  void changeIndex_new_resale_2(int index) {
    setState(() {
      selectedIndex4 = index;
    });
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

  Widget customRadio_2(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_sell_rent_2(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex2 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex2 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Widget customRadio_3(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_new_resale_1(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex3 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex3 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

  Widget customRadio_4(String txt, int index) {
    return OutlineButton(
      onPressed: () => changeIndex_new_resale_2(index),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      borderSide: BorderSide(color: selectedIndex4 == index ? Colors.indigo : Colors.grey),
      child: Text(txt, style: TextStyle(color: selectedIndex4 == index? Colors.indigo: Colors.grey, fontSize: 16.0),),
    );
  }

}
