import 'package:crowdsourcing/models/object/order/online/OnlineStep.dart';
import 'package:crowdsourcing/widgets/ChooseImage.dart';
import 'package:crowdsourcing/widgets/MyToast/MyToast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddOnlineStepPage extends StatefulWidget {
  @override
  _AddOnlinePageState createState() => _AddOnlinePageState();
}

class _AddOnlinePageState extends State<AddOnlineStepPage> {
  MyAction myAction = MyAction.upQR;
  TextEditingController textEditingController = new TextEditingController();
  ChooseImage chooseImage = ChooseImage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("增加步骤"),
        actions: <Widget>[
          FlatButton(
            child: Text("提交"),
            onPressed: (){
              OnlineStep onlineStep = new OnlineStep();
              String explain =textEditingController.text;
              if(explain.length==0){
                MyToast.toast("文字说明不能为空");
                return;
              }
              onlineStep.explain=explain;
              onlineStep.myAction=myAction;
              String path =chooseImage.path;
              switch(myAction){
                case MyAction.upQR:

                      if(path==null){
                        MyToast.toast("您还没有选择图片");
                        return ;
                      }else{
                        onlineStep.imageUrl=path;
                      }

                  break;
                case MyAction.graphicShows:
                  if(path==null){
                    MyToast.toast("您还没有选择图片");
                    return ;
                  }else{
                    onlineStep.imageUrl=path;
                  }

                  // TODO: Handle this case.
                  break;
                case MyAction.URL:
                  // TODO: Handle this case.
                  break;
                case MyAction.upImage:
                  if(path==null){
                    MyToast.toast("您还没有选择图片");
                    return ;
                  }else{
                    onlineStep.imageUrl=path;
                  }

                  // TODO: Handle this case.
                  break;
                case MyAction.upPhone:
                  // TODO: Handle this case.
                  break;
              }
              Navigator.of(context).pop(onlineStep);


            },
          )
        ],

      ),
      body: Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12.withAlpha(20),
                  borderRadius: BorderRadius.all(Radius.circular(55))),
              margin: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              alignment: Alignment.center,
              child: DropdownButton(
                value: myAction,
                underline: SizedBox(),
                items: [
                  DropdownMenuItem(
                    child: Text("扫描二维码"),
                    value: MyAction.upQR,
                  ),
                  DropdownMenuItem(
                    child: Text("上传网址"),
                    value: MyAction.URL,
                  ),
                  DropdownMenuItem(
                    child: Text("图文说明"),
                    value: MyAction.graphicShows,
                  ),
                  DropdownMenuItem(
                    child: Text("收集截图"),
                    value: MyAction.upImage,
                  ),
                  DropdownMenuItem(
                    child: Text("收集手机号"),
                    value: MyAction.upPhone,
                  ),
                ],
                onChanged: (value) {
                  myAction = value;
                  setState(() {});
                },
              ),
            ),
            StatefulBuilder(
              builder: (context, _setState) {
                switch (myAction) {
                  case MyAction.upQR:
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("文字说明"),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextField(
                                maxLines: 2,
                                controller: textEditingController,
                                minLines: 1,
                                textAlign: TextAlign.start,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                decoration:
                                    InputDecoration(hintText: "例如扫码平台。扫码要求等"),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: <Widget>[
                              Text("上传截图  "),
                              SizedBox(
                                width: 15,
                              ),
                              chooseImage,
                            ],
                          )
                        ],
                      ),
                    );
                  case MyAction.URL:
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("文字说明"),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextField(
                                maxLines: 2,
                                controller: textEditingController,
                                minLines: 1,
                                textAlign: TextAlign.start,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                decoration:
                                    InputDecoration(hintText: "请输入对方需要访问的url"),
                              ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    );
                  case MyAction.upPhone:
                     return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("文字说明"),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextField(
                                    maxLines: 2,
                                    controller: textEditingController,
                                    minLines: 1,
                                    textAlign: TextAlign.start,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50)
                                    ],
                                    decoration:
                                    InputDecoration(hintText: "请输入您的要求说明等"),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    );
                  case MyAction.upImage:
                     return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("文字说明"),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextField(
                                    maxLines: 2,
                                    controller: textEditingController,
                                    minLines: 1,
                                    textAlign: TextAlign.start,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50)
                                    ],
                                    decoration:
                                    InputDecoration(hintText: "请填写注意事项"),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: <Widget>[
                              Text("上传您的案例图  "),
                              SizedBox(
                                width: 15,
                              ),
                              chooseImage,
                            ],
                          )
                        ],
                      ),
                    );
                  case MyAction.graphicShows:
                    return Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("文字说明"),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                  child: TextField(
                                    maxLines: 2,
                                    controller: textEditingController,
                                    minLines: 1,
                                    textAlign: TextAlign.start,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50)
                                    ],
                                    decoration:
                                    InputDecoration(hintText: "请输入对方需要注意的点"),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: <Widget>[
                              Text("上传截图  "),
                              SizedBox(
                                width: 15,
                              ),
                              chooseImage,
                            ],
                          )
                        ],
                      ),
                    );
                  default:
                    return Text("5");
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
