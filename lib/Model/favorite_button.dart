import 'package:flutter/material.dart';

int itemCount = 5;
List<bool> selected = new List<bool>();

class Favorite_Button extends StatefulWidget {

  @override
  _Favorite_ButtonState createState() => _Favorite_ButtonState();
}

class _Favorite_ButtonState extends State<Favorite_Button> {

  @override
  initState() {
    for (var i = 0; i < itemCount; i++) {
      selected.add(false);
    }
    super.initState();
  }

  Icon firstIcon = Icon(
    Icons.favorite, // Icons.favorite
    color: Colors.red, // Colors.red
    size: 35,
  );
  Icon secondIcon = Icon(
    Icons.favorite_outline, // Icons.favorite_border
    color: Colors.grey,
    size: 35,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Button"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              return IconButton(
                icon: selected.elementAt(index) ? firstIcon : secondIcon,
                onPressed: () {
                  try {
                    // your code that you want this IconButton do
                    setState(() {
                      selected[index] = !selected.elementAt(index);
                    });
                    print(selected[index]);
                    // print('tap on ${index + 1}th IconButton ( change to : ');
                    // print(selected[index] ? 'active' : 'deactive' + ' )');
                  } catch (e) {
                    print(e);
                  }
                },
              );
            }),
      ),
    );
  }
}