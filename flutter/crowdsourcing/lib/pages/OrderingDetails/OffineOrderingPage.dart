import 'package:crowdsourcing/models/object/order/offine/OffineOrder.dart';
import 'package:crowdsourcing/models/object/order/offine/OffineOrdering.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OffineOrderingPage extends StatefulWidget {
  final OffineOrder offineOrder;

  OffineOrderingPage(this.offineOrder);

  @override
  _OffineOrderingPageState createState() => _OffineOrderingPageState();
}

class _OffineOrderingPageState extends State<OffineOrderingPage> {
  Future<Map> getOffineOrderingByOrderId() async {
    return await MyDio.getOffineOrderingByOrderId(
        context, widget.offineOrder.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("订单详情（线下"),
      ),
      body: FutureBuilder<Map>(
        future: getOffineOrderingByOrderId(),
        builder: (context, AsyncSnapshot<Map> asyncSnapshot) {
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
              return _createListView(context, asyncSnapshot.data);
              // TODO: Handle this case.
              break;
          }
        },
      ),
    );
  }

  _createListView(context, Map offineOrderings) {
    User user = User.fromJsonMap(offineOrderings['people']);
    OffineOrdering o =
        OffineOrdering.fromJsonMap(offineOrderings['offineOrderings']);
    return SingleChildScrollView(
        child: Container(
            child: Column(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 15),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.offineOrder.title,
                      textScaleFactor: 1.3,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(
                          text: "截至到",
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 13)),
                      TextSpan(
                          text: widget.offineOrder.limitedTime,
                          style: TextStyle(color: Colors.grey[600]))
                    ]))
                  ],
                ),
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: "赏金",
                    style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                TextSpan(
                    text: widget.offineOrder.price.toString() + "元",
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
            padding:
                const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 15),
            decoration: BoxDecoration(color: Colors.white),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                  text: "描述: ",
                  style: TextStyle(color: Colors.grey[400], fontSize: 13)),
              TextSpan(text: widget.offineOrder.describe)
            ]))),
        Container(
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 10, bottom: 5, left: 20, right: 15),
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
                      style: TextStyle(color: Colors.grey[400], fontSize: 13)),
                  TextSpan(text: widget.offineOrder.require)
                ])),
              ],
            )),
        Container(
            margin: const EdgeInsets.only(top: 15),
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 15, bottom: 5, left: 20, right: 15),
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
                    itemCount: widget.offineOrder.buyMessages.length,
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
                                      child: Text(widget.offineOrder
                                          .buyMessages[index].goods)),
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "预估价格：",
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    TextSpan(
                                        text: widget.offineOrder
                                                .buyMessages[index].price
                                                .toString() +
                                            "元",
                                        style:
                                            TextStyle(color: Colors.red[500]))
                                  ]))
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.offineOrder.buyMessages[index]
                                      .location.name ??
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
                        Expanded(
                            child: Column(children: <Widget>[
                          widget.offineOrder.end == null ||
                                  widget.offineOrder.end.province == null
                              ? Text("无需当面提交")
                              : Column(
                                  children: <Widget>[
                                    Row(
                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Text(widget.offineOrder.end.name),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text(
                                          widget.offineOrder.end.phone,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(widget.offineOrder.end
                                        .locationToString(containOthers: true)),
                                  ],
                                ),
                        ])),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                offineOrderings['people'] == null
                    ? Text("暂时无人接单")
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("接单人员信息"),
                          SizedBox(height: 15,),
                          Card(
                              margin: const EdgeInsets.only(left: 6, right: 6),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text("id" + user.id.toString()),
                                      SizedBox(
                                        width: 45,
                                      ),
                                      Text(user.nick ?? "无昵称"),
                                    ],
                                  ),
                                  Text(
                                      "联系方式：" +  (user.phone??"暂无")),
                                  Text(
                                      "接单时间：" + o.createDate.toIso8601String()),
                                  Text("完成时间：" +
                                      (o.finishDate?.toIso8601String() ??
                                      "暂未完成"))
                                ],
                              ))
                        ],
                      )
              ],
            )),
      ],
    )));
  }
}
