import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:flutter/material.dart';

class OnlineOrderingPage extends StatefulWidget {
  OnlineOrder onlineOrder;
  OnlineOrderingPage(this.onlineOrder);
  @override
  _OnlineOrderingPageState createState() => _OnlineOrderingPageState();
}

class _OnlineOrderingPageState extends State<OnlineOrderingPage> {
  Future<Map> getOnlineOrderingByOrderId() async {
    return await MyDio.getOnlineOrderingByOrderId(
        context, widget.onlineOrder.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详细信息（线下）"),
        actions: <Widget>[
          FlatButton(
            child: Text("查看任务详情"),
            onPressed: () {
              Routers.push(context, Routers.ORDERONLINEDETAILSPAGE,
                  params: {"onlineOrder": widget.onlineOrder, 'detail': true});
            },
          )
        ],
      ),
      body: FutureBuilder<Map>(
        future: getOnlineOrderingByOrderId(),
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
              return showOnlieOrdering(context, asyncSnapshot.data);
              // TODO: Handle this case.
              break;
          }
        },
      ),
    );
  }

  Widget showOnlieOrdering(context, Map map) {
    List<OnlineOrdering> onlineOrderings =
        (map["orders"] as List).map<OnlineOrdering>((it) {
      return OnlineOrdering.fromJsonMap(it);
    }).toList();
    List<User> users = (map['peoples'] as List).map<User>((it) {
      return User.fromJsonMap(it);
    }).toList();

    List<OnlineOrdering> finishOrdering = [];
    List<OnlineOrdering> submitOrdering = [];
    for (var i in onlineOrderings) {
      if (i.finishDate != null) {
        finishOrdering.add(i);
      } else if (i.submitDate != null) {
        submitOrdering.add(i);
      }
    }

    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: <Widget>[
            Text("任务总数：" + widget.onlineOrder.total.toString()),
            Text("总被接数：" +
                (widget.onlineOrder.total - widget.onlineOrder.remain)
                    .toString()),
            Text("等待审核：" + widget.onlineOrder.submit.toString()),
            Container(
              height: submitOrdering.length > 15 ? 200 : null,
              child: Card(
                margin: const EdgeInsets.only(left: 6, right: 6),
                child: ListView.separated(
                  shrinkWrap: submitOrdering.length > 15 ? false : true,
                  primary: false,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        User u = users.firstWhere((it) {
                          if (it.id == submitOrdering[index].peopleId) {
                            return true;
                          }
                        });
                        Routers.push(context, Routers.CHECKPAGE, params: {
                          'ordering': submitOrdering[index],
                          'user': u,
                          'order':widget.onlineOrder
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("接单人："),
                              SizedBox(
                                width: 15,
                              ),
                              Text(submitOrdering[index].peopleId.toString())
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("接单时间："),
                              SizedBox(
                                width: 15,
                              ),
                              Text(submitOrdering[index]
                                  .createDate
                                  .toIso8601String())
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("完成时间："),
                              SizedBox(
                                width: 15,
                              ),
                              Text((submitOrdering[index]
                                  .finishDate?.toIso8601String())??"暂无")
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: submitOrdering.length,
                ),
              ),
            ),
            Text("已完成：" + widget.onlineOrder.finish.toString()),
            Container(
              height: finishOrdering.length > 15 ? 200 : null,
              child: Card(
                margin: const EdgeInsets.only(left: 6, right: 6),
                child: ListView.separated(
                  primary: false,
                  shrinkWrap: finishOrdering.length > 15 ? false : true,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        User u = users.firstWhere((it) {
                          if (it.id == finishOrdering[index].peopleId) {
                            return true;
                          }
                        });
                        Routers.push(context, Routers.CHECKPAGE, params: {
                          'ordering': finishOrdering[index],
                          'user': u
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("接单人："),
                              SizedBox(
                                width: 15,
                              ),
                              Text(finishOrdering[index].peopleId.toString())
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("接单时间："),
                              SizedBox(
                                width: 15,
                              ),
                              Text(finishOrdering[index]
                                  .createDate
                                  .toIso8601String())
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text("完成时间："),
                              SizedBox(
                                width: 15,
                              ),
                              Text(finishOrdering[index]
                                  .finishDate
                                  .toIso8601String())
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: finishOrdering.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
