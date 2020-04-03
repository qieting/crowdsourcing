import 'package:crowdsourcing/models/OrderModel/OffineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
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
                      child: GestureDetector(
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
                                  "onlineOrder": myOrders[index],
                                  'detail': true
                                });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(myOrders[index].title),
                                Text(myOrders[index].price.toString())
                              ],
                            ),
                            GestureDetector(
                              onTap: (){

                              },
                              child: Row(
                                children: <Widget>[
                                  Text(
                                      "剩余名额" + myOrders[index].remain.toString()),
                                  Text("进行中" +
                                      (myOrders[index].total -
                                              myOrders[index].remain -
                                              myOrders[index].finish)
                                          .toString()),
                                  Text("进行中" +
                                      (myOrders[index].finish)
                                          .toString())
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.submit:
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.finish:
                    // TODO: Handle this case.
                    break;
                  case OrderStatus.no:
                    return Card(
                      child: GestureDetector(
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
                                  "onlineOrder": myOrders[index],
                                  'detail': true
                                });
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(myOrders[index].title),
                                Text(myOrders[index].price.toString())
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("剩余名额" + myOrders[index].remain.toString())
                              ],
                            )
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
