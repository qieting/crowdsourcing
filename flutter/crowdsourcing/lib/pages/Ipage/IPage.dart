import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/pages/MyOrderPage.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:crowdsourcing/widgets/WhiteblockWidget/WhiteblockWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Card(
                  child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                            child: Center(
                                child: Text(
                                    DemoLocalizations.of(context).wallet))),
                        Expanded(
                          child: Consumer<UserModel>(
                              builder: (context, userModel, child) {
                            return Text((userModel.user?.money??0).toString()+ "元");
                          }),
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                            child: FlatButton(
                          child: Text(DemoLocalizations.of(context).recharge),
                          onPressed: () async {
                            String moneys = await showReasonDialog();
                            if (moneys == null) {
                              MyToast.toast("取消充值");
                            } else {
                              int money = int.parse(moneys);
                              if (money == 0) {
                                MyToast.toast("充值金额不可为0");
                              } else {
                                MyDio.changeMessage({
                                  "money": Provider.of<UserModel>(context,
                                              listen: false)
                                          .user
                                          .money +
                                      money
                                });
                              }
                            }
                          },
                        )),
                        Expanded(
                            child: FlatButton(
                          onPressed: () async {
                            String moneys = await showReasonDialog();
                            if (moneys == null) {
                              MyToast.toast("取消提现");
                            } else {
                              int money = int.parse(moneys);
                              if (money == 0) {
                                MyToast.toast("提现金额不可为0");
                              } else if (Provider.of<UserModel>(context,
                                          listen: false)
                                      .user
                                      .money <
                                  money) {
                                MyToast.toast("提现金额不足");
                              } else {
                                MyDio.changeMessage({
                                  "money": Provider.of<UserModel>(context,
                                              listen: false)
                                          .user
                                          .money -
                                      money
                                });
                              }
                            }
                          },
                          child: Text(DemoLocalizations.of(context).withdraw),
                        )),
                      ],
                    ),
                  )
                ],
              ))),
          Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: Card(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(child:
                      Consumer2<OffineOrderingModel, OnlineOrderingModel>(
                          builder: (context, offineOrderingModel,
                              onlineOrdingModel, child) {
                    return Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                              child: Container(
                            height: double.infinity,
                            decoration:
                                BoxDecoration(color: Colors.amberAccent),
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
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text: '线上:',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = onlineOrdingModel
                                                      .taking() !=
                                                  0
                                              ? () {
                                                  Routers.push(context,
                                                      Routers.OTHERORDERPAGE,
                                                      params: {
                                                        'status':
                                                            OrderStatus.take,
                                                        "online": true
                                                      });
                                                }
                                              : null,
                                        style: TextStyle(fontSize: 14)),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = onlineOrdingModel
                                                      .taking() !=
                                                  0
                                              ? () {
                                                  Routers.push(context,
                                                      Routers.OTHERORDERPAGE,
                                                      params: {
                                                        'status':
                                                            OrderStatus.take,
                                                        "online": true
                                                      });
                                                }
                                              : null,
                                        text: onlineOrdingModel
                                            .taking()
                                            .toString(),
                                        style: TextStyle(fontSize: 16)),
                                    TextSpan(text: "  "),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = offineOrderingModel
                                                      .taking() !=
                                                  0
                                              ? () {
                                                  Routers.push(context,
                                                      Routers.OTHERORDERPAGE,
                                                      params: {
                                                        'status':
                                                            OrderStatus.take,
                                                        "online": false
                                                      });
                                                }
                                              : null,
                                        text: '线下:',
                                        style: TextStyle(fontSize: 14)),
                                    TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = offineOrderingModel
                                                      .taking() !=
                                                  0
                                              ? () {
                                                  Routers.push(context,
                                                      Routers.OTHERORDERPAGE,
                                                      params: {
                                                        'status':
                                                            OrderStatus.take,
                                                        "online": false
                                                      });
                                                }
                                              : null,
                                        text: offineOrderingModel
                                            .taking()
                                            .toString(),
                                        style: TextStyle(fontSize: 16))
                                  ])),
                                  bottom: 15,
                                  right: 30,
                                )
                              ],
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
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: '线上:',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = onlineOrdingModel
                                                        .hasfinish() !=
                                                    0
                                                ? () {
                                                    Routers.push(context,
                                                        Routers.OTHERORDERPAGE,
                                                        params: {
                                                          'status': OrderStatus
                                                              .finish,
                                                          "online": true
                                                        });
                                                  }
                                                : null,
                                          style: TextStyle(fontSize: 14)),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = onlineOrdingModel
                                                        .hasfinish() !=
                                                    0
                                                ? () {
                                                    Routers.push(context,
                                                        Routers.OTHERORDERPAGE,
                                                        params: {
                                                          'status': OrderStatus
                                                              .finish,
                                                          "online": true
                                                        });
                                                  }
                                                : null,
                                          text: onlineOrdingModel
                                              .hasfinish()
                                              .toString(),
                                          style: TextStyle(fontSize: 16)),
                                      TextSpan(text: "  "),
                                      TextSpan(
                                          text: '线下:',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = onlineOrdingModel
                                                        .hasfinish() !=
                                                    0
                                                ? () {
                                                    Routers.push(context,
                                                        Routers.OTHERORDERPAGE,
                                                        params: {
                                                          'status': OrderStatus
                                                              .finish,
                                                          "online": false
                                                        });
                                                  }
                                                : null,
                                          style: TextStyle(fontSize: 14)),
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = onlineOrdingModel
                                                        .hasfinish() !=
                                                    0
                                                ? () {
                                                    Routers.push(context,
                                                        Routers.OTHERORDERPAGE,
                                                        params: {
                                                          'status': OrderStatus
                                                              .finish,
                                                          "online": false
                                                        });
                                                  }
                                                : null,
                                          text: offineOrderingModel
                                              .hasfinish()
                                              .toString(),
                                          style: TextStyle(fontSize: 16))
                                    ])),
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
                          child: Consumer2<OffineOrderModel, OnlineOrderModel>(
                              builder: (context, offineOrderModel,
                                  onlineOrderModel, child) {
                            return Stack(
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
                                  child: GestureDetector(
                                    onTap: onlineOrderModel.submit() +
                                                offineOrderModel.submit() ==
                                            0
                                        ? null
                                        : () {
                                            Routers.push(
                                                context, Routers.MYORDERPAGE,
                                                params: {
                                                  "status": OrderStatus.submit
                                                });
                                          },
                                    child: Text.rich(TextSpan(children: [
                                      TextSpan(
                                          text: '待我审核',
                                          style: TextStyle(fontSize: 14)),
                                      TextSpan(
                                          text: (onlineOrderModel.submit() +
                                                  offineOrderModel.submit())
                                              .toString(),
                                          style: TextStyle(fontSize: 16)),
                                    ])),
                                  ),
                                  right: 15,
                                  top: 15,
                                ),
                                Positioned(
                                  child: Container(
                                      child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            Routers.push(
                                                context, Routers.MYORDERPAGE,
                                                params: {
                                                  "status": OrderStatus.no
                                                });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text("  未被接  "),
                                              Text((onlineOrderModel
                                                          .notStartnumber() +
                                                      offineOrderModel
                                                          .notStartnumber())
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            Routers.push(
                                                context, Routers.MYORDERPAGE,
                                                params: {
                                                  "status": OrderStatus.take
                                                });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text("  进行中  "),
                                              Text((offineOrderModel
                                                          .doingnumber() +
                                                      onlineOrderModel
                                                          .doingnumber())
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            Routers.push(
                                                context, Routers.MYORDERPAGE,
                                                params: {
                                                  "status": OrderStatus.finish
                                                });
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text("  已完成  "),
                                              Text((offineOrderModel
                                                          .finishnumber() +
                                                      onlineOrderModel
                                                          .finishnumber())
                                                  .toString())
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                  left: 15,
                                  right: 15,
                                  bottom: 15,
                                )
                              ],
                            );
                          })))
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
          ),
          WhiteblockWidget(
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).accentColor.withAlpha(180),
            ),
            title: "设置",
            onClick: () {
              Routers.push(context, Routers.SETTINGPAGE);
            },
          )
        ],
      ),
    );
  }

  Future<String> showReasonDialog() {
    // 默认复选框不选中
    return showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController textEditingController =
            new TextEditingController();
        return AlertDialog(
          title: Text("请输入金额"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
                maxLines: 2,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  WhitelistingTextInputFormatter(RegExp("[0-9]"))
                ],
                decoration: InputDecoration(
                  hintText: "要求整数",
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                Navigator.of(context).pop(textEditingController.text);
              },
            ),
            FlatButton(
              child: Text("取消"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
