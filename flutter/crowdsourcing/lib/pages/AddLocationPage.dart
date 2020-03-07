import 'package:crowdsourcing/channel/BaiduChannel.dart';
import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class AddLocationPage extends StatefulWidget {
  @override
  _AddLocationPageState createState() => _AddLocationPageState();




}

class _AddLocationPageState extends State<AddLocationPage> {
  TextEditingController nameController = new TextEditingController(),
      phoneController = new TextEditingController(),
      othersController = new TextEditingController();
  bool main = false;
  Location _location  =new Location();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("添加收获地址"),
          actions: <Widget>[
            FlatButton(
                child: Text("保存", style: TextStyle(color: Colors.white)),
                onPressed: () {})
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 10),
                      hintText: "联系人",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      //disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
              Divider(),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(top: 10),
                      hintText: "手机号码",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      //disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
              Divider(),
              Container(
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        child: Text("设置地址"),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text("使用当前位置"),
                        onPressed: () {
                          BaiduChannel.getLocation(context,(location){
                            _location=location;
                            setState(() {

                            });
                          });
                        },
                      )
                    ],
                  )),
              Divider(),
              Container(
                  margin: const EdgeInsets.only(left: 15, right: 5),
                  child: Text(_location.toString())),
              Divider(),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: TextField(
                  controller: othersController,
                  maxLines: 3,
                  decoration: InputDecoration(
                      isDense: true,

                      contentPadding: const EdgeInsets.only(top: 10),
                      hintText: "详细地址：如街道、门牌号、单元室等",
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      //disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
              ),
              Divider(),
              Container(
                margin: const EdgeInsets.only(left: 15, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("设为默认地址"),
                    Switch(
                      value: main,
                      onChanged: (value) {
                        main = value;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        ));
  }
}
