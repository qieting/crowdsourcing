import 'dart:io';

import 'package:crowdsourcing/common/MyImages.dart';
import 'package:crowdsourcing/models/OrderModel/OffineOrderingModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/ChooseImage.dart';
import 'package:crowdsourcing/widgets/MyImage.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class OrderOnlineDetailsPage extends StatefulWidget {
  final OnlineOrder onlineOrder;

  final bool detail;
  final Function success;

  OrderOnlineDetailsPage({this.onlineOrder, this.detail = false, this.success});

  @override
  _OrderOnlineDetailsPageState createState() => _OrderOnlineDetailsPageState();
}

class _OrderOnlineDetailsPageState extends State<OrderOnlineDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.detail ? "详情" : "预览"),
        ),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                              widget.onlineOrder.title,
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
                                  text: widget.onlineOrder.limitedTime,
                                  style: TextStyle(color: Colors.grey[600]))
                            ]))
                          ],
                        ),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "赏金",
                            style: TextStyle(
                                color: Colors.grey[400], fontSize: 13)),
                        TextSpan(
                            text: widget.onlineOrder.price.toString() + "元",
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
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 13)),
                      TextSpan(text: widget.onlineOrder.describe)
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
                        Row(
                          children: <Widget>[
                            Text(
                              "报名要求/限制:",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(children: [
                                  TextSpan(
                                      text: "剩余名额:",
                                      style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 13)),
                                  TextSpan(
                                      text:
                                          widget.onlineOrder.remain.toString(),
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 18))
                                ]),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: "  ",
                              style: TextStyle(
                                  color: Colors.grey[400], fontSize: 13)),
                          TextSpan(text: widget.onlineOrder.require)
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
                          "步骤信息:",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: widget.onlineOrder.onlineSteps.length,
                            itemBuilder: (context, index) {
                              switch (widget
                                  .onlineOrder.onlineSteps[index].myAction) {
                                case MyAction.upQR:
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                TextSpan(
                                                    text: "扫描二维码",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                              ]))
                                            ],
                                          ),
                                          Text(widget.onlineOrder
                                              .onlineSteps[index].explain),
                                          MyImage(
                                            widget.detail
                                                ? NetworkImage(widget
                                                    .onlineOrder
                                                    .onlineSteps[index]
                                                    .imageUrl)
                                                : FileImage(File(widget
                                                    .onlineOrder
                                                    .onlineSteps[index]
                                                    .imageUrl)),
                                            width: 150,
                                            height: 150,
                                          ),
                                          RaisedButton.icon(
                                              onPressed: () async {
                                                bool success =
                                                    await MyImages.saveImage(
                                                        widget
                                                            .onlineOrder
                                                            .onlineSteps[index]
                                                            .imageUrl);
                                                MyToast.toast(
                                                    success ? "下载成功" : "下载失败");
                                              },
                                              icon: Icon(Icons.file_download),
                                              label: Text("下载二维码"))
                                        ],
                                      ),
                                    ),
                                  );
                                case MyAction.graphicShows:
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                TextSpan(
                                                    text: "图文说明",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                              ]))
                                            ],
                                          ),
                                          Text(widget.onlineOrder
                                              .onlineSteps[index].explain),
                                          MyImage(NetworkImage(widget
                                              .onlineOrder
                                              .onlineSteps[index]
                                              .imageUrl)),
                                        ],
                                      ),
                                    ),
                                  );

                                case MyAction.URL:
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                TextSpan(
                                                    text: "访问网址",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                              ]))
                                            ],
                                          ),
                                          Text(widget.onlineOrder
                                              .onlineSteps[index].explain),
                                          RaisedButton.icon(
                                              onPressed: () async {
                                                Clipboard.setData(ClipboardData(
                                                    text: widget
                                                        .onlineOrder
                                                        .onlineSteps[index]
                                                        .explain));
                                                MyToast.toast("复制成功");
                                              },
                                              icon: Icon(Icons.date_range),
                                              label: Text("复制网址"))
                                        ],
                                      ),
                                    ),
                                  );

                                case MyAction.upImage:
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                TextSpan(
                                                    text: "上传截图",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                              ]))
                                            ],
                                          ),
                                          Text(widget.onlineOrder
                                              .onlineSteps[index].explain),
                                          MyImage(NetworkImage(widget
                                              .onlineOrder
                                              .onlineSteps[index]
                                              .imageUrl)),
                                          ChooseImage()
                                        ],
                                      ),
                                    ),
                                  );

                                case MyAction.upPhone:
                                  return Card(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                    text:
                                                        (index + 1).toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                                TextSpan(
                                                    text: "上传手机号",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    )),
                                              ]))
                                            ],
                                          ),
                                          Text(widget.onlineOrder
                                              .onlineSteps[index].explain),
                                        ],
                                      ),
                                    ),
                                  );
                              }
                            }),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    )),
              ],
            ))),
        bottomNavigationBar: Consumer<OnlineOrderingModel>(
            builder: (context, onlineOrderingModel, child) {
          OnlineOrdering take =
              onlineOrderingModel.getByOnlineOrderId(widget.onlineOrder.id);
          return RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
//              if (widget.detail) {
//                if (take != null) {
//                  if (take.finishDate != null) {
//                  } else {
//                    MyDio.changeOffineOrdering(widget.onlineOrder.id,
//                        success: () {
//                      widget.onlineOrderingModel.finishOfferOrdering(take.id);
//                    });
//                  }
//                  return;
//                } else if (widget.onlineOrder.wancheng >= 2) {}
//                MyDio.addOffineOrdering(widget.onlineOrder.id, success: (data) {
//                  if (data == null) {
//                    MyToast.toast("抢单失败，请重新进入");
//                    return;
//                  }
//                  widget.onlineOrderingModel
//                      .addOffineOrdering(OffineOrdering.fromJsonMap(data));
//                  Navigator.of(context).pop();
//                  MyHomePage.of().push(Routers.ORDEROFFINEDETAILPAGE, params: {
//                    "onlineOrder": widget.onlineOrder,
//                    'detail': true,
//                    "take": true
//                  });
//                });
//              } else {
//                MyDio.addOffineOrder(widget.onlineOrder, context: context,
//                    success: () {
//                  Navigator.of(context).pop();
//                  success();
//                });
//              }
            },
            child: Text(
              widget.detail
                  ? (take != null
                      ? (take.finishDate == null ? "完成提交" : "已完成")
                      : widget.onlineOrder.remain == 0 ? "已被抢完" : '接单')
                  : "发布",
              style: TextStyle(color: Colors.white),
            ),
          );
        }));
  }
}
