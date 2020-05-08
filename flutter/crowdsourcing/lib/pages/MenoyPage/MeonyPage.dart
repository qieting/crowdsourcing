import 'package:crowdsourcing/i10n/localization_intl.dart';
import 'package:crowdsourcing/models/OrderShowHelp/OffineOrderWithPeople.dart';
import 'package:crowdsourcing/models/OrderShowHelp/OnlineOrderWithPeople.dart';
import 'package:crowdsourcing/models/OrderShowHelp/OrderWithPeople.dart';
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

  void changeTab(int index) {
    this.moneyPageState.changeState(index);
  }
}

class MoneyPageState extends State<MoneyPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<OffineOrderWithPeople> offineOrderWithPeoples;
  List<OnlineOrderWithPeople> onlineOrderWithPeoples;
  ScrollController scrollController = new ScrollController();
  List<OrderWithPeople> orderWithPeoples = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeState(0);
    getOrders();
  }

  void changeState(int index) {
    if (index == 0) {
      orderWithPeoples = onlineOrderWithPeoples ?? [];
    } else {
      orderWithPeoples = offineOrderWithPeoples ?? [];
    }
    setState(() {});
  }

  void getOrders() {
    MyDio.getOrders(context, (a, b) {
      int index = orderWithPeoples == offineOrderWithPeoples ? 1 : 0;
      offineOrderWithPeoples = a ?? [];
      onlineOrderWithPeoples = b ?? [];
      changeState(index);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    super.build(context); //必须添加
    return Container(
      child: RefreshIndicator(
          onRefresh: () async {
            getOrders();
            await Future.delayed(Duration(seconds: 2), () {});
            return;
          },
          child: Column(
            children: <Widget>[
              orderWithPeoples.length == 0
                  ? ListTile(
                      title: Text("暂时没有数据"),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Expanded(
                child: ListView.builder(
                    itemCount: orderWithPeoples.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            if (orderWithPeoples == offineOrderWithPeoples) {
                              Routers.push(
                                  context, Routers.ORDEROFFINEDETAILPAGE,
                                  params: {
                                    "offineOrder":
                                        orderWithPeoples[index].order,
                                    'detail': true
                                  });
                            } else {
                              Routers.push(
                                  context, Routers.ORDERONLINEDETAILSPAGE,
                                  params: {
                                    "onlineOrder":
                                        orderWithPeoples[index].order,
                                    'detail': true
                                  });
                            }
                          },
                          child: Card(
                              child: Container(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 5),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        orderWithPeoples[index].order.title,
                                        textScaleFactor: 1.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Image(
                                            image: orderWithPeoples[index]
                                                        .user
                                                        .mYHead ==
                                                    null
                                                ? AssetImage(
                                                    "assets/images/deafaultHead.png")
                                                : NetworkImage(
                                                    orderWithPeoples[index]
                                                        .user
                                                        .mYHead),
                                            height: 25,
                                            width: 25,
                                          ),
                                          Text(
                                            orderWithPeoples[index].user.nick ??
                                                orderWithPeoples[index]
                                                    .user
                                                    .id
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.grey[500]),
                                          )
                                        ],
                                      )
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ),
                                Text(
                                  orderWithPeoples[index]
                                          .order
                                          .price
                                          .toString() +
                                      "元",
                                  textScaleFactor: 1.1,
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          )));
                    }),
              ),
            ],
          )),
    );
  }
}
