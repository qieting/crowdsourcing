import 'dart:convert';

import 'package:crowdsourcing/models/OrderModel/OnlineOrderModel.dart';
import 'package:crowdsourcing/models/OrderModel/OnlineOrderingModel.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrder.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineOrdering.dart';
import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/MyUrl.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyImage.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CheckPage extends StatefulWidget {
  final OnlineOrdering onlineOrdering;
  final User user;
  final OnlineOrder onlineOrder;

  CheckPage(this.onlineOrdering, this.user, this.onlineOrder) {

  }

  @override
  _CheckPageState createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提交详情"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[

            Expanded(
                child: ListView.separated(

                    primary: false,
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      switch (widget.onlineOrder.onlineSteps[index].myAction) {
                        case MyAction.upQR:
                          return Card(
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Text.rich(TextSpan(children: [
                                        TextSpan(
                                            text: (index + 1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        TextSpan(
                                            text: "扫描二维码(已忽略图)",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ]))
                                    ],
                                  ),
                                  Text(widget
                                      .onlineOrder.onlineSteps[index].explain),
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
                                            text: (index + 1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        TextSpan(
                                            text: "图文说明（已忽略图）",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ]))
                                    ],
                                  ),
                                  Text(widget
                                      .onlineOrder.onlineSteps[index].explain),
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
                                            text: (index + 1).toString(),
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
                                  Text(widget
                                      .onlineOrder.onlineSteps[index].explain),
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
                                            text: (index + 1).toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                        TextSpan(
                                            text: "上传截图（已忽略例图）",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ]))
                                    ],
                                  ),
                                  Text(widget
                                      .onlineOrder.onlineSteps[index].explain),
                                  MyImage(
                                    NetworkImage(MyUrl.imageUrl +
                                        widget.onlineOrdering.id.toString() +
                                        "\$\$" +
                                        widget.onlineOrdering.resources[index]),
                                    width: 150,
                                    height: 150,
                                  ),
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
                                            text: (index + 1).toString(),
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
                                  Text(widget
                                      .onlineOrder.onlineSteps[index].explain),
                                  Text(widget.onlineOrdering.resources[index])
                                ],
                              ),
                            ),
                          );
                      }
                    },
                    itemCount: widget.onlineOrder.onlineSteps.length)),
           widget!=null? ( widget.onlineOrdering.finishDate == null
                ? Row(
                    children: <Widget>[
                      Expanded(
                        child:
                      RaisedButton(
                        onPressed: () {
                          MyDio.finishOnlineOrdering(context, widget.onlineOrdering.id, true, null, (i){
                            Provider.of<OnlineOrderingModel>(context,listen: false)
                            .refresh(OnlineOrdering.fromJsonMap(i));
                            widget.onlineOrdering.finishDate
                            =OnlineOrdering.fromJsonMap(i).finishDate;
                            widget.onlineOrder.submit--;
                            widget.onlineOrder.finish++;
                            setState(() {

                            });
                          });
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text("审核通过"),
                        shape: Border(
                          right: BorderSide(width: 1,color: Colors.grey)
                        ) ,
                      )),
                      Expanded(
                        child:RaisedButton(
                        onPressed: () async{
                          String reason =await showReasonDialog();
                          if(reason!=null){
                            MyDio.finishOnlineOrdering(context, widget.onlineOrdering.id, false, reason, (i){


                              widget.onlineOrdering.finishDate
                              =OnlineOrdering.fromJsonMap(i).finishDate;
                              widget.onlineOrdering.reason=reason;
                             // Provider.of<OnlineOrderModel>(context,listen: false).
                              widget.onlineOrder.submit--;
                              widget.onlineOrder.finish++;

                              setState(() {

                              });
                            });

                          }
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text("审核不通过"),
                      ))
                    ],
                  )
                : Row(
              children: <Widget>[
                Expanded(
                  child:RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: Text(widget.onlineOrdering.reason ?? "已经审核通过"),
                  ),
                )
              ],
            )):
               Row(
                 children: <Widget>[
                   Expanded(
                     child: RaisedButton(
                       child: Text(widget.onlineOrdering.finishDate==null?"等待审核":(widget.onlineOrdering.reason==null?"审核通过":widget.onlineOrdering.reason)),
                     ) ,
                   )
                 ],
               )
          ],
        ),
      ),
    );
  }


  Future<String> showReasonDialog() {
     // 默认复选框不选中
    return showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController textEditingController = new TextEditingController();
        return AlertDialog(
          title: Text("请输入不通过的理由"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: textEditingController,
                maxLines: 2,

                decoration: InputDecoration(
                  hintText: "请描述可以证实的拒绝理由"
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () {
                //执行删除操作
                if(textEditingController.text.length<3){
                  MyToast.toast("理由不可过短");
                  return;
                }
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
