import 'package:crowdsourcing/models/object/user.dart';
import 'package:crowdsourcing/net/api.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangeMessage extends StatefulWidget {
  final String filedName;

  ChangeMessage(this.filedName);

  @override
  _ChangeMessageState createState() => _ChangeMessageState();
}

class _ChangeMessageState extends State<ChangeMessage> {
  TextEditingController textEditingController = new TextEditingController();

  String getNotice() {
    switch (widget.filedName) {
      case User.GENDER:
        return "性别只允许填写男或女哦";
      case User.NICK:
        return "好听的昵称更受欢迎哦";
    }
  }

  bool validate(String value) {
    switch (widget.filedName) {
      case User.GENDER:
        if (value.length == 1 && (value == "男" || value == "女")) {
          return true;
        } else {
          return false;
        }
        break;
      case User.NICK:
        if (value.length > 0 && value.length < 9) {
          return true;
        } else {
          return false;
        }
        break;
    }
  }

  Widget getWidget() {
    switch (widget.filedName) {
      case User.GENDER:
        return TextField(
          controller: textEditingController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            WhitelistingTextInputFormatter("[男/女]")
          ],
        );
      case User.NICK:
        return TextField(
          controller: textEditingController,
          inputFormatters: [LengthLimitingTextInputFormatter(8)],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("修改信息"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if(validate(textEditingController.text)){
                MyDio.changeMessage(
                    {widget.filedName: textEditingController.text}, context);
                Navigator.of(context).pop();
                MyToast.toast("修改成功");
              }else{
                MyToast.toast("您的输入不合法");
              }

            },
            child: Text("提交"),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: <Widget>[
            getWidget(),
            Text(
              getNotice(),
              textScaleFactor: 0.8,
              style: TextStyle(color: Colors.grey[500]),
            )
          ],
        ),
      ),
    );
  }
}
