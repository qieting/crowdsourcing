import 'package:crowdsourcing/models/UserModel/LocationModel.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../routers.dart';

class LocationPage extends StatelessWidget {
  LocationPage({this.choose});

  final choose;

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
        body: Container(child:
            Consumer<LocationModel>(builder: (context, locationModel, child) {
          List<Location> locations = locationModel.locations ?? [];
          return StatefulBuilder(builder: (context, _setState) {
            return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: choose == null
                          ? null
                          : () {
                              choose(locations[index]);
                              Navigator.of(context).pop();
                            },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(locations[index].name),
                                Text(
                                  locations[index].phone,
                                ),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                      width: 40,
                                      child: Icon(Icons.delete_outline)),
                                  onTap: () async {
                                    bool delete =
                                        await showDeleteConfirmDialog1(context);
                                    if (delete) {
                                      locationModel
                                          .deleteLocation(locations[index].id);
                                      _setState(() {});
                                    }
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(locations[index].locationToString()),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("设为默认地址"),
                                Switch(
                                  value: locations[index].isMain,
                                  onChanged: (value) {
//                                      locations[index].isMain =
//                                          !locations[index].isMain;
                                    locationModel
                                        .changeMainLocation(locations[index]);
                                    _setState(() {});
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          });
        })));
  }

  // 弹出对话框
  Future<bool> showDeleteConfirmDialog1(context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前位置吗?"),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(false), // 关闭对话框
            ),
            FlatButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
