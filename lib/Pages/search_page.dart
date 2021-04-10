import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResidentialFilterEntry {
  const ResidentialFilterEntry(this.name);
  final String name;
}

class CommercialFilterEntry {
  const CommercialFilterEntry(this.cname);
  final String cname;
}

class ResidentialUsertypeEntry {
  const ResidentialUsertypeEntry(this.ruser);
  final String ruser;
}

class CommercialUsertypeEntry {
  const CommercialUsertypeEntry(this.cuser);
  final String cuser;
}

class Search_Page extends StatefulWidget {
  @override
  _Search_PageState createState() => _Search_PageState();
}

class _Search_PageState extends State<Search_Page> {
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
  TextEditingController state_controller = TextEditingController();
  TextEditingController city_controller = TextEditingController();

  final List<ResidentialFilterEntry> residential_cast = <ResidentialFilterEntry>[
    const ResidentialFilterEntry('Apartment'),
    const ResidentialFilterEntry('Villa/House'),
    const ResidentialFilterEntry('Row House'),
    const ResidentialFilterEntry('Farm House'),
    const ResidentialFilterEntry('Plot'),
    const ResidentialFilterEntry('Pent House'),
    const ResidentialFilterEntry('Others'),
  ];
  List<String> _filters = <String>[];

  Iterable<Widget> get residentialWidgets sync* {
    for (final ResidentialFilterEntry residential in residential_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(residential.name),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: _filters.contains(residential.name),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  _filters.add(residential.name);
                } else {
                  _filters.removeWhere((String name) {
                    return name == residential.name;
                  });
                }
                print('${_filters.join(', ')}');
              });
            },
          ),
        ),
      );
    }
  }

  //ignore: non_constant_identifier_names
  final List<CommercialFilterEntry> commercial_cast = <CommercialFilterEntry>[
    const CommercialFilterEntry('Office Space'),
    const CommercialFilterEntry('Shop'),
    const CommercialFilterEntry('Ware House'),
    const CommercialFilterEntry('Commercial Land'),
    const CommercialFilterEntry('Hotel'),
    const CommercialFilterEntry('Showroom'),
    const CommercialFilterEntry('Others'),
  ];
  // ignore: non_constant_identifier_names
  List<String> commercial_filters = <String>[];

  Iterable<Widget> get commercialWidgets sync* {
    for (final CommercialFilterEntry commercial in commercial_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(commercial.cname),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: commercial_filters.contains(commercial.cname),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  commercial_filters.add(commercial.cname);
                } else {
                  commercial_filters.removeWhere((String name) {
                    return name == commercial.cname;
                  });
                }
                print('${commercial_filters.join(', ')}');
              });
            },
          ),
        ),
      );
    }
  }
  // ignore: non_constant_identifier_names

  final List<ResidentialUsertypeEntry> residentialUser_cast = <ResidentialUsertypeEntry>[
    const ResidentialUsertypeEntry('User'),
    const ResidentialUsertypeEntry('Builder'),
    const ResidentialUsertypeEntry('Broker'),
  ];
  // ignore: non_constant_identifier_names
  List<String> residentialUser_filters = <String>[];

  Iterable<Widget> get residentialUserWidgets sync* {
    for (final ResidentialUsertypeEntry residentialUser in residentialUser_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(residentialUser.ruser),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: residentialUser_filters.contains(residentialUser.ruser),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  residentialUser_filters.add(residentialUser.ruser);
                } else {
                  residentialUser_filters.removeWhere((String name) {
                    return name == residentialUser.ruser;
                  });
                }
                print('${residentialUser_filters.join(', ')}');
              });
            },
          ),
        ),
      );
    }
  }

  final List<CommercialUsertypeEntry> commercialUser_cast = <CommercialUsertypeEntry>[
    const CommercialUsertypeEntry('User'),
    const CommercialUsertypeEntry('Builder'),
    const CommercialUsertypeEntry('Broker'),
  ];
  List<String> commercialUser_filters = <String>[];

  Iterable<Widget> get commercialUserWidgets sync* {
    for (final CommercialUsertypeEntry commercialUser in commercialUser_cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: FilterChip(
            label: Text(commercialUser.cuser),
            labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
            selected: commercialUser_filters.contains(commercialUser.cuser),
            backgroundColor: Colors.indigo.shade50,
            selectedColor: Colors.indigo.shade100,
            onSelected: (bool value) {
              setState(() {
                if (value) {
                  commercialUser_filters.add(commercialUser.cuser);
                } else {
                  commercialUser_filters.removeWhere((String name) {
                    return name == commercialUser.cuser;
                  });
                }
                print('${commercialUser_filters.join(', ')}');
              });
            },
          ),
        ),
      );
    }
  }

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
                          controller: state_controller,
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
                          controller: city_controller,
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
                                  Container(
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 3.0,
                                        children: residentialWidgets.toList(),
                                      )
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
                                    child: Container(
                                        child: Wrap(
                                          spacing: 10.0,
                                          runSpacing: 3.0,
                                          children: residentialUserWidgets.toList(),
                                        )
                                    )
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
                                  Container(
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 3.0,
                                        children: commercialWidgets.toList(),
                                      )
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
                                    child: Container(
                                        child: Wrap(
                                          spacing: 10.0,
                                          runSpacing: 3.0,
                                          children: commercialUserWidgets.toList(),
                                        )
                                    )
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

// class filterChipWidget extends StatefulWidget {
//   final String chipName;
//
//   filterChipWidget({Key key, this.chipName}) : super(key: key);
//
//   @override
//   _filterChipWidgetState createState() => _filterChipWidgetState();
// }
//
// class _filterChipWidgetState extends State<filterChipWidget> {
//   bool _isSelected = false;
//   List<String> _filters = <String>[];
//
//   @override
//   Widget build(BuildContext context) {
//     return FilterChip(
//       label: Text(widget.chipName),
//       labelStyle: TextStyle(color: Colors.indigo,fontSize: 16.0,fontWeight: FontWeight.bold),
//       selected: _filters.contains(widget.chipName),
//       shape:RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(
//             30.0),),
//       backgroundColor: Colors.indigo.shade50,
//       onSelected: (isSelected) {
//         setState(() {
//           _isSelected = isSelected;
//           if (isSelected) {
//             _filters.add(widget.chipName);
//           } else {
//             _filters.removeWhere((String name) {
//               return name == widget.chipName;
//             });
//           }
//           print('${_filters.join(', ')}');
//         });
//       },
//       selectedColor: Colors.indigo.shade100);
//   }
// }

