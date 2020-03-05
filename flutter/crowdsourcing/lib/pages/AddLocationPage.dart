import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class AddLocationPage extends StatefulWidget {
  @override
  _AddLocationPageState createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("添加收获地址"),
          actions: <Widget>[
            FlatButton(
                child: Text("保存", style: TextStyle(color: Colors.white)),
                onPressed: () {

                })
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              TextField(
                decoration:InputDecoration(
                  labelText: "ad",
                  labelStyle: TextStyle(fontSize: 35)
                ) ,
              )
            ],
          ),
        ));
  }
}
