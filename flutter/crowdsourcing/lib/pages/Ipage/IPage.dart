import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/WhiteblockWidget/WhiteblockWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IState();
  }
}

class IState extends State<IPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
            child: Card(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(child: Consumer<OffineOrderingModel>(
                    builder: (context, offineOrderingModel, child) {
                  return Expanded(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.amberAccent),
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Text(
                                    "进行中",
                                    textScaleFactor: 1.3,
                                  ),
                                  top: 15,
                                  left: 15,
                                ),
                                Positioned(
                                  child: Text(
                                    offineOrderingModel.taking().toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                  bottom: 15,
                                  right: 30,
                                )
                              ],
                            ),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(color: Colors.blue),
                          child: GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Text(
                                    "已完成",
                                    textScaleFactor: 1.3,
                                  ),
                                  top: 15,
                                  left: 15,
                                ),
                                Positioned(
                                  child: Text(
                                    offineOrderingModel.hasfinish().toString(),
                                    textScaleFactor: 1.2,
                                  ),
                                  bottom: 15,
                                  right: 30,
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  );
                })),
                Expanded(
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.cyanAccent),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Text(
                                "我发布的",
                                textScaleFactor: 1.3,
                              ),
                              left: 15,
                              top: 15,
                            ),
                            Positioned(
                              child: Container(child:
                                  Consumer<OffineOrderModel>(builder:
                                      (context, offineOrderModel, child) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("  未被接  "),
                                            Text(offineOrderModel.notStartnumber().toString())
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("  进行中  "),
                                            Text(offineOrderModel.doingnumber().toString())
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Text("  已完成  "),
                                            Text(offineOrderModel.finishnumber().toString())
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              })),
                              left: 15,
                              right: 15,
                              bottom: 15,
                            )
                          ],
                        )))
              ],
            ))),
        WhiteblockWidget(
          icon: Icon(
            Icons.location_city,
            color: Theme.of(context).accentColor.withAlpha(180),
          ),
          onClick: () {
            Routers.push(context, Routers.LOCATIONPAGE);
          },
        )
      ],
    );
  }
}
