import 'package:crowdsourcing/models/UserModel/UserModel.dart';
import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/routers.dart';
import 'package:crowdsourcing/widgets/ChooseImage/ChooseImage.dart';
import 'package:crowdsourcing/widgets/OneMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的信息"),
      ),
      body: Consumer<UserModel>(
        builder: (context, userModel, child) {
          return Column(
            children: <Widget>[
              OneMessageWidget(
                title: "头像",
                content: ChooseImage(
                  choose: true,
                  height: 80,
                  widget: 80,
                  url: userModel.user.head,
                ),
              ),
              OneMessageWidget(
                title: "id号",
                content: Text(userModel.user.id.toString()),
              ),
              OneMessageWidget(
                title: "昵称",
                content: Text(userModel.user.nick??"未设置"),
                change: (){
                  Routers.push(context, Routers.CHANGEMESSAGE,params: {"name":User.NICK});
                },
              ),
              OneMessageWidget(
                title: "手机号",
                content: Text(userModel.user.phone??"未设置"),
              ),
              OneMessageWidget(
                title: "性别",
                content: Text(userModel.user.gender??"男"),
                change: (){
                  Routers.push(context, Routers.CHANGEMESSAGE,params: {"name":User.GENDER});
                },
              ),
              
            ],
          );
        },
      ),
    );
  }
}
