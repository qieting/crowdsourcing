import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/order/offine/BuyMessage.dart';
import 'package:crowdsourcing/models/object/order/offine/location/Location.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';

import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'MyHome/MyHomePage.dart';

class OrderOffineDetailsPage extends StatelessWidget {
  final OffineOrder offineOrder;

  final bool detail;
  final Function success;

  OrderOffineDetailsPage({this.offineOrder, this.detail = false, this.success});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(detail ? "详情" : "预览"),
        ),
        body: SingleChildScrollView(
            child: Container(
                child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 5, left: 20, right: 15),
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          offineOrder.title,
                          textScaleFactor: 1.3,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "截至到",
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13)),
                          TextSpan(
                              text: offineOrder.limitedTime,
                              style: TextStyle(color: Colors.grey[600]))
                        ]))
                      ],
                    ),
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "赏金",
                        style:
                            TextStyle(color: Colors.grey[400], fontSize: 13)),
                    TextSpan(
                        text: offineOrder.price.toString() + "元",
                        style: TextStyle(color: Colors.red, fontSize: 18))
                  ]))
                ],
              ),
            ),
            Divider(
              height: 1,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 20, right: 15),
                decoration: BoxDecoration(color: Colors.white),
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "描述: ",
                      style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                  TextSpan(text: offineOrder.describe)
                ]))),
            Container(
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 10, bottom: 5, left: 20, right: 15),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "报名要求/限制:",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "  ",
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 13)),
                      TextSpan(text: offineOrder.require)
                    ])),
                  ],
                )),
            Container(
                margin: const EdgeInsets.only(top: 15),
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 15, bottom: 5, left: 20, right: 15),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "代买/代拿/代做信息:",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: offineOrder.buyMessages.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Text(offineOrder
                                              .buyMessages[index].goods)),
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                          text: "预估价格：",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                        TextSpan(
                                            text: offineOrder
                                                    .buyMessages[index].price
                                                    .toString() +
                                                "元",
                                            style: TextStyle(
                                                color: Colors.red[500]))
                                      ]))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(offineOrder
                                          .buyMessages[index].location.name ??
                                      "就近购买")
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "终点:",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    Card(
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 0, top: 5, bottom: 15),
                        child: Row(
                          children: <Widget>[
                            Expanded(child: Consumer<OffineOrderingModel>(
                                builder: (context, offineOrderingModel, child) {
                              bool take =
                                  offineOrderingModel.hasTake(offineOrder.id);
                              return Column(children: <Widget>[
                                offineOrder.end == null
                                    ? Text("无需当面提交")
                                    : Column(
                                        children: <Widget>[
                                          Row(
                                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Text(take
                                                  ? offineOrder.end.name
                                                  : "接单后可查看姓名和联系方式"),
                                              SizedBox(
                                                width: 30,
                                              ),
                                              Text(
                                                take
                                                    ? offineOrder.end.phone
                                                    : "",
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(offineOrder.end.locationToString(
                                              containOthers: take)),
                                        ],
                                      ),
                              ]);
                            })),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ))),
        bottomNavigationBar: Consumer<OffineOrderingModel>(
            builder: (context, offineOrderingModel, child) {
          OffineOrdering take =
              offineOrderingModel.getByOfferOrderId(offineOrder.id);
          return RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              if (detail) {
                if (take != null) {
                  if (take.finishDate != null) {

                  } else {
                    MyDio.changeOffineOrdering(offineOrder.id, success: () {
                      offineOrderingModel.finishOfferOrdering(take.id);
                      Navigator.of(context).pop();
                      MyToast.toast("提交成功");
                    });
                  }
                  return;
                } else if (offineOrder.remain >= 0) {}
                MyDio.addOffineOrdering(offineOrder.id, success: (data) {
                  if (data == null) {
                    MyToast.toast("抢单失败，请重新进入");
                    return;
                  }
                  offineOrderingModel
                      .addOffineOrdering(OffineOrdering.fromJsonMap(data));
                  Navigator.of(context).pop();
                  MyHomePage.of().push(Routers.ORDEROFFINEDETAILPAGE, params: {
                    "offineOrder": offineOrder,
                    'detail': true,
                    "take": true
                  });
                });
              } else {
                MyDio.addOffineOrder(offineOrder, context: context,
                    success: () {
                  Navigator.of(context).pop();
                  success();
                });
              }
            },
            child: Text(
              detail
                  ? (take != null
                      ? (take.finishDate == null ? "完成提交" : "已完成")
                      : offineOrder.remain >= 2 ? "已被接走" : '接单')
                  : "发布",
              style: TextStyle(color: Colors.white),
            ),
          );
        }));
  }
}
