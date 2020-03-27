import 'package:crowdsourcing/pages/NewOrderPage/NewOrderOnOffline/NewOrderOnOffinePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewOrderStart extends StatelessWidget {
  NewOrderStart(
      {this.titleController,
      this.descriptionController,
      this.platformController,
      this.limitController,
      this.mobileController,
      this.child1,
        this.priceController,
        this.jump,
      this.child});

  final TextEditingController titleController,
      descriptionController,
      platformController,
      limitController,
  priceController,
      mobileController;

  final child, child1;
  final Function jump;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.topLeft,
            color: Colors.grey[100],
            child: SingleChildScrollView(
                child:
                    Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("填写悬赏信息"),
              ),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                child: Row(
                  children: <Widget>[
                    Text("标题"),
                    Expanded(
                      flex: 1,
                      child: TextField(
                          maxLengthEnforced: true,
                          textAlign: TextAlign.end,
                          controller: titleController,
                          style: TextStyle(fontSize: 15),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(16)
                          ],
                          decoration: InputDecoration(
                            //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                            //isdence让该限制取消
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            hintText: "最长16字",
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),
              // SizedBox(height: 5,),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("描述"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                          maxLengthEnforced: true,
                          textAlign: TextAlign.end,
                          controller: descriptionController,
                          maxLines: 2,
                          style: TextStyle(fontSize: 15),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40)
                          ],
                          decoration: InputDecoration(
                            //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                            //isdence让该限制取消
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            hintText: "最长40字",
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("报名条件/限制"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                          maxLengthEnforced: true,
                          textAlign: TextAlign.end,
                          controller: limitController,
                          maxLines: 3,
                          style: TextStyle(fontSize: 15),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(40)
                          ],
                          decoration: InputDecoration(
                            //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                            //isdence让该限制取消
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            hintText: "最长60字，选填",
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          )),
                    )
                  ],
                ),
              ),

              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 35, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("设备类型"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    child
                  ],
                ),
              ),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("接单截止时间"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    child1
                  ],
                ),
              ),
              Container(
//          height: 35,
                decoration: BoxDecoration(color: Colors.white),
                padding: const EdgeInsets.only(left: 10, right: 15),
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("悬赏金额"),
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextField(
                          maxLengthEnforced: true,
                          textAlign: TextAlign.end,
                          controller: priceController,
                          style: TextStyle(fontSize: 15),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(5),
                            WhitelistingTextInputFormatter(RegExp("[0-9/.]"))
                          ],
                          decoration: InputDecoration(
                            //decoration设置后让textfiled有了默认最小尺寸，因此我们设置
                            //isdence让该限制取消
                            isDense: true,
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            hintText: "金额决定接单速度哦",
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          )),
                    ),
                  ],
                ),
              ),
            ])),
          ),
        ),
        Container(
          color: Colors.grey[100],
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide.none),
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "下一步",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    jump(1.0);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
