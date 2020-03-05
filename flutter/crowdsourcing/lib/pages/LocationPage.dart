import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routers.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("我的收货地址"),
          actions: <Widget>[
            FlatButton(
                child: Text("添加新地址", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Routers.push(context, Routers.ADDLOcationPage);
                })
          ],
        ),
        body: Container(
          child:
              Consumer<LocationModel>(builder: (context, locationModel, child) {
            List<Location> locations = locationModel.locations ?? [];
            return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Container(
                      child: Text(
                    locations[index].toString(),
                  ));
                });
          }),
        ));
  }
}
