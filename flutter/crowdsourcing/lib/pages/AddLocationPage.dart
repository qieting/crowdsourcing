import 'package:crowdsourcing/channel/BaiduChannel.dart';
import 'package:crowdsourcing/common/LocationALL.dart';
import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/Location.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
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
  Location _location = new Location();
  List locations;
  int locationIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LocationAll.getProvinces().then((value) {
      locations = value;
    });
  }

  void ChooseLocation() async {
    await showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context1) {
          return StatefulBuilder(builder: (context, _setState) {
            var changeLocations = () async {
              switch (locationIndex) {
                case 0:
                  locations = await LocationAll.getProvinces();
                  break;
                case 1:
                  locations = await LocationAll.getCities(_location.province);
                  break;
                case 2:
                  locations = await LocationAll.getPlots(
                      _location.province, _location.city);
                  break;
                default:
                  Navigator.of(context1).pop();
                  break;
              }

              _setState(() {});
            };
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(children: <Widget>[
                    FlatButton(
                      child: _location.province == null
                          ? Text("请选择省份")
                          : Text(_location.province),
                      onPressed: () async {
                        locationIndex = 0;
                        await changeLocations();
                      },
                    ),
                    _location.province == null
                        ? SizedBox()
                        : FlatButton(
                            child: _location.city == null
                                ? Text("请选择城市")
                                : Text(_location.city),
                            onPressed: () async {
                              locationIndex = 1;
                              await changeLocations();
                            },
                          ),
                  ]),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  height: 150,
                  child: ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          height: 25,
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            locations[index],
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        onTap: () async {
                          switch (locationIndex) {
                            case 0:
                              _location.province = locations[index];
                              _location.city = null;
                              _location.plot = null;
                              locationIndex = 1;
                              await changeLocations();
                              break;
                            case 1:
                              _location.city = locations[index];
                              locationIndex = 2;
                              _location.plot = null;
                              changeLocations();
                              break;
                            case 2:
                              _location.plot = locations[index];
                              locationIndex = 3;
                              changeLocations();
                              break;
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          });
        });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("添加收获地址"),
          actions: <Widget>[
            FlatButton(
                child: Text("保存", style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  String name = nameController.text;
                  if (name.length == 0) {
                    MyToast.toast("姓名不能为空");
                    return;
                  }
                  String number = phoneController.text;
                  if (number.length == 0) {
                    MyToast.toast("联系方式不能为空");
                    return;
                  }
                  String others = othersController.text;
                  if (others.length == 0) {
                    MyToast.toast("详细联系方式不能为空");
                    return;
                  }
                  if (_location.plot == null) {
                    MyToast.toast("城市等信息不能为空");
                    return;
                  }

                  _location.others = others;
                  _location.phone = number;
                  _location.name = name;
                  _location.isMain = main;
                  await MyDio.addLocation(_location, context: context);
                  Navigator.of(context).pop();
                })
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
                        child: Text(_location.province == null
                            ? "手动设置地址"
                            : _location.locationToString(containOthers: false)),
                        onPressed: () {
                          ChooseLocation();
                        },
                      ),
                      _location.province == null
                          ? FlatButton(
                              child: Text("使用当前位置"),
                              onPressed: () {
                                BaiduChannel.getLocation(context,
                                    (Location location) {
                                  if (othersController.text != null) {
                                    othersController.text = location.others;
                                  }
                                  _location = location;
                                  setState(() {});
                                });
                              },
                            )
                          : SizedBox()
                    ],
                  )),
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
