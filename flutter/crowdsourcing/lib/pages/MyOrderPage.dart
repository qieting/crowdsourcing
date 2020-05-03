import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyOrderPage extends StatelessWidget {
  final OrderStatus orderStatus;

  MyOrderPage(this.orderStatus);

  String getName() {
    switch (orderStatus) {
      case OrderStatus.no:
        return "未完成";
      case OrderStatus.take:
        return "进行中";
      case OrderStatus.submit:
        // TODO: Handle this case.
        return "待审核";
        break;
      case OrderStatus.finish:
        return "已完成";
        // TODO: Handle this case.
        break;
      case OrderStatus.all:
        return "全部";
        // TODO: Handle this case.
        break;
      case OrderStatus.takeNoSubmit:
        // TODO: Handle this case.
        return "领取但未提交";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我发布的(" + getName() + ")"),
        ),
        body: Container(
          padding: const EdgeInsets.only(top: 15),
          child: Consumer2<OffineOrderModel, OnlineOrderModel>(
              builder: (context, offineOrderModel, onLineOrderModel, child) {
            List<Order> myOrders = offineOrderModel.getOrder(orderStatus)
              ..addAll(onLineOrderModel.getOrder(orderStatus));
            return ListView.builder(
              itemCount: myOrders.length,
              itemBuilder: (context, index) {
                switch (orderStatus) {
                  case OrderStatus.take:
                    return Card(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (myOrders[index] is OnlineOrder) {
                            Routers.push(context, Routers.ONLINEORDERINGPAGE,
                                params: {
                                  "order": myOrders[index],
                                });
                          } else {
                            Routers.push(context, Routers.OFFINEORDERINGPAGE,
                                params: {
                                  "order": myOrders[index],
                                });
                          }
                        },
                        onLongPress: ()async{
                          if(orderStatus!=OrderStatus.finish)
                          if (myOrders[index] is  OnlineOrder) {
                            bool f = await showDialog<bool>(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("提示"),
                                  content: Text("您确定要删除当前任务吗?(若已有人接单则只可暂停接单，不可全部删除)"),
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
                            if(f)
                            await MyDio.changeOnlineOrder(myOrders[index].id,context);

                          } else { bool f = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("提示"),
                                content: Text("您确定要删除当前任务吗?（若对方已接单会直接付款给对面，否则退款"),
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

                            if(f)
                            await MyDio.finishOffineOrder(myOrders[index].id,context);
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Image(
                              width: 30,
                              height: 30,
                              image: AssetImage(myOrders[index] is OnlineOrder
                                  ? "assets/images/onlineIcon.png"
                                  : "assets/images/offineIcon.png"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      myOrders[index].title,
                                      textScaleFactor: 1.3,
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text("进行中" +
                                        myOrders[index].take.toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("剩余名额" +
                                        myOrders[index].remain.toString()),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("等待审核" +
                                        myOrders[index].submit.toString())
                                  ],
                                )
                              ],
                            ),
                            Expanded(
                                child: Text(
                              myOrders[index].price.toString() + "元",
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ),
                    );
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.submit:
                    return Card(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (myOrders[index] is OnlineOrder) {
                            Routers.push(context, Routers.ONLINEORDERINGPAGE,
                                params: {
                                  "order": myOrders[index],
                                });
                          } else {
                            Routers.push(context, Routers.OFFINEORDERINGPAGE,
                                params: {
                                  "order": myOrders[index],
                                });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Image(
                              width: 30,
                              height: 30,
                              image: AssetImage(myOrders[index] is OnlineOrder
                                  ? "assets/images/onlineIcon.png"
                                  : "assets/images/offineIcon.png"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      myOrders[index].title,
                                      textScaleFactor: 1.3,
                                    ),
                                    SizedBox(
                                      width: 35,
                                    ),
                                    Text("进行中" +
                                        myOrders[index].take.toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    Text("剩余名额" +
                                        myOrders[index].remain.toString()),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text("等待审核" +
                                        myOrders[index].submit.toString())
                                  ],
                                )
                              ],
                            ),
                            Expanded(
                                child: Text(
                                  myOrders[index].price.toString() + "元",
                                  textAlign: TextAlign.right,
                                ))
                          ],
                        ),
                      ),
                    );
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.finish:
                    // TODO: Handle this case.
                    return Card(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (myOrders[index] is OnlineOrder) {
                            Routers.push(
                                context, Routers.ORDERONLINEDETAILSPAGE,
                                params: {
                                  "onlineOrder": myOrders[index],
                                  'detail': true
                                });
                          } else {
                            Routers.push(context, Routers.ORDEROFFINEDETAILPAGE,
                                params: {
                                  "offineOrder": myOrders[index],
                                  'detail': true
                                });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Image(
                              width: 30,
                              height: 30,
                              image: AssetImage(myOrders[index] is OnlineOrder
                                  ? "assets/images/onlineIcon.png"
                                  : "assets/images/offineIcon.png"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  myOrders[index].title,
                                  textScaleFactor: 1.3,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("剩余名额" + myOrders[index].remain.toString())
                              ],
                            ),
                            Expanded(
                                child: Text(
                              myOrders[index].price.toString() + "元",
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ),
                    );
                    break;
                  case OrderStatus.no:
                    return Card(
                      margin: const EdgeInsets.only(left: 8, right: 8, top: 15),
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (myOrders[index] is OnlineOrder) {
                            Routers.push(
                                context, Routers.ORDERONLINEDETAILSPAGE,
                                params: {
                                  "onlineOrder": myOrders[index],
                                  'detail': true
                                });
                          } else {
                            Routers.push(context, Routers.ORDEROFFINEDETAILPAGE,
                                params: {
                                  "offineOrder": myOrders[index],
                                  'detail': true
                                });
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            Image(
                              width: 30,
                              height: 30,
                              image: AssetImage(myOrders[index] is OnlineOrder
                                  ? "assets/images/onlineIcon.png"
                                  : "assets/images/offineIcon.png"),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  myOrders[index].title,
                                  textScaleFactor: 1.3,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text("剩余名额" + myOrders[index].remain.toString())
                              ],
                            ),
                            Expanded(
                                child: Text(
                              myOrders[index].price.toString() + "元",
                              textAlign: TextAlign.right,
                            ))
                          ],
                        ),
                      ),
                    );
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.all:
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.takeNoSubmit:
                    // TODO: Handle this case.
                    break;
                }
              },
            );
          }),
        ));
  }
}
