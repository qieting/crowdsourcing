import 'package:flutter/material.dart';

class NewOrderOnDoofliceSecondPage extends StatelessWidget {
  NewOrderOnDoofliceSecondPage({@required this.locations});

  final List locations;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton.icon(
              shape: OutlineInputBorder(borderSide: BorderSide.none),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("增加代拿代买地")),
          ListView.builder(
              itemCount: locations.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("$index"));
                ;
              }),
          FlatButton.icon(
              shape: OutlineInputBorder(borderSide: BorderSide.none),
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text("设置目的地")),
        ],
      ),
    );
  }
}
