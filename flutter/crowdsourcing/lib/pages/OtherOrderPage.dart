import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../routers.dart';

class OtherOrderPage extends StatefulWidget {
  OrderStatus orderStatus;
  bool onLine;

  OtherOrderPage(this.orderStatus, this.onLine);

  @override
  _OtherOrderPageState createState() => _OtherOrderPageState();
}

class _OtherOrderPageState extends State<OtherOrderPage> {
  Future<List> getOnlineOrderingByOrderId() async {
    return await MyDio.getTakeOrders(
        context, widget.orderStatus == OrderStatus.take ? 1 : 2, widget.onLine);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.orderStatus == OrderStatus.take ? "进行中" : "已完成"),
      ),
      body: FutureBuilder<List>(
        future: getOnlineOrderingByOrderId(),
        builder: (context, AsyncSnapshot<List> asyncSnapshot) {
          switch (asyncSnapshot.connectionState) {
            case ConnectionState.none:
            // TODO: Handle this case.
            case ConnectionState.active:
            // TODO: Handle this case.
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              // TODO: Handle this case.
              break;

            case ConnectionState.done:
              if (asyncSnapshot.hasError)
                return Text('Error: ${asyncSnapshot.error}');
              return showOnlieOrdering(context, asyncSnapshot.data);
              // TODO: Handle this case.
              break;
          }
        },
      ),
    );
  }

  Widget showOnlieOrdering(context, List list) {
    List orders = [];
    if (widget.onLine) {
      orders = list.map((it) {
        return OnlineOrder.fromJsonMap(it);
      }).toList();
    } else {
      orders = list.map((it) {
        return OffineOrder.fromJsonMap(it);
      }).toList();
    }
    return Container(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return Card(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (widget.onLine) {
                    Routers.push(context, Routers.ORDERONLINEDETAILSPAGE,
                        params: {"onlineOrder": orders[index], 'detail': true});
                  } else {
                    Routers.push(context, Routers.ORDEROFFINEDETAILPAGE,
                        params: {"offineOrder": orders[index], 'detail': true});
                  }
                },
                child: Row(
                  children: <Widget>[
                    Image(
                      width: 30, height: 30,
                      image: AssetImage(widget.onLine
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
                            Text(orders[index].title, textScaleFactor: 1.3,),
                            SizedBox(
                              width: 35,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        widget.onLine&&widget.orderStatus==OrderStatus.finish?Row(
                          children: <Widget>[
                            RaisedButton(
                              child: Text("查看我的我的提交"),
                              onPressed: (){
                                Routers.push(context, Routers.CHECKPAGE, params: {
                                  'ordering': Provider.of<OnlineOrderingModel>(context,listen: false).findByOrderId((orders[index] as OnlineOrder).id),
                                  'user': null,
                                  'order': orders[index]
                                });
                              },
                            )
                          ],
                        ):SizedBox()
                      ],
                    ),
                    Expanded(child: Text(orders[index].price.toString() + "元",
                      textAlign: TextAlign.right,))
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15,
            );
          },
          itemCount: orders.length),
    );
  }
}
