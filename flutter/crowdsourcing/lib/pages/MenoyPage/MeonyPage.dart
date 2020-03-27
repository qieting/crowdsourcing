import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/Order.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoneyPage extends StatefulWidget {
  MoneyPageState moneyPageState;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    moneyPageState = MoneyPageState();
    return moneyPageState;
  }

  void changeTab( int index) {
    this.moneyPageState.changeState(index);
  }
}

class MoneyPageState extends State<MoneyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<OffineOrder> offineOrders;
  List<OnlineOrder> onlineOrders;

  List<Order> orders = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrders();
  }

  void changeState( int index) {
    if (index== 0) {
      orders = onlineOrders ?? [];
    } else {
      orders = offineOrders ?? [];
    }
    setState(() {});
  }

  void getOrders() {

      MyDio.getOffineOrders(context, (t) {
        offineOrders = t;
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context);//必须添加
    return Container(
      child: orders.length == 0
          ? ListTile(
              title: Text("暂时没有数据"),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      if (orders == offineOrders) {
                        Routers.push(context, Routers.ORDEROFFINEDETAILPAGE,
                            params: {
                              "offineOrder": orders[index],
                              'detail': true
                            });
                      } else {
                        orders = offineOrders ?? [];
                      }
                    },
                    child: ListTile(title: Text(orders[index].title)));
              }),
    );
  }
}
